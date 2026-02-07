# Makefile for R template project

# Use R from PATH
RSCRIPT = Rscript

.PHONY: help init renv_install renv_snapshot clean_data fit_model make_figures all build_package check_package install_package

help:
	@echo "Available targets:"
	@echo "  make init            - Initialize renv and install dependencies"
	@echo "  make renv_snapshot   - Snapshot current package versions with renv"
	@echo "  make clean_data      - Clean Boston housing data"
	@echo "  make fit_model       - Fit model on cleaned data"
	@echo "  make make_figures    - Generate figures from model results"
	@echo "  make all             - Run full pipeline: clean_data, fit_model, make_figures"
	@echo "  make build_package   - Build RTemplate package (tar.gz in project root)"
	@echo "  make check_package   - Run devtools::check() on RTemplate package"
	@echo "  make install_package - Install RTemplate package locally"

init:
	$(RSCRIPT) -e "if (!requireNamespace('renv', quietly = TRUE)) install.packages('renv')"
	$(RSCRIPT) -e "if (!file.exists('renv.lock')) renv::init(bare = TRUE) else renv::restore()"
	$(RSCRIPT) -e "pkgs <- c('ggplot2', 'dplyr', 'readr', 'devtools');\
		missing <- pkgs[!vapply(pkgs, requireNamespace, logical(1), quietly = TRUE)];\
		if (length(missing) > 0) install.packages(missing)"
	$(RSCRIPT) -e "renv::snapshot(prompt = FALSE)"

renv_snapshot:
	$(RSCRIPT) -e "renv::snapshot(prompt = FALSE)"

clean_data:
	$(RSCRIPT) scripts/01_clean.R

fit_model: clean_data
	$(RSCRIPT) scripts/02_model.R

make_figures: fit_model
	$(RSCRIPT) scripts/03_visualize.R

all: make_figures

build_package:
	$(RSCRIPT) -e "devtools::document(); devtools::build(path = '.', binary = FALSE)"

check_package:
	$(RSCRIPT) -e "devtools::check()"

install_package:
	$(RSCRIPT) -e "devtools::install()"
