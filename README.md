# R Template Project (Demo)

_I used XX late days this time, and I have XX days remaining._

This repository is a demo R project template for:
- Reproducible and automated workflows
- Using `Make` to orchestrate analysis
- Managing R package dependencies with `renv`
- Keeping all paths relative (no absolute paths)

## Project structure

- raw_data/ — raw input data (e.g., `boston.txt`)
- scripts/ — analysis pipeline scripts (`01_clean.R`, `02_model.R`, `03_visualize.R`)
- output/ — cleaned data, model results, and figures
- R/ — R package source for `RTemplate`

## Usage

1. Install system tools (once):
   - Make sure you have `make` and a recent R installed.

2. Initialize the project (creates `renv` library, installs deps, snapshots):

   ```sh
   make init
   ```

3. Run the full analysis pipeline (clean, model, visualize):

   ```sh
   make all
   ```

   Outputs (example):
   - `output/clean_boston.rds`
   - `output/model_boston.rds`
   - `output/boston_plot.png`

4. Build and install the R package `RTemplate`, then run the pipeline from R:

   ```r
   # in R
   devtools::document()
   devtools::build()    # creates RTemplate_*.tar.gz in project root
   devtools::install()

   library(RTemplate)
   make_figures()
   ```

## Report (design rationale)

- **Reproducibility**
  - Dependency versions are locked with `renv` (see `renv.lock`).
  - All computation steps are scripted (`scripts/`) and orchestrated by `Makefile`.
  - No absolute paths are used; everything is relative to the project root.

- **Automation**
  - `Makefile` defines targets for data cleaning, modeling, and plotting, plus `renv::snapshot()` and package build.
  - `make all` runs the entire pipeline in the correct order.

- **Template for future projects**
  - Copy this structure and replace the example Boston housing analysis with your own data and scripts.
  - Keep the same ideas: relative paths, scripted steps, `renv` for packages, and `Make` for automation.

## How to use `devtools::document()` and `devtools::build()`

1. Open this project in R (RStudio or R terminal with working directory at the project root).
2. Ensure you have `devtools` installed:

   ```r
   install.packages("devtools")
   ```

3. Generate documentation files (`man/` and `NAMESPACE`) from inline `roxygen2` comments:

   ```r
   devtools::document()
   ```

   This:
   - Parses `#'` roxygen comments in `R/` files.
   - Updates `NAMESPACE` and `.Rd` help files in `man/`.

4. Build the package source tarball:

   ```r
   devtools::build()
   ```

   This creates a file like `RTemplate_0.1.0.tar.gz` in the project root.

5. (Optional but recommended) Check the package:

   ```r
   devtools::check()
   ```

6. Install and test the package:

   ```r
   devtools::install()
   library(RTemplate)
   make_figures()
   ```

Replace the late-day line above with your actual late-day usage when you use this as a real homework submission.
