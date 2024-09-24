#### Preamble ####
# Purpose: Cleans the raw plane data recorded by two observers..... [...UPDATE THIS...]
# Author: Rohan Alexander [...UPDATE THIS...]
# Date: 6 April 2023 [...UPDATE THIS...]
# Contact: rohan.alexander@utoronto.ca [...UPDATE THIS...]
# License: MIT
# Pre-requisites: [...UPDATE THIS...]
# Any other information needed? [...UPDATE THIS...]

#### Workspace setup ####
library(tidyverse)

#### Clean data ####
raw_data <- read_csv("data/raw_data/merged_raw_expenditure_data.csv")

cleaned_data <-
  raw_data |>
  janitor::clean_names() |>
  mutate(
    year = as.numeric(year),
    expenditure = as.numeric(expenditure))

cleaned_data <- cleaned_data %>%
  mutate(budget_type = toupper(budget_type),
         expense_category = toupper(expense_category),
         city_abc = toupper(city_abc),
         division_board = toupper(division_board))

cleaned_data <- cleaned_data %>%
  mutate( budget_type = case_when(
  budget_type %in% c("OPERATING", "OPERATION") ~ "OPERATING"))

# Count the number of NAs in each column
na_counts <- sapply(cleaned_data, function(x) sum(is.na(x)))
na_counts
# val_count_cols = c('budget_type', 'city_abc', 'expense_category', 'division_board')
val_count_cols = c('division_board')
value_counts <- lapply(names(cleaned_data), function(col) {
  if (col %in% val_count_cols) {
    return(cleaned_data %>% count(!!sym(col)))
  } else {
    return(NULL)  # Skip columns not in val_count_cols
  }
})

# Display the value counts for each column
value_counts

cleaned_data <- cleaned_data %>%
  mutate(
    division_board = case_when(
      division_board %in% c("city clerk's office", "city clerks's office") ~ "city clerk's office",
      division_board %in% c("toronto police service", "toronto police service (tps)", "toronto police services (tps)") ~ "toronto police service",
      division_board %in% c("children services", "children's services") ~ "children services",
      # Add more standardizations here
      TRUE ~ division_board
    )
  )

top_50_division_board <- value_counts[[5]] %>%
  arrange(desc(n))
top_50_division_board

cleaned_data
#### Save data ####
write_csv(cleaned_data, "outputs/data/analysis_data.csv")
