#### Preamble ####
# Purpose: Downloads, merges, and saves expenditure data from opendatatoronto
# Author: Aman Rana
# Date: 24 September 2024
# Contact: aman.rana@mail.utoronto.ca
# License: MIT
# Pre-requisites: NA
# Any other information needed? NA


#### Workspace setup ####
library(opendatatoronto)
library(tidyverse)

# get package
package <- show_package("91cf5765-3d3f-4d55-9eea-acb1d4222928")

#### Download data ####
# get all resources for this package
resources <- list_package_resources("91cf5765-3d3f-4d55-9eea-acb1d4222928")

# identify datastore resources; by default, Toronto Open Data sets datastore resource format to CSV for non-geospatial and GeoJSON for geospatial resources
datastore_resources <- filter(resources, tolower(format) %in% c('xlsx'))

# load the first datastore resource as a sample
data_r_1 <- filter(datastore_resources, row_number()==1) %>% get_resource()
data_r_2 <- filter(datastore_resources, row_number()==2) %>% get_resource()
data_r_3 <- filter(datastore_resources, row_number()==3) %>% get_resource()

clean_and_rename <- function(tibble, year) {
  tibble %>%
    # Skip the first row and set the second row as column names
    janitor::row_to_names(row_number = 2) %>%
    # Remove the row with NA values (original header row)
    filter(!is.na(`YEAR`)) %>%
    # Clean column names to make them consistent
    janitor::clean_names() %>%
    # Rename expenditure column to a common name 'expenditure'
    rename(expenditure = contains("expenditure")) %>%
    # Add the year column
    mutate(year = year)
}

clean_and_rename <- function(tibble, year) {
  tibble %>%
    # Skip rows where all values are NA
    filter(rowSums(is.na(.)) != ncol(.)) %>%
    # Set the first non-null row as column names and clean them immediately
    janitor::row_to_names(row_number = 1) %>%
    janitor::clean_names() %>%
    # Remove rows where year column is NA (case insensitive 'year' or 'YEAR')
    filter(!is.na(!!sym(tolower(grep("^year$", names(.), ignore.case = TRUE, value = TRUE))))) %>%
    # Rename the expenditure column to a common name 'expenditure'
    rename(expenditure = contains("expenditure")) %>%
    # Add the year column
    mutate(year = year)
}



# Clean each dataset and add year column
data_2022 <- clean_and_rename(data_r_1[[1]], 2022)
data_2023 <- clean_and_rename(data_r_1[[2]], 2023)

data_2017 <- clean_and_rename(data_r_2[[1]], 2017)
data_2018 <- clean_and_rename(data_r_2[[2]], 2018)
data_2019 <- clean_and_rename(data_r_2[[3]], 2019)
data_2020 <- clean_and_rename(data_r_2[[4]], 2020)
data_2021 <- clean_and_rename(data_r_2[[5]], 2021)

data_2012 <- clean_and_rename(data_r_3[[1]], 2012)
data_2013 <- clean_and_rename(data_r_3[[2]], 2013)
data_2014 <- clean_and_rename(data_r_3[[3]], 2014)
data_2015 <- clean_and_rename(data_r_3[[4]], 2015)
data_2016 <- clean_and_rename(data_r_3[[5]], 2016)

# Combine the datasets
all_data <- bind_rows(data_2022, data_2023, data_2021, data_2020, data_2019, data_2018, data_2017, data_2016, data_2015, data_2014, data_2013, data_2012)

all_data <- all_data %>%
  mutate(contract_date_dd_mm_yyyy = as.Date(as.numeric(contract_date_dd_mm_yyyy), origin = "1899-12-30"))

# View the result
glimpse(all_data)

gc()

#merge description_of_the_work and description_of_work
all_data <- all_data %>%
  mutate(description_of_the_work = coalesce(description_of_the_work, description_of_work)) %>%
  select(-description_of_work)

#Limit to year, budget_type, city_abc, expense_category, division_board, consultants_name, description_of_the_work, expenditure
all_data <- all_data %>%
  select(year, budget_type, city_abc, expense_category, division_board, consultants_name, description_of_the_work, expenditure)


#### Save data ####
# change the_raw_data to whatever name you assigned when you downloaded it.
write_csv(all_data, "data/raw_data/merged_raw_expenditure_data.csv")