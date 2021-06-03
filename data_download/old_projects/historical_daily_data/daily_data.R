library(data.table) 
library(here)
library(tidyverse)
library(beepr)
library(lubridate)
library(directlabels)
library(data.table) 



#set up a few initial conditions for testing.  These get over written in the loops 

climvar <- "runoff" 

climvar <- "PET" 

yr = 1980 



#initialize with time range of inerest and location, these don't get overwritten in loops 

site = "ashland" 

lat = 42.194342

lon =  -122.703127

start = 1980 

end = 2019 



#initialize some variables to hold data 

holder<-NULL 

mydat<-NULL 

mydat2<-NULL 

mydat3<-NULL 



#This is the loop that runs across all the climate variables you want to download 

for(climvar in c("agdd")){ 
  
  
  
  print(paste("downloading",climvar))#this is a progress update as the loop runs 
  
  
  
  #the url uses two variable names for same variable in daily download string like "PET_daily" for long name and "pet" for short name 
  
  #the short name is sometimes a different case than the long variable name, so make it lowercase so that 
  
  #url string will work with the format of data stored on the cloud 
  
  # varshort<-climvar;varshort 
  # 
  # vshort<-varshort[[1]];vshort 
  # 
  # if(vshort=="PET"){ 
  #   
  #   vshort<-"pet" 
  #   
  # };vshort 
  # 
  # 
  # 
  # if(vshort=="Deficit"){#change case of short name from upper to lower case 
  #   
  #   vshort<-"deficit" 
  #   
  # };vshort 
  # 
  # 
  # 
  # 
  # 
  # if(vshort=="AET"){ 
  #   
  #   vshort<-"aet" 
  #   
  # };vshort 
  # 
  # 
  
  for(yr in c(start:end)){# for each climate variable loop across the year.  allows users to select range if not interested in all data 
    
    #Specify URL where are stored on cloud 
    
    #data_url<-"http://www.yellowstone.solutions/thredds/ncss/daily_or_daily/v2_historical/daily/v2_2019_soil_water.nc4?var=soil_water&latitude=45&longitude=-111&time_start=2019-01-01T12%3A00%3A00Z&time_end=2019-12-31T12%3A00%3A00Z&accept=csv_file" 
    
    #access daily data 
    
    #example single variable single year timeseries 
    
    #data_url<-paste("http://www.yellowstone.solutions/thredds/ncss/daily_or_daily/v2_historical/daily/v2_",yr,"_",climvar,".nc4?var=",climvar,"&latitude=",lat,"&longitude=",lon,"&time_start=",yr,"-01-01T12%3A00%3A00Z&time_end=",yr,"-12-31T12%3A00%3A00Z&accept=csv_file", sep="") 
    
    #single variable single year daily time series with variable and year specified by user 
    if(yr == 1980){
      day <- 30
    } else {
      day <- 31
    }
    
    data_url<-paste("http://www.yellowstone.solutions/thredds/ncss/daily_or_monthly/v2_historical/daily/v2_",yr,"_",climvar,".nc4?var=",climvar,"&latitude=",lat,"&longitude=",lon,"&time_start=",yr,"-01-01T12%3A00%3A00Z&time_end=",yr,"-12-",day,"T12%3A00%3A00Z&accept=csv_file",sep ="") 
    
    #http://www.yellowstone.solutions/thredds/ncss/daily_or_monthly/v2_historical/daily/v2_1980_soil_water.nc4?var=soil_water&latitude=45&longitude=-111&time_start=1980-01-01T12%3A00%3A00Z&time_end=1980-12-30T12%3A00%3A00Z&accept=csv_file
  
    #http://www.yellowstone.solutions/thredds/ncss/daily_or_monthly/v2_historical/daily/v2_1980_soil_water.nc4?var=soil_water&latitude=45&longitude=-111&time_start=1980-01-01T12%3A00%3A00Z&time_end=1980-12-30T12%3A00%3A00Z&accept=csv_file

    
    #Specify destination on drive where file should be saved if downloading directly to pc 
    
    #destfile <- "C:\\David\\Water Balance CONUS\\downloads\\output.csv" 
    
    #specify destination on drive 
    
    #download.file(data_url, destfile) 
    
    
    
    holder <-data.frame(fread(data_url, verbose=FALSE, showProgress = FALSE))#temporary holder for subsets downloaded from cloud 
    
    mydat<-rbind(mydat, holder)#file that grows by adding each chunk downloaded from cloud 
    
  }#end loop across years 
  
  beep(4)
  
  mydat2<-cbind(mydat2,mydat[,4])#append just the water balance data from each downloaded chunk
  
  date <- mydat$time
  
  mydat<-NULL#reset this variable so it can accodomate a new column name given the new water balance variable it's extracting at each loop cycle
  
  
}#end loop across climate variables 

beep(4)


mydat3<-cbind(date,holder[,2:3],mydat2)#join the data with metadat including date, lat, long 

colnames(mydat3)[]<-c("date", "lat","lon", "agdd_daily") 

head(mydat3) 



#dates downloaded with data are wrong, they are all 2018 for some reason 

# span<-end-start;span#of years downloaded
# 
# year<-rep(start:end,each=365);year
# 
# month<-rep(1:12,(span+1));month
# 
# month <- 
# 
# doy <- rep(1:365, span+1);day
#   
#   # ifelse(year == 1980 && month == c(4,6,9,11,12), day <- rep(1:30),
#   #      ifelse(year == c(1981:end) && month == c(4,6,9,11), day <- rep(1:30), day <- rep(1:31)));day # trying to get the dates in order, but will use lubridate.
# # come back to this if this doesn't work
# 
# 
# 
# length(year); length(month); nrow(mydat3)
# 
# names(mydat3)
# 
# mydat4<-cbind(year,month,doy,mydat3[,c(2:11)]);head(mydat4)#drop bogus dates and add year and month


write_csv(mydat3, here::here(paste(site,"lat",lat,"lon",lon,"daily_historical.csv", sep = "_"))) #default is a space, sep = "" removes space
