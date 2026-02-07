

# 01_clean.R
# Example data cleaning script for Boston housing data.
# TODO: Customize cleaning steps for your own projects.

# For project-relative paths, if needed. Install once in R with:
# install.packages("here")
library(here)
here::i_am("scripts/01_clean.R")  # declare this script's location

library(readr)
library(dplyr)
# Relative to the project root, the raw data is at "raw_data/boston.txt".

# In my directory, the absolute path to the raw data is:
# /home/ethanlee/demo-R-project/raw_data/boston.txt

# When collaborating, we want to avoid hardcoding absolute paths. 
# Instead, we use relative paths from the project root.

# Use project-relative paths via here()
raw_path <- here::here("raw_data", "boston.txt")


column_names <- c("CRIM", "ZN", "INDUS", "CHAS", "NOX", "RM", "AGE", "DIS", 
                 "RAD", "TAX", "PTRATIO", "B", "LSTAT", "MEDV")

# Read the file using here package
raw_data <- readLines(raw_path)

# Find the first line containing numeric data
start_line <- which(grepl("^\\s*[0-9]", raw_data))[1]

# Extract only the numeric data lines
data_lines <- raw_data[start_line:length(raw_data)]

# Join all lines into a single string and split into numbers
all_numbers <- unlist(strsplit(paste(data_lines, collapse = " "), "\\s+"))

# Remove empty strings
all_numbers <- all_numbers[all_numbers != ""]

# Convert to numeric
all_numbers <- as.numeric(all_numbers)

# Create a matrix with 14 columns (number of variables)
data_matrix <- matrix(all_numbers, ncol = 14, byrow = TRUE)

# Convert to data frame and set column names
boston_data <- as.data.frame(data_matrix)
names(boston_data) <- column_names

# Ensure output directory exists
data_dir <- here::here("data")
if (!dir.exists(data_dir)) {
    dir.create(data_dir, recursive = TRUE)
}

csv_path <- file.path(data_dir, "boston.csv")

# Write processed data to CSV using here package
write.csv(boston_data, csv_path, row.names = FALSE)

save(boston_data, file = here::here("data", "boston.rda"))

# Display first few rows to verify
print(head(boston_data))

message("Cleaned data saved to ", csv_path)