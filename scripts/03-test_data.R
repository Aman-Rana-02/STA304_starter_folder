#### Preamble ####
# Purpose: Tests... [...UPDATE THIS...]
# Author: Rohan Alexander [...UPDATE THIS...]
# Date: 11 February 2023 [...UPDATE THIS...]
# Contact: rohan.alexander@utoronto.ca [...UPDATE THIS...]
# License: MIT
# Pre-requisites: [...UPDATE THIS...]
# Any other information needed? [...UPDATE THIS...]


#### Workspace setup ####
library(tidyverse)

#### Test data ####
data <- read.csv("data/analysis_data/sim_marriage_analysis_data.csv")

#Test for negative numbers
data$Licenses_Issued |> min() <= 0

# Test for NAs
all(is.na(data$Licenses_Issued))


