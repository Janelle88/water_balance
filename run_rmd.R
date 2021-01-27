library(tidyverse)
library(knitr)
library(markdown)
library(rmarkdown)
library(here)

# for each type of car in the data create a report
# these reports are saved in output_dir with the name specified by output_file

centroids <- read_csv(here::here("NCPN_centroids.csv")) #

for(row in 1:nrow(centroids)) {
  sites <- centroids[row, "Park"]
  lats <- centroids[row, "Lat"]
  lons <- centroids[row, "Long"]
  model_bcs <- centroids[row, "model_bc"]
  model_bc_rcps <- centroids[row, "model_bc_rcp"]
  model_wcs <- centroids[row, "model_wc"]
  model_wc_rcps <- centroids[row, "model_wc_rcp"]
  
  
  site <- pull(sites, Park)
  lat <- pull(lats, Lat)
  lon <- pull(lons, Long)
  model_bc <- pull(model_bcs, model_bc)
  model_bc_rcp <- pull(model_bc_rcps, model_bc_rcp)
  model_wc <- pull(model_wcs, model_wc)
  model_wc_rcp <- pull(model_wc_rcps, model_wc_rcp)
  past_data <-  "gridMET"
  
  # past_data options: "gridMET", "Daymet"
  # if you want to use data that will work with the future models, gridMET is a better choice. It doesn't require adjusting for any biases
  
  dry_year <-  2012 # a particularly dry year, maybe with lots of fire activity? something for people to reference
  
  wet_year <-  2016 # particularly wet year for people to reference
  
  # if(file.exists(here::here(site, paste("water_balance_graphs_for_", site, ".html", sep="")))){
  #   next
  # }
  
  rmarkdown::render(here::here("water_balance_graphs.Rmd"),  # file 2
                    output_file =  paste("water_balance_graphs_for_", site, ".html", sep=""), 
                    output_dir = here::here("sites", site))
  
}


  