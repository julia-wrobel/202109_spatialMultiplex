# 202109_spatialMultiplex

## Purpose

This project is to store ideas and data for collaboration on Bioconductor package(s) for analyzing multiplex single cell imaging data. Main packages to be built:

* data package for distributing Vectra Polaris data as a `SpatialExperiment` object
* package with wrapper functions to convert multiplex imaging datasets from different platforms to `SpatialExperiment` objects OR add these functions directly to `SpatialExperiment`


Downstream goals:

* Convert `tiff` images directly to `SpatialExperiment` object
* Tutorials for analysis of multiplex imaging data


## Structure

* `analysis/` is intended to contain all the source R Markdown files that
implement the analyses for the project.
* `notes/` will contain meeting notes, ideas, and lists of references
* `data/` will either be a symbolic link to an external data directory, or
a subdirectory
* `source/` will contain bare scripts (like wrapper functions for different multiplex imaging platforms)

