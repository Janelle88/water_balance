# ----------
# Attach packages
# ----------

library(installr)
library(data.table) 
library(here)
#library(plyr) 
# be careful with this, it causes issues for dplyr::group_by
# I didn't try, but the internet says if you load it before tidyverse, that issue goes away
library(tidyverse)
library(beepr)
library(lubridate)
library(directlabels)
library(data.table)
library(ggbeeswarm)
library(gghalves)


# Quick note: this code runs off the most recent version of R

######
######
######

# To update R:
#
# enter the following code for windows:
#
# install.packages("installr")
# library(installr)
# updateR()
# more information here: https://www.r-statistics.com/2015/06/a-step-by-step-screenshots-tutorial-for-upgrading-r-on-windows/#:~:text=If%20you%20are%20running%20R,installr%20updateR()%20%23%20updating%20R.

#
# enter the following code for mac
#
# install.packages('devtools') #assuming it is not already installed
# library(devtools)
# install_github('andreacirilloac/updateR')
# library(updateR)
# updateR(admin_password = 'Admin user password')
#
# more information here: http://www.andreacirillo.com/2018/03/10/updater-package-update-r-version-with-a-function-on-mac-osx/
#
#
# R may tell you to open RGui
#
# more information about RGui here: https://www.dummies.com/programming/r/how-to-navigate-rgui/


# BEFORE RUNNING THE FUNCTIONS
# make sure you have created the folders as necessary in your wd
# instructions for the proper formatting should be above each function
# if you don't want to save the figures, then just comment out ggsave
# two folders in your wd should be 'raw_data' and 'figures'

######
######
######

# ----------
# Create loop for downloading the data
# ----------

#initialize with time range of interest and location, these don't get overwritten in loops 

site = "little_saddle_mtn" 

lat = 44.702 

lon = -110.018 

start = 2020

end = 2099

#"CCSM4", - removed this model until the problems with 2025 are fixed

# "inmcm4","NorESM1-M", put back in later - this was already run for me

climmodel <- c("MRI-CGCM3","MIROC5","IPSL-CM5A-LR","HadGEM2-CC365","GFDL-ESM2G","CanESM2","CSIRO-Mk3-6-0","CNRM-CM5","BNU-ESM")# climate model names
for(m in climmodel){ #start loop for the different climate models
  #initialize some variables to hold data 
  
  holder <- NULL 
  
  mydat <- NULL 
  
  mydat2 <- NULL 
  
  mydat3 <- NULL 
  
  #This is the loop that runs across all the climate variables you want to download for RCP 8.5 
  
  
  for(climvar in c("soil_water", "runoff", "rain", "agdd","accumswe", "PET", "Deficit", "AET")){ #start loop for 8.5
    
    
    
    print(paste("downloading",climvar, "8.5", m))#this is a progress update as the loop runs 
    
    
    for(yr in c(start:end)){# for each climate variable loop across the year.  allows users to select range if not interested in all data 
      
      
      #Specify URL where are stored on cloud 
      # leap years work differently in future data
      # set if else for futre data
      
      leap <- lubridate::leap_year(yr) 
      if(leap == TRUE){
        enddate <- paste(yr,"12-31", sep = "-")
      } else {
        enddate <- paste(yr + 1, "01-01", sep = "-")
      }
      
      data_url<-paste("http://www.yellowstone.solutions/thredds/ncss/daily_or_monthly/gcm/rcp85/",m,"/V_1_5_",yr,"_",m,"_rcp85_",climvar,".nc4?var=",climvar,"&latitude=",lat,"&longitude=",lon,"&time_start=",yr,"-01-01T12%3A00%3A00Z&time_end=",enddate,"T12%3A00%3A00Z&accept=csv_file",sep ="") 
      
      holder <-data.frame(fread(data_url, 
                                verbose=FALSE, 
                                showProgress = FALSE,
      ))#temporary holder for subsets downloaded from cloud 
      
      mydat<-rbind(mydat, holder)#file that grows by adding each chunk downloaded from cloud 
      
      date <- mydat$time # dates don't download correctly without this
      
    }#end loop across years for rcp 8.5
    
    mydat2<-cbind(mydat2,mydat[,4])#append just the water balance data from each downloaded chunk 
    
    mydat<-NULL#reset this variable so it can accommodate a new column name given the new water balance variable it's extracting at each loop cycle 
    
  }#end loop across climate variables for 8.5
  
  
  
  mydat3<-cbind(date,holder[,2:3],mydat2)#join the data with metadata including date, lat, long 
  
  head(mydat3) 
  
  
  # ----------
  # Create loop for downloading the data rcp 4.5
  # ----------
  
  #initialize some variables to hold data 
  
  holder <- NULL 
  
  mydat <- NULL 
  
  mydat2 <- NULL 
  
  mydat4 <- NULL 
  
  
  
  #This is the loop that runs across all the climate variables you want to download 
  
  for(climvar in c("soil_water", "runoff", "rain", "agdd","accumswe", "PET", "Deficit", "AET")){ #start loop for RCP 4.5
    
    
    
    print(paste("downloading",climvar, "4.5", m))#this is a progress update as the loop runs 
    
    
    for(yr in c(start:end)){# for each climate variable loop across the year.  allows users to select range if not interested in all data 
      
      
      #Specify URL where are stored on cloud 
      #leap years are written differently in the future data
      #ifelse for future data
      
      leap <- lubridate::leap_year(yr) 
      if(leap == TRUE){
        enddate <- paste(yr,"12-31", sep = "-")
      } else {
        enddate <- paste(yr + 1, "01-01", sep = "-")
      }
      
      data_url<-paste("http://www.yellowstone.solutions/thredds/ncss/daily_or_monthly/gcm/rcp45/",m,"/V_1_5_",yr,"_",m,"_rcp45_",climvar,".nc4?var=",climvar,"&latitude=",lat,"&longitude=",lon,"&time_start=",yr,"-01-01T12%3A00%3A00Z&time_end=",enddate,"T12%3A00%3A00Z&accept=csv_file",sep ="") 
      
      holder <-data.frame(fread(data_url, 
                                verbose=FALSE, 
                                showProgress = FALSE,
      )) #temporary holder for subsets downloaded from cloud 
      
      mydat<-rbind(mydat, holder) #file that grows by adding each chunk downloaded from cloud 
      
      
      date <- mydat$time
      
    }#end loop across years for 4.5
    
    mydat2<-cbind(mydat2,mydat[,4])#append just the water balance data from each downloaded chunk 
    
    mydat<-NULL#reset this variable so it can accommodate a new column name given the new water balance variable it's extracting at each loop cycle 
    
  }#end loop across climate variables for 4.5
  
  mydat4<-cbind(mydat3,mydat2) #join the data with metadata including date, lat, long
  
  colnames(mydat4)[]<-c("date", "lat","lon","soil_water_daily_85", "runoff_daily_85", "rain_daily_85", "agdd_daily_85", "accumswe_daily_85", "pet_daily_85", "deficit_daily_85", "aet_daily_85", "soil_water_daily_45", "runoff_daily_45", "rain_daily_45", "agdd_daily_45", "accumswe_daily_45", "pet_daily_45", "deficit_daily_45", "aet_daily_45") 
  
  
  #at this point if we want another loop for downloading more sites with different coordinates 
  
  #we need to save mydat4 to the hard drive. 
  
  # setwd("C:\\David\\Water Balance CONUS\\downloads\\")#note R requires either "\\" or "/" 
  
  # JC fixed for this by creating a project folder, no need to setwd() when you have a project folder
  
  
  # columns are multiplied by 100, need to fix this before writing csv
  
  divide.by.10 <- function(x, na.rm = FALSE) {
    x/10
  }
  
  mydat5 <- mydat4 %>% 
    mutate(lat = as.character(lat),
           lon = as.character(lon)) %>% 
    mutate_if(is.numeric, divide.by.10)
  
  write_csv(mydat5, here::here("raw_data", paste(site,"lat",lat,"lon",lon,m,"daily_future.csv", sep = "_"))) #default is a space, sep = "" removes space
  
}# end loop across different climate projections

beep(1)

# here::here allows you to choose a folder in your working directory to save to
# here::here("folder I want to save to (this has to be made in your working directory before you save it)", "subfolder", "subfolder ( subfolders can be as numerous you want them to be, always separated by a comma)", "last thing in the list is the name of the object I'm saving")


