#### Preamble ####
# Purpose: Cleans the raw marriage data from opendata Toronto
# Author: Aman Rana
# Date: 19 September 2024
# Contact: aman.rana@mail.utoronto.ca
# License: MIT
# Pre-requisites: None
# Any other information needed? None

#### Workspace setup ####
library(tidyverse)

#### Clean data ####
raw_data <- read_csv("data/raw_data/marriage_raw_data.csv")

cleaned_data <- 
  raw_data |>
  janitor::clean_names() |>
  separate(col = time_period,
           into = c("year", "month"),
           sep="-") |>
  mutate(date = lubridate::ymd(paste(year, month, "01", sep="-")))

#### Save data ####
write_csv(cleaned_data, "data/analysis_data/marriage_analysis_data.csv")
