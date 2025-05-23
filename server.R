library(shiny)
library(leaflet)
library(dplyr)
library(ggplot2)

shinyServer(function(input, output, session){
  
  city_weather_bike_df <- eventReactive(input$refresh_btn, {
    generate_city_weather_bike_data()
  }, ignoreNULL = FALSE)
  
  observe({
    req(city_weather_bike_df())
    
    cities_max_bike <- city_weather_bike_df() %>%
      group_by(CITY_ASCII) %>%
      summarise(
        max_bike = max(BIKE_PREDICTION, na.rm = TRUE),
        lat = first(LAT),
        lng = first(LNG),
        label = first(LABEL),
        detailed_label = first(DETAILED_LABEL)
      ) %>% ungroup()
    
    city_choices <- c("All", cities_max_bike$CITY_ASCII)
    
    updateSelectInput(session, "selected_city", choices = city_choices, selected = "All")
    
    session$userData$cities_max_bike <- cities_max_bike
  })
  
  color_levels <- colorFactor(c("green", "yellow", "red"), 
                              levels = c("small", "medium", "large"))
  
  selected_city_data <- reactive({
    req(input$selected_city)
    df <- city_weather_bike_df()
    if (input$selected_city == "All") {
      df
    } else {
      filter(df, CITY_ASCII == input$selected_city)
    }
  })
  
  output$city_bike_map <- renderLeaflet({
    req(input$selected_city)
    cities_max_bike <- session$userData$cities_max_bike
    req(cities_max_bike)
    
    if (input$selected_city == "All") {
      leaflet(cities_max_bike) %>%
        addTiles() %>%
        addCircleMarkers(
          ~lng, ~lat,
          color = ~color_levels(cut(max_bike, breaks=c(-1, 1000, 3000, Inf), labels=c("small","medium","large"))),
          radius = 10,
          popup = ~label
        ) %>%
        setView(lng = mean(cities_max_bike$lng), lat = mean(cities_max_bike$lat), zoom = 2)
    } else {
      selected <- filter(cities_max_bike, CITY_ASCII == input$selected_city)
      leaflet(selected) %>%
        addTiles() %>%
        addMarkers(lng = selected$lng, lat = selected$lat,
                   popup = selected$detailed_label) %>%
        setView(lng = selected$lng, lat = selected$lat, zoom = 10)
    }
  })
  
  output$temp_line <- renderPlot({
    data <- selected_city_data()
    req(nrow(data) > 0)
    
    ggplot(data, aes(x = FORECASTDATETIME, y = TEMPERATURE)) +
      geom_line(color = "blue") +
      geom_point(color = "blue") +
      geom_text(aes(label = round(TEMPERATURE, 1)), vjust = -0.5) +
      labs(title = paste("5-Day Temperature Trend in", input$selected_city),
           x = "Date-Time", y = "Temperature (°C)") +
      theme_minimal()
  })
  
  output$bike_line <- renderPlot({
    data <- selected_city_data()
    req(nrow(data) > 0)
    
    ggplot(data, aes(x = FORECASTDATETIME, y = BIKE_PREDICTION)) +
      geom_line(color = "green") +
      geom_point(color = "green") +
      geom_text(aes(label = round(BIKE_PREDICTION, 0)), vjust = -0.5) +
      labs(title = paste("Bike-sharing Demand Prediction Trend in", input$selected_city),
           x = "Date-Time", y = "Bike Prediction") +
      theme_minimal()
  })
  
  output$bike_date_output <- renderText({
    click <- input$plot_click
    data <- selected_city_data()
    req(click)
    
    clicked_point <- data[which.min(abs(as.numeric(data$FORECASTDATETIME) - as.numeric(click$x)) + 
                                      abs(data$BIKE_PREDICTION - click$y)), ]
    
    paste0("Date-Time: ", clicked_point$FORECASTDATETIME, "\n",
           "Bike Prediction: ", round(clicked_point$BIKE_PREDICTION, 0))
  })
  
  output$humidity_pred_chart <- renderPlot({
    data <- selected_city_data()
    req(nrow(data) > 0)
    
    ggplot(data, aes(x = HUMIDITY, y = BIKE_PREDICTION)) +
      geom_point(color = "purple") +
      geom_smooth(method = "lm", formula = y ~ poly(x, 4), se = FALSE, color = "red") +
      labs(title = paste("Humidity vs Bike-sharing Demand Prediction in", input$selected_city),
           x = "Humidity (%)", y = "Bike Prediction") +
      theme_minimal()
  })
  
})