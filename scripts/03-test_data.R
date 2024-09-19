#### Preamble ####
# Purpose: Tests the dtaa from opendata toronto
# Author: Aman Rana
# Date: 19 September 2024
# Contact: aman.rana@mail.utoronto.ca
# License: MIT
# Pre-requisites: None
# Any other information needed? None


#### Workspace setup ####
library(tidyverse)

#### Test data ####
data <- read.csv("data/analysis_data/marriage_analysis_data.csv")

#Test for negative numbers
data$marriage_licenses |> min() <= 0

# Test for NAs
all(is.na(data$marriage_licenses))


