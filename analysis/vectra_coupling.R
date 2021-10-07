library(tidyverse)

#library(phenoptr)
#path <- sample_cell_seg_path()
#read_cell_seg_data


load("/Users/juliawrobel/Documents/projects/2021/202109_spatialMultiplex/data/vectra_table.Rdata")

# subsetting to just one image
vectra_table = vectra_table %>%
  janitor::clean_names() %>%
  filter(sample_name ==  "#16 3-171-807_[47172,14046].im3")

# plot
vectra_table %>%
  ggplot(aes(cell_x_position, cell_y_position, color = tissue_category)) +
  geom_point() +
  theme(legend.position = "bottom")


## figure out tumor stroma here for this image
##
