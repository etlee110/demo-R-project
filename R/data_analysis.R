#' Run the Boston housing data analysis pipeline and make figures
#'
#' This function is an example of wrapping a reproducible data analysis
#' pipeline into a single entry point. It uses only relative paths and
#' assumes the project layout:
#'
#' - raw_data/boston.txt
#' - output/
#'
#' The function will:
#' 1. Read and clean the Boston housing data.
#' 2. Fit a simple linear model.
#' 3. Save a figure to output/boston_plot.png.
#'
#' @return (invisibly) the path to the generated figure.
#' @examples
#' \dontrun{
#'   make_figures()
#' }
make_figures <- function() {
  # TODO: Customize this pipeline for your own projects.

  # Keep everything relative to the current working directory.
  raw_path <- file.path("raw_data", "boston.txt")
  output_dir <- "output"

  if (!file.exists(raw_path)) {
    stop("Raw data file not found: ", raw_path)
  }

  if (!dir.exists(output_dir)) {
    dir.create(output_dir, recursive = TRUE)
  }

  # 1. Read and clean data
  boston_raw <- readr::read_table(raw_path, col_names = TRUE)

  boston_clean <- boston_raw |>
    dplyr::filter(stats::complete.cases(.))

  clean_path <- file.path(output_dir, "clean_boston.rds")
  saveRDS(boston_clean, clean_path)

  # 2. Fit model
  model <- stats::lm(medv ~ lstat, data = boston_clean)
  model_path <- file.path(output_dir, "model_boston.rds")
  saveRDS(model, model_path)

  # 3. Make figure
  boston_clean$pred <- stats::predict(model, newdata = boston_clean)

  p <- ggplot2::ggplot(boston_clean, ggplot2::aes(x = lstat, y = medv)) +
    ggplot2::geom_point(alpha = 0.6) +
    ggplot2::geom_line(ggplot2::aes(y = pred), color = "red", linewidth = 1) +
    ggplot2::theme_minimal() +
    ggplot2::labs(
      title = "Boston Housing: MEDV vs LSTAT",
      x = "% lower status population (lstat)",
      y = "Median value of owner-occupied homes (medv)"
    )

  fig_path <- file.path(output_dir, "boston_plot.png")
  ggplot2::ggsave(fig_path, p, width = 6, height = 4, dpi = 300)

  message("Figure saved to ", fig_path)
  invisible(fig_path)
}
