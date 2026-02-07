# 03_visualize.R
# Example visualization script for Boston housing model.
# TODO: Customize figures for your own projects.

library(ggplot2)

# Use only relative paths
clean_path <- file.path("output", "clean_boston.rds")
model_path <- file.path("output", "model_boston.rds")

if (!file.exists(clean_path) || !file.exists(model_path)) {
  stop("Required files not found. Run 01_clean.R and 02_model.R first.")
}

boston_clean <- readRDS(clean_path)
model <- readRDS(model_path)

# Example: scatter plot with fitted line
# TODO: Adjust aesthetics and additional layers as needed.

boston_clean$pred <- predict(model, newdata = boston_clean)

p <- ggplot(boston_clean, aes(x = lstat, y = medv)) +
  geom_point(alpha = 0.6) +
  geom_line(aes(y = pred), color = "red", linewidth = 1) +
  theme_minimal() +
  labs(
    title = "Boston Housing: MEDV vs LSTAT",
    x = "% lower status population (lstat)",
    y = "Median value of owner-occupied homes (medv)"
  )

output_dir <- "output"
if (!dir.exists(output_dir)) dir.create(output_dir, recursive = TRUE)

fig_path <- file.path(output_dir, "boston_plot.png")
ggsave(fig_path, p, width = 6, height = 4, dpi = 300)

message("Figure saved to ", fig_path)
