# Bike-Sharing Demand Prediction App with R Shiny and Leaflet

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

The image below showcases the **"All Cities"** selection mode, where weather and demand data from multiple locations are visualized simultaneously.

<img width="959" alt="Screenshot 2025-05-23 222801" src="https://github.com/user-attachments/assets/2773d94c-47b1-4b60-b2b4-0421a4133545" />

This a focused view of **Suzhou** selected from the dropdown. The map zooms in on Suzhou with a pinpoint marker, providing localized data insights.

---

## 🔍 Features & Functionality

### 1. **Global Forecast Map (Max Bike Demand)**
- A **Leaflet-based interactive map** that displays the **maximum predicted hourly demand** over the next 5 days for each city.
- Cities are represented by **colored circles**:
  - **Green**: Low demand
  - **Yellow**: Moderate demand
  - **Red**: High demand
- Hover tooltip: Shows city name and predicted max demand.

### 2. **City-Level Daily Forecast**
- Clicking on a city marker reveals:
  - A **bar chart** showing daily predicted demand over 5 days.
  - A **data table** of weather metrics (temperature, humidity, wind speed, precipitation).
- Allows users to understand how weather variations affect demand.

### 3. **Predictive Model**
- Trained on **Seoul public bike-sharing dataset**.
- Features used for prediction:
  - Hour of the day
  - Day of the week
  - Weather conditions (temp, humidity, wind speed, clouds, etc.)
- The trained model is reused to predict bike demand in other cities using weather forecasts.

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
