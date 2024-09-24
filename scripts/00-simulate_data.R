#### Preamble ####
# Purpose: Simulates... [...UPDATE THIS...]
# Author: Rohan Alexander [...UPDATE THIS...]
# Date: 11 February 2023 [...UPDATE THIS...]
# Contact: rohan.alexander@utoronto.ca [...UPDATE THIS...]
# License: MIT
# Pre-requisites: [...UPDATE THIS...]
# Any other information needed? [...UPDATE THIS...]


#### Workspace setup ####
library(tidyverse)
set.seed(170034692)

#### Simulate data ####
date_seq <- seq(from = as.Date('2023-01-01'), to = as.Date('2023-12-31'), by = 'day')

# Departments and Consultants
departments <- c("HR", "Finance", "IT", "Operations", "Marketing")
consultants <- c("Consultant A", "Consultant B", "Consultant C", "Consultant D", "Consultant E")

# Expenditure categories
categories <- c("Travel", "Supplies", "Software", "Miscellaneous")

# Simulate the expenditures using a normal distribution
expenditure_values <- rnorm(n = length(date_seq), mean = 5000, sd = 1500)

# Create the dataframe
consulting_data <- tibble(
  Date = date_seq,
  Year = year(date_seq),  # Extract the year
  Department = sample(departments, size = length(date_seq), replace = TRUE),
  Consultant = sample(consultants, size = length(date_seq), replace = TRUE),
  Expenditure = round(expenditure_values, 2),
  Expenditure_Category = sample(categories, size = length(date_seq), replace = TRUE)
)

# Write to CSV file
write_csv(consulting_data, "data/analysis_data/sim_consulting_analysis_data.csv")



