library(shiny)
library(leaflet)

shinyUI(
  fluidPage(
    padding = 5,
    titlePanel("Bike-sharing Demand Prediction App"),
    sidebarLayout(
      sidebarPanel(
        actionButton("refresh_btn", "Weather Data Refresh"),
        br(), br(),
        selectInput("selected_city", "Select City:", choices = NULL),
        
        plotOutput("temp_line", height = "200px"),          
        plotOutput("bike_line", height = "200px", click = "plot_click"),
        verbatimTextOutput("bike_date_output"),
        
        plotOutput("humidity_pred_chart", height = "200px") 
      ),
      mainPanel(
        leafletOutput("city_bike_map", height = "600px")
      )
    )
  )
)
