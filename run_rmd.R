library(tidyverse)
library(knitr)
library(markdown)
library(rmarkdown)
library(here)
library(pagedown)


centroids <- read_csv(here::here("NCPN_centroids.csv")) #NCPN_centroids, run_multiple_sites

save_images = FALSE # do you want to save individual .png files of all plots generated in the report? if so, change to TRUE

############ there is also a line of code that reiterates this in the `water_balance_graphs.Rmd` file
#make sure if running from this R script that it either matches what you want or that it is commented out

#----------------------------------
#
# DATA LOOP
#
#----------------------------------

# for each park in the csv file listed, this runs the `water_balance_data.Rmd`

# for(row in 1:nrow(centroids)) {
#   sites <- centroids[row, "Park"]
#   lats <- centroids[row, "Lat"]
#   lons <- centroids[row, "Long"]
#   model_bcs <- centroids[row, "model_bc"]
#   model_bc_rcps <- centroids[row, "model_bc_rcp"]
#   model_wcs <- centroids[row, "model_wc"]
#   model_wc_rcps <- centroids[row, "model_wc_rcp"]
# 
# 
#  site <- pull(sites, Park)
#   lat <- pull(lats, Lat)
#   lon <- pull(lons, Long)
#   model_bc <- pull(model_bcs, model_bc)
#   model_bc_rcp <- pull(model_bc_rcps, model_bc_rcp)
#   model_wc <- pull(model_wcs, model_wc)
#   model_wc_rcp <- pull(model_wc_rcps, model_wc_rcp)
#   past_data <-  "gridMET"
# 
#   # past_data options: "gridMET", "Daymet"
#   # if you want to use data that will work with the future models, gridMET is a better choice. It doesn't require adjusting for any biases
# 
# 
#   if(file.exists(here::here(site, paste("water_balance_data_for_", site, ".html", sep="")))){
#     next
#   }
# 
#   rmarkdown::render(here::here("water_balance_data.Rmd"),  # file 2
#                     output_file =  paste("water_balance_data_for_", site, ".html", sep=""),
#                     output_dir = here::here("sites", site))

# } #close data download loop

#-------------------------------
#
# GRAPH LOOP
#
#-------------------------------

# for each park in the csv file listed, this runs the `water_balance_graphs.Rmd`

for(row in 1:nrow(centroids)) {
  sites <- centroids[row, "Park"]
  lats <- centroids[row, "Lat"]
  lons <- centroids[row, "Long"]
  model_bcs <- centroids[row, "model_bc"]
  model_bc_rcps <- centroids[row, "model_bc_rcp"]
  model_wcs <- centroids[row, "model_wc"]
  model_wc_rcps <- centroids[row, "model_wc_rcp"]
  dry_years <- centroids[row, "dry_year"]
  wet_years <- centroids[row, "wet_year"]


  site <- pull(sites, Park)
  lat <- pull(lats, Lat)
  lon <- pull(lons, Long)
  model_bc <- pull(model_bcs, model_bc)
  model_bc_rcp <- pull(model_bc_rcps, model_bc_rcp)
  model_wc <- pull(model_wcs, model_wc)
  model_wc_rcp <- pull(model_wc_rcps, model_wc_rcp)
  past_data <-  "gridMET"
  dry_year <- pull(dry_years, dry_year)
  wet_year <- pull(wet_years, wet_year)

  #  dry_year <-  2012 # a particularly dry year, maybe with lots of fire activity? something for people to reference

 #   wet_year <-  2016 # particularly wet year for people to reference

rmarkdown::render(here::here("water_balance_graphs.Rmd"),  # file 2
                  output_file =  paste("water_balance_graphs_for_", site, ".html", sep=""),
                  output_dir = here::here("sites", site))

chrome_print(here::here("sites",
                        site,
                        paste("water_balance_graphs_for_", site, ".html", sep="")), format = "pdf")

}

