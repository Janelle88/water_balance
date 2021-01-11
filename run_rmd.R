library(tidyverse)
library(knitr)
library(markdown)
library(rmarkdown)
library(here)

# use first 5 rows of mtcars as example data
ncpn_centroids <- read_csv(here::here("NCPN_centroids.csv"))

site = npcn_centroids$Park

lat = npcn_centroids$Lat

lon = npcn_centroids$Long


# for each type of car in the data create a report
# these reports are saved in output_dir with the name specified by output_file
for(row in read_csv(here::here("npcn_centroids.csv"), header=F)) {
 # make_report(row["Park"], row["Lat"], row["Lon"])
  rmarkdown::render(here::here("water_balance_graphs.Rmd")  # file 2
                    output_file =  paste("water_balance_report_for_", row["Park"], ".html", sep=""), 
                    output_dir = here::here(row["Park"])
}

#make_report(Park, Lat, Lon)
  