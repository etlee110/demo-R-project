# 02_model.R
# Example model fitting script for Boston housing data.
# TODO: Customize model specification for your own projects.

library(dplyr)

# Use only relative paths
clean_path <- file.path("output", "clean_boston.rds")

if (!file.exists(clean_path)) {
  stop("Clean data file not found. Run 01_clean.R first.")
}

boston_clean <- readRDS(clean_path)

# Example: simple linear regression of medv on lstat
# TODO: Change formula / model as needed.
model <- lm(medv ~ lstat, data = boston_clean)

# Save model object
output_dir <- "output"
if (!dir.exists(output_dir)) dir.create(output_dir, recursive = TRUE)

model_path <- file.path(output_dir, "model_boston.rds")
saveRDS(model, model_path)

message("Model saved to ", model_path)
