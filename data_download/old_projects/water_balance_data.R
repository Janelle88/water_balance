# ----------
# Janelle Christensen
# purpose: data mining the thredds website
# what will happen: download all data from the thredds website
# historical daily, historical monthly, future daily (all models), future monthly (all models)
# adjust as needed
# ----------

# ----------
# DAILY HISTORICAL LOOP
# ----------

#initialize with time range of inerest and location, these don't get overwritten in loops 



site = "little_saddle_mtn" 

lat = 44.702

lon = -110.018

start = 1980 

end = 2019 



#initialize some variables to hold data 

holder<-NULL 

mydat<-NULL 

mydat2<-NULL 

mydat3<-NULL 



#This is the loop that runs across all the climate variables you want to download 

for(climvar in c("soil_water", "runoff", "rain", "agdd","accumswe", "PET", "Deficit", "AET")){ 
  
  
  
  print(paste("downloading",climvar))#this is a progress update as the loop runs 
  
  
  for(yr in c(start:end)){# for each climate variable loop across the year.  allows users to select range if not interested in all data 
    
    #Specify URL where are stored on cloud 
    
    #access daily data
    
    # 1980 has only 30 days in December, all other years have 31
    
    if(yr == 1980){
      day <- 30
    } else {
      day <- 31
    }
    
    data_url<-paste("http://www.yellowstone.solutions/thredds/ncss/daily_or_monthly/v2_historical/daily/v2_",yr,"_",climvar,".nc4?var=",climvar,"&latitude=",lat,"&longitude=",lon,"&time_start=",yr,"-01-01T12%3A00%3A00Z&time_end=",yr,"-12-",day,"T12%3A00%3A00Z&accept=csv_file",sep ="") 
    
    
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

colnames(mydat3)[]<-c("date", "lat","lon","soil_water_daily", "runoff_daily", "rain_daily", "agdd_daily", "accumswe_daily", "pet_daily", "deficit_daily", "aet_daily") 

head(mydat3)

write_csv(mydat3, here::here("historical_daily_data","raw_data", paste(site,"lat",lat,"lon",lon,"daily_historical.csv", sep = "_"))) #default is a space, sep = "" removes space


# ------------
# MONTHLY HISTORICAL LOOP
# ------------

#initialize some variables to hold data 

holder <- NULL 

mydat <- NULL 

mydat2 <- NULL 

mydat3 <- NULL 



#This is the loop that runs across all the climate variables you want to download 

for(climvar in c("soil_water_monthly", "runoff_monthly", "rain_monthly", "agdd_monthly","accumswe_monthly", "PET_monthly", "Deficit_monthly", "AET_monthly")){ 
  
  
  
  print(paste("downloading",climvar))#this is a progress update as the loop runs 
  
  
  
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
    
    data_url<-paste("http://www.yellowstone.solutions/thredds/ncss/daily_or_monthly/v2_historical/monthly/v2_",yr,"_",climvar,".nc4?var=",vshort,"&latitude=",lat,"&longitude=",lon,"&time_start=1980-01-16T05%3A14%3A31.916Z&time_end=1980-12-16T00%3A34%3A14.059Z&accept=csv_file",sep ="") 
    
    
    
    #Specify destination on drive where file should be saved if downloading directly to pc 
    
    #destfile <- "C:\\David\\Water Balance CONUS\\downloads\\output.csv" 
    
    #specify destination on drive 
    
    #download.file(data_url, destfile) 
    
    
    
    holder <-data.frame(fread(data_url, 
                              verbose=FALSE, 
                              showProgress = FALSE,
    ))#temporary holder for subsets downloaded from cloud 
    
    mydat<-rbind(mydat, holder)#file that grows by adding each chunk downloaded from cloud 
    
  }#end loop across years 
  
  mydat2<-cbind(mydat2,mydat[,4])#append just the water balance data from each downloaded chunk 
  
  date <- mydat$time # date will download wrong
  
  mydat<-NULL#reset this variable so it can accodomate a new column name given the new water balance variable it's extracting at each loop cycle
  
  
}#end loop across climate variables 


beep(4)


mydat3<-cbind(date,holder[,2:3],mydat2)#join the data with metadat including date, lat, long 

colnames(mydat3)[]<-c("date", "lat","lon","soil_water_monthly", "runoff_monthly", "rain_monthly", "agdd_monthly", "accumswe_monthly", "pet_monthly", "deficit_monthly", "aet_monthly") 


write_csv(mydat3, here::here("historical_monthly_data","raw_data", paste(site,"lat",lat,"lon",lon,"monthly_historical.csv", sep = "_"))) #default is a space, sep = "" removes space

# here::here allows you to choose a folder in your working directory to save to
# here::here("folder I want to save to (this has to be made in your working directory before you save it)", "subfolder", "subfolder ( subfolders can be as numerous you want them to be, always separated by a commma)", "last thing in the list is the name of the object I'm saving")


