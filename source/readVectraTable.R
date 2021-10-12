# readVectraTable
#
# Loads data from a Vectra3 or Vectra Polaris experiment
# in cell segmented tabular form in as a spatialExperiment object
# the function
# right now assumes a file structure where folder contains multiple txt files, each is from one image
# should also be able to handle "consolidated_data" file of multiple images/subjects
# should also be able to read in clinical data?

#
#

samples = here::here("data", "tabular")
clean_names = TRUE

## samples should point to a directory with one or multiple txt files
readVectraTable <- function(samples = "", # list of txt files
                            clean_names = TRUE, # convert colnames to snakecase
                            marker_types = NULL # match table for marker types (i.e. phenotypic vs. functional)
                            ){

  # setup file paths
  dir <- file.path(samples)


  # for each individual txt file, do the following

  ## read in file
  ## convert into spatialExperiment object
  ## combine the multiple objects into one



  # how do they read in multiple files?

}
