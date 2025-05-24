# ----
library(tidyverse)

url <- "https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBMDeveloperSkillsNetwork-RP0321EN-SkillsNetwork/labs/datasets/seoul_bike_sharing.csv"

seoul_bike_sharing <- read_csv(url,
                               col_types = cols(
                                 DATE = col_character(),
                                 RENTED_BIKE_COUNT = col_double(),
                                 HOUR = col_double(),
                                 TEMPERATURE = col_double(),
                                 HUMIDITY = col_double(),
                                 WIND_SPEED = col_double(),
                                 VISIBILITY = col_double(),
                                 DEW_POINT_TEMPERATURE = col_double(),
                                 SOLAR_RADIATION = col_double(),
                                 RAINFALL = col_double(),
                                 SNOWFALL = col_double(),
                                 SEASONS = col_factor(),
                                 HOLIDAY = col_factor(),
                                 FUNCTIONING_DAY = col_factor()
                               ))


glimpse(seoul_bike_sharing)
head(seoul_bike_sharing)

# ----
seoul_bike_sharing <- seoul_bike_sharing %>%
  mutate(DATE = as.Date(DATE, format = "%d/%m/%Y"))

# ----
seoul_bike_sharing <- seoul_bike_sharing %>%
  mutate(HOUR = factor(HOUR, levels = 0:23, ordered = TRUE))

# ----
str(seoul_bike_sharing)

# ----
sum(is.na(seoul_bike_sharing))

# ----
summary(seoul_bike_sharing)

# ----
table(seoul_bike_sharing$HOLIDAY)

# ----
holiday_counts <- table(seoul_bike_sharing$HOLIDAY)
holiday_percentage <- (holiday_counts["Holiday"] / sum(holiday_counts)) * 100
holiday_percentage

# ----
expected_records <- 24 * 365
expected_records

# ----
table(seoul_bike_sharing$FUNCTIONING_DAY)

# ----
library(dplyr)

seasonal_precipitation <- seoul_bike_sharing %>%
  group_by(SEASONS) %>%
  summarize(
    total_rainfall = sum(RAINFALL, na.rm = TRUE),
    total_snowfall = sum(SNOWFALL, na.rm = TRUE)
  )

seasonal_precipitation

# ----
library(ggplot2)

# ----
ggplot(seoul_bike_sharing, aes(x = DATE, y = RENTED_BIKE_COUNT)) +
  geom_point(alpha = 0.3, color = "purple") +
  labs(title = "Bike Rentals Over Time",
       x = "Date",
       y = "Rented Bike Count") +
  theme_light()

# ----
ggplot(seoul_bike_sharing, aes(x = DATE, y = RENTED_BIKE_COUNT, color = as.factor(HOUR))) +
  geom_point(alpha = 0.5) +
  labs(title = "Bike Rentals Over Time Colored by Hour",
       x = "Date",
       y = "Rented Bike Count",
       color = "Hour") +
  theme_minimal()

# ----
ggplot(seoul_bike_sharing, aes(x = RENTED_BIKE_COUNT)) +
  geom_histogram(aes(y = ..density..), binwidth = 50, fill = "skyblue", color = "black", alpha = 0.6) +
  geom_density(color = "red", size = 1) +
  labs(title = "Histogram and Kernel Density of Rented Bike Count",
       x = "Rented Bike Count",
       y = "Density") +
  theme_minimal()

# ----
ggplot(seoul_bike_sharing, aes(x = TEMPERATURE, y = RENTED_BIKE_COUNT, color = as.factor(HOUR))) +
  geom_point(alpha = 0.5) +
  facet_wrap(~ SEASONS) +
  scale_color_viridis_d(name = "Hour") +
  labs(title = "Correlation of Rented Bike Count and Temperature by Season",
       x = "Temperature (°C)",
       y = "Rented Bike Count") +
  theme_minimal()

# ----
ggplot(seoul_bike_sharing) +
   geom_point(aes(x=TEMPERATURE,y=RENTED_BIKE_COUNT,colour=HOUR),alpha=1/5)

# ----
ggplot(seoul_bike_sharing, aes(x = HOUR, y = RENTED_BIKE_COUNT)) +
  geom_boxplot() +
  facet_wrap(~ SEASONS) +
  labs(title = "Boxplots of Rented Bike Count by Hour and Season",
       x = "Hour of Day",
       y = "Rented Bike Count") +
  theme_minimal()

# ----
daily_precipitation <- seoul_bike_sharing %>%
  group_by(DATE) %>%
  summarize(
    total_rainfall = sum(RAINFALL, na.rm = TRUE),
    total_snowfall = sum(SNOWFALL, na.rm = TRUE)
  )

ggplot(daily_precipitation, aes(x = DATE)) +
  geom_line(aes(y = total_rainfall, color = "Rainfall")) +
  geom_line(aes(y = total_snowfall, color = "Snowfall")) +
  labs(title = "Daily Total Rainfall and Snowfall",
       x = "Date",
       y = "Total (mm)") +
  scale_color_manual(name = "Precipitation Type",
                     values = c("Rainfall" = "blue", "Snowfall" = "grey")) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# ----
days_with_snowfall <- daily_precipitation %>%
  filter(total_snowfall > 0) %>%
  nrow()

days_with_snowfall
