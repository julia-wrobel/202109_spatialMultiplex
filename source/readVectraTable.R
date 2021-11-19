# readVectraTable
#
# Loads data from a Vectra3 or Vectra Polaris experiment
# in cell segmented tabular form in as a spatialExperiment object
# the function
# right now assumes a file structure where folder contains multiple txt files, each is from one image
# should also be able to handle "consolidated_data" file of multiple images/subjects
# should also be able to read in clinical data?

#
# libraries: janitor, vroom, SpatialExperiment, S4Vectors
# suggests: phenoptr

#sample_path = here::here("data", "tabular")
#clean_names = TRUE

#sample_path = "/Users/wrobelj/Downloads"


## samples should point to a directory with one or multiple txt files
readVectraTable <- function(sample_path = "", # path to where one or multiple txt files stored
                            clean_names = TRUE, # convert colnames to snakecase
                            marker_types = NULL # match table for marker types (i.e. phenotypic vs. functional)
                            ){

  # get file names
  files <- list.files(sample_path, pattern = ".txt",
                      full.names = TRUE)


  # for each individual txt file, do the following
  spel <- lapply(seq_along(files), function(f){
    # load data
    if(require(phenoptr)){df <- read_cell_seg_data(files[f])
    }else{
      library(vroom)
      df <- vroom(files[f], col_names = TRUE)
      colnames(df) <- gsub(pattern = " \\(Normalized Counts, Total Weighting\\)", "",
                         colnames(df))
    }

    # will currently break if user specifies clean_names = FALSE
    if(clean_names){df = janitor::clean_names(df)}

    # add "in_tissue" variable
    df$in_tissue = ifelse(tolower(df$tissue_category) == "slide", 0, 1)

    # define variables for different slots
    # this is where I want to edit
      # add in two assays: main, and everything else
    assay_vars <- c(names(df)[grep(") min|max|mean|std_dev|total", names(df))]
    )
    colData_vars <- c("cell_id", "tissue_category", "slide_id",
                     names(df)[grep("area|phenotype|axis|compactness", names(df))] )

    spatial_vars <- c("cell_x_position", "cell_y_position", "in_tissue",
                      names(df)[grep("distance", names(df))])

    spatialData <- subset(df, select = spatial_vars)

    # make into spe object
    SpatialExperiment(
      assays = list(counts = t(as.matrix(subset(df, select = assay_vars)))),
      sample_id = df$sample_name,
      colData = DataFrame(subset(df, select = colData_vars)),
      spatialData=DataFrame(spatialData),
      spatialCoordsNames = c("cell_x_position", "cell_y_position")
    )
  }) # end lapply
  spe <- do.call(cbind, spel)
  return(spe)
}
