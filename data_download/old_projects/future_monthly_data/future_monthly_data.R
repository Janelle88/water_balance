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

#set up a few initial conditions for testing.  These get over written in the loops 

climvar <- "runoff_monthly" 

climvar <- "PET_monthly" 

yr = 1980 



#initialize with time range of inerest and location, these don't get overwritten in loops 

site = "little_saddle_mtn" 

lat = 44.702 

lon = -110.018 

start = 2020

end = 2099

#"CCSM4", - removed this model until the problems with 2025 are fixed

climmodel <- c("inmcm4","NorESM1-M","MRI-CGCM3","MIROC5","IPSL-CM5A-LR","HadGEM2-CC365","GFDL-ESM2G","CanESM2","CSIRO-Mk3-6-0","CNRM-CM5","BNU-ESM")# climate model names
for(m in climmodel){
#initialize some variables to hold data 

holder <- NULL 

mydat <- NULL 

mydat2 <- NULL 

mydat3 <- NULL 



#This is the loop that runs across all the climate variables you want to download 

 
  for(climvar in c("soil_water_monthly", "runoff_monthly", "rain_monthly", "agdd_monthly","accumswe_monthly", "PET_monthly", "Deficit_monthly", "AET_monthly")){ 
  
  
  
  print(paste("downloading",climvar, "8.5", m))#this is a progress update as the loop runs 
  
  
  
  #the url uses two variable names for same variable in monthly download string like "PET_monthly" for long name and "pet" for short name 
  
  #the short name is sometimes a different case than the long variable name, so make it lowercase so that 
  
  #url string will work with the format of data stored on the cloud 
  
  varshort<-unlist(strsplit(climvar,"_m"));varshort 
  
  vshort<-varshort[[1]];vshort 
  
  if(vshort=="PET"){ 
    
    vshort<-"pet" 
    
  };vshort 
  
  
  
  if(vshort=="Deficit"){#change case of short name from upper to lower case 
    
    vshort<-"deficit" 
    
  };vshort 
  
  
  
  
  
  if(vshort=="AET"){ 
    
    vshort<-"aet" 
    
  };vshort 
  
  
  
  for(yr in c(start:end)){# for each climate variable loop across the year.  allows users to select range if not interested in all data 
    
    
    #Specify URL where are stored on cloud 
    
    #data_url<-"http://www.yellowstone.solutions/thredds/ncss/daily_or_monthly/v2_historical/daily/v2_2019_soil_water.nc4?var=soil_water&latitude=45&longitude=-111&time_start=2019-01-01T12%3A00%3A00Z&time_end=2019-12-31T12%3A00%3A00Z&accept=csv_file" 
    
    #access daily data 
    
    #example single variable single year timeseries 
    
    #data_url<-paste("http://www.yellowstone.solutions/thredds/ncss/daily_or_monthly/v2_historical/daily/v2_",yr,"_",climvar,".nc4?var=",climvar,"&latitude=",lat,"&longitude=",lon,"&time_start=",yr,"-01-01T12%3A00%3A00Z&time_end=",yr,"-12-31T12%3A00%3A00Z&accept=csv_file", sep="") 
    
    #single variable single year monthly time series with variable and year specified by user 
    
leap <- lubridate::leap_year(yr) 
    if(leap == TRUE){
      day <- 16
    } else {
      day <- 17
    }
    
    data_url<-paste("http://www.yellowstone.solutions/thredds/ncss/daily_or_monthly/gcm/rcp85/",m,"/V_1_5_",yr,"_",m,"_rcp85_",climvar,".nc4?var=",vshort,"&latitude=",lat,"&longitude=",lon,"&time_start=",yr,"-01-16T05%3A14%3A31.916Z&time_end=",yr,"-12-",day,"T00%3A34%3A14.059Z&accept=csv_file",sep ="") 
    
    
#    http://www.yellowstone.solutions/thredds/ncss/daily_or_monthly/gcm/rcp85/inmcm4/V_1_5_2020_inmcm4_rcp85_soil_water_monthly.nc4?var=soil_water&latitude=45&longitude=-111&time_start=2020-01-16T05%3A14%3A31.916Z&time_end=2020-12-16T00%3A34%3A14.059Z&accept=csv_file
    
#    http://www.yellowstone.solutions/thredds/ncss/daily_or_monthly/gcm/rcp85/inmcm4/V_1_5_2020_inmcm4_rcp85_soil_water_monthly.nc4?var=soil_water&latitude=45&longitude=-111&time_start=2020-01-16T05%3A14%3A31.916Z&time_end=2020-12-16T00%3A34%3A14.059Z&accept=csv_file
    
#    http://www.yellowstone.solutions/thredds/ncss/daily_or_monthly/gcm/rcp85/inmcm4/v_1_5_2020_inmcm4_rcp85_soil_water_monthly.nc4?var=soil_water&latitude=45&longitude=-111&time_start=2020-01-16T05%3A14%3A31.916Z&time_end=2020-12-16T00%3A34%3A14.059Z&accept=csv_file
    
    
    
    
    #Specify destination on drive where file should be saved if downloading directly to pc 
    
    #destfile <- "C:\\David\\Water Balance CONUS\\downloads\\output.csv" 
    
    #specify destination on drive 
    
    #download.file(data_url, destfile) 
    
    
    
    holder <-data.frame(fread(data_url, 
                              verbose=FALSE, 
                              showProgress = FALSE,
    ))#temporary holder for subsets downloaded from cloud 
    
    mydat<-rbind(mydat, holder)#file that grows by adding each chunk downloaded from cloud 
    
    date <- mydat$time
    
    }#end loop across years 
  
  mydat2<-cbind(mydat2,mydat[,4])#append just the water balance data from each downloaded chunk 
  
  mydat<-NULL#reset this variable so it can accodomate a new column name given the new water balance variable it's extracting at each loop cycle 
  
}#end loop across climate variables 
  


mydat3<-cbind(date,holder[,2:3],mydat2)#join the data with metadat including date, lat, long 

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

for(climvar in c("soil_water_monthly", "runoff_monthly", "rain_monthly", "agdd_monthly","accumswe_monthly", "PET_monthly", "Deficit_monthly", "AET_monthly")){ 
  
  
  
  print(paste("downloading",climvar, "4.5", m))#this is a progress update as the loop runs 
  
  
  
  #the url uses two variable names for same variable in monthly download string like "PET_monthly" for long name and "pet" for short name 
  
  #the short name is sometimes a different case than the long variable name, so make it lowercase so that 
  
  #url string will work with the format of data stored on the cloud 
  
  varshort<-unlist(strsplit(climvar,"_m"));varshort 
  
  vshort<-varshort[[1]];vshort 
  
  if(vshort=="PET"){ 
    
    vshort<-"pet" 
    
  };vshort 
  
  
  
  if(vshort=="Deficit"){#change case of short name from upper to lower case 
    
    vshort<-"deficit" 
    
  };vshort 
  
  
  
  
  
  if(vshort=="AET"){ 
    
    vshort<-"aet" 
    
  };vshort 
  
  
  
  for(yr in c(start:end)){# for each climate variable loop across the year.  allows users to select range if not interested in all data 
    
    
    #Specify URL where are stored on cloud 
    
    leap <- lubridate::leap_year(yr) 
    if(leap == TRUE){
      day <- 16
    } else {
      day <- 17
    }
    
    data_url<-paste("http://www.yellowstone.solutions/thredds/ncss/daily_or_monthly/gcm/rcp45/",m,"/V_1_5_",yr,"_",m,"_rcp45_",climvar,".nc4?var=",vshort,"&latitude=",lat,"&longitude=",lon,"&time_start=",yr,"-01-16T05%3A14%3A31.916Z&time_end=",yr,"-12-",day,"T00%3A34%3A14.059Z&accept=csv_file",sep ="") 
    
    
    #    http://www.yellowstone.solutions/thredds/ncss/daily_or_monthly/gcm/rcp85/inmcm4/V_1_5_2020_inmcm4_rcp85_soil_water_monthly.nc4?var=soil_water&latitude=45&longitude=-111&time_start=2020-01-16T05%3A14%3A31.916Z&time_end=2020-12-16T00%3A34%3A14.059Z&accept=csv_file
    
    #    http://www.yellowstone.solutions/thredds/ncss/daily_or_monthly/gcm/rcp85/inmcm4/V_1_5_2020_inmcm4_rcp85_soil_water_monthly.nc4?var=soil_water&latitude=45&longitude=-111&time_start=2020-01-16T05%3A14%3A31.916Z&time_end=2020-12-16T00%3A34%3A14.059Z&accept=csv_file
    
    #    http://www.yellowstone.solutions/thredds/ncss/daily_or_monthly/gcm/rcp85/inmcm4/v_1_5_2020_inmcm4_rcp85_soil_water_monthly.nc4?var=soil_water&latitude=45&longitude=-111&time_start=2020-01-16T05%3A14%3A31.916Z&time_end=2020-12-16T00%3A34%3A14.059Z&accept=csv_file
    
    
    
    
    #Specify destination on drive where file should be saved if downloading directly to pc 
    
    #destfile <- "C:\\David\\Water Balance CONUS\\downloads\\output.csv" 
    
    #specify destination on drive 
    
    #download.file(data_url, destfile) 
    
    
    
    holder <-data.frame(fread(data_url, 
                              verbose=FALSE, 
                              showProgress = FALSE,
    ))#temporary holder for subsets downloaded from cloud 
    
    mydat<-rbind(mydat, holder)#file that grows by adding each chunk downloaded from cloud 
    
    date <- mydat$time
    
  }#end loop across years 
  
  mydat2<-cbind(mydat2,mydat[,4])#append just the water balance data from each downloaded chunk 
  
  mydat<-NULL#reset this variable so it can accommodate a new column name given the new water balance variable it's extracting at each loop cycle 
  
}#end loop across climate variables 

mydat4<-cbind(mydat3,mydat2) #join the data with metadata including date, lat, long

colnames(mydat4)[]<-c("date", "lat","lon","soil_water_monthly_85", "runoff_monthly_85", "rain_monthly_85", "agdd_monthly_85", "accumswe_monthly_85", "pet_monthly_85", "deficit_monthly_85", "aet_monthly_85", "soil_water_monthly_45", "runoff_monthly_45", "rain_monthly_45", "agdd_monthly_45", "accumswe_monthly_45", "pet_monthly_45", "deficit_monthly_45", "aet_monthly_45") 

divide.by.10 <- function(x, na.rm = FALSE) {
  x/10
}

mydat5 <- mydat4 %>% 
  mutate(lat = as.character(lat),
         lon = as.character(lon)) %>% 
  mutate_if(is.numeric, divide.by.10)



#at this point if we want another loop for downloading more sites with different coordinates 

#we need to save mydat4 to the hard drive. 

# setwd("C:\\David\\Water Balance CONUS\\downloads\\")#note R requires either "\\" or "/" 

# JC fixed for this by creating a project folder, no need to setwd() when you have a project folder

write_csv(mydat5, here::here("raw_data", paste(site,"lat",lat,"lon",lon,m,"monthly_future.csv", sep = "_"))) #default is a space, sep = "" removes space

}# end loop across different climate projections

beep(1)

# here::here allows you to choose a folder in your working directory to save to
# here::here("folder I want to save to (this has to be made in your working directory before you save it)", "subfolder", "subfolder ( subfolders can be as numerous you want them to be, always separated by a commma)", "last thing in the list is the name of the object I'm saving")

#write.csv(mydat4,paste(site,lat,lon,".csv"))

