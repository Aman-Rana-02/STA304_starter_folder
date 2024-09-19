#### Preamble ####
# Purpose: Simulates Marriage Data
# Author: Aman Rana
# Date: 19 September 2024
# Contact: aman.rana@mail.utoronto.ca
# License: MIT
# Pre-requisites: None
# Any other information needed? None


#### Workspace setup ####
library(tidyverse)

#### Simulate data ####
# Set the date range for simulation (one year of data)
set.seed(170034692)  # For reproducibility
date_seq <- seq(from = as.Date('2023-01-01'), to = as.Date('2023-12-31'), by = 'day')

# Simulate the number of marriage licenses issued per day using a Poisson distribution with lambda = 10
marriage_licenses <- rpois(n = length(date_seq), lambda = 10)

# Create the dataframe
marriage_data <- tibble(
  Date = date_seq,
  Licenses_Issued = marriage_licenses,
  Day_of_Week = wday(date_seq, label = TRUE, week_start = 1),  # Extract day of the week
  Month = month(date_seq, label = TRUE)  # Extract month
)

write_csv(marriage_data, "data/analysis_data/sim_marriage_analysis_data.csv")



