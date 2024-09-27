#### Preamble ####
# Purpose: Cleans the raw consultant ependiture data
# Author: Aman Rana
# Date: 24 September 2024
# Contact: aman.rana@mail.utoronto.ca
# License: MIT
# Pre-requisites: merged_raw_expenditure_data.csv from 01-download_data
# Any other information needed? NA

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
  mutate(budget_type = case_when(
  budget_type %in% c("OPERATING", "OPERATION") ~ "OPERATING", TRUE ~ budget_type))

# Count the number of NAs in each column
na_counts <- sapply(cleaned_data, function(x) sum(is.na(x)))
na_counts

cleaned_data <- cleaned_data %>%
  drop_na() %>%
  filter(across(where(is.numeric), ~ . > 0))

val_count_cols = c('budget_type', 'city_abc', 'expense_category', 'division_board')
value_counts <- lapply(names(cleaned_data), function(col) {
  if (col %in% val_count_cols) {
    return(cleaned_data %>% count(!!sym(col)))
  } else {
    return(NULL)
  }
})

# Display the value counts for each column
value_counts

cleaned_data <- cleaned_data %>%
  mutate(
    division_board = case_when(
      division_board %in% c("SOCIAL DEVELOPMENT FINANCE & ADMINISTRATION") ~ "SOCIAL DEVELOPMENT, FINANCE & ADMINISTRATION",
      division_board %in% c("INFORMATION & TECHNOLOGY", "INFORMATION TECHNOLOGY") ~ "INFORMATION & TECHNOLOGY",
      division_board %in% c("TORONTO POLICE SERVICES (TPS)", "TORONTO POLICE SERVICE (TPS)","TORONTO POLICE SERVICES (TPS)",
                            "TORONTO POLICE SERVICES BOARD(TPSB)","TORONTO POLICE SERVICE (TPS)", "TORONTO POLICE SERVICES BOARD", 
                            "TORONTO POLICE SERVICES BOARD (TPSB)") ~ "TORONTO POLICE SERVICE",
      division_board %in% c("TRANSPORTATION") ~ "TRANSPORTATION SERVICES",
      TRUE ~ division_board
    )
  )

cleaned_data <- cleaned_data %>%
  mutate(
    expense_category = case_when(
      expense_category %in% c("INFO TECHNOLOGY") ~ "INFORMATION TECHNOLOGY",
      expense_category %in% c("MGMT/R&D") ~ "MANAGEMENT / RESEARCH & DEVELOPMENT",
      expense_category %in% c("TRANSPORTATION") ~ "TRANSPORTATION SERVICES",
      TRUE ~ expense_category
    )
  )

#Manually review the names.
s_division_board <- value_counts[[5]] %>%
  arrange(desc(n))
s_division_board

s_city_abc <- value_counts[[3]] %>%
  arrange(desc(n))
s_city_abc

s_expense_category <- value_counts[[4]] %>%
  arrange(desc(n))
s_expense_category

cleaned_data
#### Save data ####
write_csv(cleaned_data, "data/analysis_data/expenditure_analysis_data.csv")
