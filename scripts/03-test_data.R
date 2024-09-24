#### Preamble ####
# Purpose: Tests Data for Negative Numbers and NAs
# Author: Aman Rana
# Date: 24 September 2024
# Contact: aman.rana@mail.utoronto.ca
# License: MIT
# Pre-requisites: NA
# Any other information needed? NA


#### Workspace setup ####
library(tidyverse)

#### Test data ####
data <- read.csv("data/analysis_data/expenditure_analysis_data.csv")

# Test for negative numbers in all columns
negative_test <- map(data, ~ min(.x, na.rm = TRUE) <= 0)

# Test for NAs in all columns
na_test <- map(data, ~ any(is.na(.x)))

# Print the results
negative_test
na_test