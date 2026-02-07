#' Clean Boston housing data
#'
#' This is a minimal example function for teaching how
#' to put code into an R package. It:
#' - Reads raw_data/boston.txt relative to the project root
#' - Parses it into a data frame
#' - Returns the cleaned data (and does not write files)
#'
#' @return A data.frame with the Boston housing data.
#' @examples
#' \dontrun{
#'   dat <- clean_boston()
#'   head(dat)
#' }
#' @export
clean_boston <- function() {
  # Assumes working directory is the project root and the file exists
  path <- file.path("raw_data", "boston.txt")
  if (!file.exists(path)) {
    stop("Raw data file not found: ", path)
  }

  column_names <- c(
    "CRIM", "ZN", "INDUS", "CHAS", "NOX", "RM", "AGE", "DIS",
    "RAD", "TAX", "PTRATIO", "B", "LSTAT", "MEDV"
  )

  raw_data <- readLines(path)

  start_line <- which(grepl("^\\s*[0-9]", raw_data))[1]
  data_lines <- raw_data[start_line:length(raw_data)]

  all_numbers <- unlist(strsplit(paste(data_lines, collapse = " "), "\\s+"))
  all_numbers <- all_numbers[all_numbers != ""]
  all_numbers <- as.numeric(all_numbers)

  data_matrix <- matrix(all_numbers, ncol = 14, byrow = TRUE)
  boston_data <- as.data.frame(data_matrix)
  names(boston_data) <- column_names

  boston_data
}
