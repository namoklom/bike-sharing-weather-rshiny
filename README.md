# Bike-Sharing Demand Prediction Application with R Shiny and Leaflet

## 👤 Author

| Name            | Role              | LinkedIn                                      |
|-----------------|-------------------|-----------------------------------------------|
| Jason Emmanuel  | Data Scientist | [linkedin.com/in/jasoneml](https://www.linkedin.com/in/jasoneml/) |

An interactive web application built using **R Shiny** that forecasts hourly **bike-sharing demand** based on **weather conditions**. The app uses real-time weather data from the **OpenWeather API** and a regression model trained on historical Seoul bike-sharing data to make demand predictions for multiple global cities.

---

## 🌐 Project Overview

Urban mobility services like bike-sharing are heavily influenced by environmental conditions. This app helps city planners and service providers **visualize, interpret, and plan** for expected demand by combining real-time weather forecasting with machine learning.

The app supports **five cities**:
- 🗽 **New York, USA**
- 🗼 **Paris, France**
- 🏯 **Suzhou, China**
- 🎡 **London, UK**
- 🏙️ **Seoul, South Korea**

These cities were chosen for their similarity in bike-sharing fleet sizes and urban density to Seoul.

---

## 📷 Application Preview

Take a look at how the Bike-Sharing Demand Prediction App works in action:

![Screenshot 2025-05-23 222427](https://github.com/user-attachments/assets/dd8bda4c-b142-473f-bb16-466046f82204)

The image above showcases the **"All Cities"** selection mode, where weather and demand data from multiple locations are visualized simultaneously.

<img width="959" alt="Screenshot 2025-05-23 222801" src="https://github.com/user-attachments/assets/2773d94c-47b1-4b60-b2b4-0421a4133545" />

This a focused view of **Suzhou** selected from the dropdown. The map zooms in on Suzhou with a pinpoint marker, providing localized data insights.

![Screenshot 2025-05-23 222538](https://github.com/user-attachments/assets/04ae6c80-f8bd-4df9-a30d-3c42195ec841)

When **Seoul** is selected from the dropdown menu, the application provides detailed weather information and bike-sharing demand predictions for the city. The current weather in Seoul shows a temperature of 14.99°C, visibility of 10,000 meters, humidity at 90%, wind speed of 3.61 m/s, and the timestamp is 2025-05-23 18:00:00. The left panel features interactive plots, including a 5-day temperature trend showing recent temperature changes, a bike-sharing demand prediction trend forecasting upcoming demand, and a humidity versus demand plot to explore their relationship. This view helps users quickly understand how weather factors influence bike-sharing demand in Seoul.

---
## EDA ggplot2


<img src="https://github.com/user-attachments/assets/e261edfc-9eb7-4ecf-9e9a-b752581fd47b" width="500"/>

This scatter plot titled **"Bike Rentals Over Time"** visualizes the daily bike rental activity in Seoul over the course of 2018. Each point on the graph represents the number of bikes rented on a specific date, with the x-axis showing the date and the y-axis representing the rental count. To avoid overplotting and ensure better visibility of overlapping points, the plot uses a transparency level (alpha = 0.3) and a purple color for the data points. The visualization reveals seasonal trends, with higher rental activity observed during the warmer months (particularly between late spring and early autumn), and significantly fewer rentals during the winter period. This plot is helpful for understanding usage patterns, spotting fluctuations in demand, and providing insights for transportation planning or policy-making related to bike-sharing systems.

<img src="https://github.com/user-attachments/assets/877257f6-4ba9-46a0-8c5a-fe22cfb94f89" width="500"/>

The scatter plot titled **"Bike Rentals Over Time Colored by Hour"** visualizes the number of bikes rented in Seoul throughout 2018, with an additional dimension represented by color: the hour of the day when the rental occurred. Each point corresponds to a rental count on a specific date and hour, with the x-axis representing the date, the y-axis showing the number of bikes rented, and the color indicating the hour (from 0 to 23). The color scale helps highlight patterns in rental behavior throughout the day, revealing trends such as increased rentals during certain hours—typically morning and evening commute times. The use of transparency (`alpha = 0.5`) improves readability by reducing overplotting, and the color legend allows us to distinguish hourly trends across the entire year. This enhanced visualization provides deeper insight into both temporal and daily cyclical patterns in bike-sharing usage.

<img src="https://github.com/user-attachments/assets/8a12e528-86a4-438a-a462-b903840b0046" width="500"/>

The plot titled **"Histogram and Kernel Density of Rented Bike Count"** provides a statistical overview of the distribution of bike rental counts in Seoul. The histogram represents the frequency distribution of the number of bikes rented, normalized so that the y-axis shows probability density rather than raw counts. This normalization allows for comparison with the overlaid red kernel density curve, which estimates the continuous probability distribution of the data. The histogram uses a bin width of 50 and is styled with sky blue fill and black borders, while the smooth red line provides a visual indication of where rental counts are concentrated. The plot reveals a right-skewed distribution, with most rental counts clustering at lower values and tapering off at higher counts. This visualization is useful for understanding the overall pattern and spread of rental activity, identifying peaks in demand, and evaluating the likelihood of various rental count levels.

<img src="https://github.com/user-attachments/assets/7e7ae650-ca4c-4035-b872-e1d7e6b8af83" width="500"/>

The plot titled **"Correlation of Rented Bike Count and Temperature by Season"** displays scatter plots for each season (Winter, Spring, Summer, Autumn), illustrating the relationship between temperature and the number of rented bikes. Each point represents a rental event, with its position determined by temperature and bike count, and its color indicating the hour of the day. The use of `facet_wrap` divides the data by season into four subplots, enabling easy comparison of seasonal trends. The opacity is set to 0.5 to reduce overplotting, revealing underlying patterns more clearly. The plot suggests a strong positive correlation between temperature and bike rentals, particularly during Spring, Summer, and Autumn. In Winter, this relationship is weaker, likely due to cold temperatures discouraging bike use. The color gradient shows that certain hours, especially midday to early evening, are associated with higher rental counts. Overall, this visualization effectively highlights how temperature and time of day interact to influence bike rental behavior across seasons.

<img src="https://github.com/user-attachments/assets/76bd130a-b2ee-4769-a48b-fdc2fc55f0da" width="500"/>

The scatter plot illustrates the overall relationship between **temperature** and the **number of rented bikes**, with data points colored by the **hour of the day**. Each point represents an observation, and the color gradient provides a temporal dimension, helping to identify when during the day bike rentals are more or less frequent. The use of transparency (`alpha = 1/5`) helps reduce visual clutter and reveals dense patterns within the dataset. The plot shows a clear positive correlation: as temperature increases, the number of bike rentals also tends to increase. Notably, warmer temperatures (above 10°C) see a significant rise in rentals, particularly during midday and early evening hours (lighter colors). Cooler temperatures, especially those below 0°C, correspond with lower rental activity. This plot effectively captures how both **temperature** and **time of day** jointly influence bike rental behavior in Seoul.

<img src="https://github.com/user-attachments/assets/e8c1cad6-a467-4e24-8675-fbe00fdbf47e" width="500"/>

The boxplot visualization displays how **bike rental activity** varies by **hour of the day** across different **seasons**. Each panel corresponds to a season—Winter, Spring, Summer, and Autumn—allowing for side-by-side comparison.

Across all seasons, there are clear peaks in rental activity during **morning (around 8 AM)** and **evening (around 5–6 PM)** hours, indicating common commuting times. These peaks are more pronounced in **Spring**, **Summer**, and **Autumn**, with Summer showing the highest rental counts and greater variability throughout the day. In contrast, **Winter** shows relatively flat rental patterns, likely due to colder weather discouraging biking.

The boxplots also reveal **outliers** (dots) during peak hours, particularly in warmer seasons, suggesting occasional surges in demand. The interquartile ranges (IQRs) widen during peak times, showing more variability in how many bikes are rented during those hours. 

This visualization effectively communicates how both **seasonality** and **daily rhythms** influence bike rental behavior in Seoul, with Summer afternoons and Autumn mornings being the most active and Winter being the least.

<img src="https://github.com/user-attachments/assets/eadb0d40-8db4-451d-bcea-f6d714dd30f2" width="500"/>

The plot presents the daily total rainfall and snowfall data for the year 2018 in Seoul. The x-axis represents the dates throughout the year, while the y-axis shows the total precipitation in millimeters. Two lines distinguish the types of precipitation: rainfall is shown in blue and snowfall in grey.

This visualization highlights seasonal patterns in precipitation. Snowfall is concentrated in the colder months, particularly January and December, while rainfall is more frequent and intense during the warmer months, especially between June and September. This kind of analysis is useful for understanding weather trends and supporting planning for transportation, public safety, and infrastructure maintenance.

---

## 📊 Technologies Used

| Tool/Library        | Purpose                                  |
|---------------------|------------------------------------------|
| **R Shiny**         | Web app framework for interactive UI     |
| **Leaflet (R)**     | Mapping and geospatial visualization     |
| **OpenWeather API** | Real-time weather forecast data          |
| **ggplot2**         | Data visualization (bar plots, etc.)     |
| **dplyr, tidyr**    | Data manipulation and wrangling          |
| **caret**           | Model training and prediction            |

---

## ⚙️ Installation & Setup

### Prerequisites
- R >= 4.2.0
- RStudio (optional but recommended)
- OpenWeather API Key (free tier available at [openweathermap.org](https://openweathermap.org/api))

### Installation Steps

```r
# 1. Install required packages
install.packages(c("shiny", "leaflet", "httr", "jsonlite", 
                   "ggplot2", "dplyr", "tidyr", "lubridate", "scales", "caret"))

# 2. Clone or download this repository
git clone https://github.com/namoklom/bike-sharing-weather-rshiny.git
cd bike-demand-shiny

# 3. Open the app.R file in RStudio or run it via R
shiny::runApp(".")
