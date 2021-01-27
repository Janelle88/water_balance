
## CFT_CF_parsing_v1 -- parse MACA data using CFT package and format for reading through RSS scripts
# Output same as RSS_MACA_Parsing.R, saved as SiteID_init_parsed.RData
# To be replaced once Rmd written from RCF project
# A. Runyon 20201009

#Units: temp = K, precip = mm, Rh = %

#rm(list=ls())

if (!require("pacman")) install.packages("pacman")
pacman::p_load(remotes, data.table, here, tidyverse, beepr, lubridate, directlabels, data.table, ggbeeswarm, gghalves, directlabels, ggrepel, splines, magrittr, janitor, ggalt, ggrepel, sp, sf) 
#pacman package installs packages required to run the script
#the p_load function is for the packages that are a part of CRAN

pacman::p_load_gh("earthlab/cft")

## Park data
proj_dir <- here::here()


# Lat <- 32.14925916
# #36.86282664
# 
# 
# Lon <- -109.4511317
#          #-112.7398567
# 
# site <-  "FOBO"
# # "PISP"


## Download data
#Variable and scenario names corresponding to MACA data directory structure
vars = c("pr", "tasmax", "tasmin")#,"rhsmax","rhsmin")
scens = c("rcp45", "rcp85")

#Variable names for output tables
VarNames = c("PrecipCustom", "TmaxCustom", "TminCustom")#,"RHmaxCustom","RHminCustom")

# GCMs to be extracted
GCMs = c('bcc-csm1-1','bcc-csm1-1-m','BNU-ESM','CanESM2','CCSM4','CNRM-CM5','CSIRO-Mk3-6-0',
         'GFDL-ESM2G','GFDL-ESM2M','HadGEM2-CC365','HadGEM2-ES365',
         'inmcm4','IPSL-CM5A-MR','IPSL-CM5A-LR','IPSL-CM5B-LR',
         'MIROC5','MIROC-ESM','MIROC-ESM-CHEM','MRI-CGCM3','NorESM1-M')
#Year range for summarizing future climate (Year - Range/2) to (Year + Range/2)

Year = 2040 #Central year
Range = 30  #Number of years to summarize (should be at least 30)

#Date ranges to be extracted
Future_StartYear = Year - (Range / 2)   #2006-2099 
#Year - Range only extracts years needed to run the code, reduces data size needed to download
Future_EndYear = Year + (Range / 2)   #2006-2099
#Year + Range only extracts years needed to run the code, reduces data size needed to download
Hist_StartYear = 1950     #1950-2005
Hist_EndYear = 2005      #1950-2005

Remove_files = "Y"   #"N"     #Removes all climate data files saved in directory

# Threshold percentages for defining Climate futures. Default low/high:  0.25, 0.75
CFLow = 0.25     
CFHigh = 0.75
CFs = c("Warm Wet", "Hot Wet", "Central", "Warm Dry", "Hot Dry") #Use spaces and characters only

############################## END INITIALS ##################################################

# Now can only use spatial object (not park name)
Site_coordinates <- data.frame(PARK=site,lat=Lat,lon=Lon)
coordinates(Site_coordinates) <- ~lon+lat
proj4string(Site_coordinates) <- "+proj=longlat +datum=NAD83 +no_defs " #same proj4string used in NPS_boundary_centroids.shp

# # Load Data - from centroids
# nps_boundary_centroids <- st_read('C:/Users/achildress/OneDrive - DOI/Documents/GIS/nps_boundary_centroids/nps_boundary_centroids.shp')
# centroid <- filter(nps_boundary_centroids, UNIT_CODE == "BIBE")
# Sp_centroid <- as_Spatial(centroid) # Does not accept sf objects 

# download data
file_refs <- cftdata(aoi = Site_coordinates, 
                     area_name = site,
                     years = c(Hist_StartYear, Hist_EndYear),
                     models = GCMs,
                     local_dir = proj_dir,
                     parameters = vars,
                     scenarios = scens,
                     ncores = parallel::detectCores() / 2)
glimpse(file_refs)
gc()
df <- cft_df(file_refs, ncores = parallel::detectCores() / 2)
glimpse(df)

######################## MANIPULATE INTO DF FOR PLOT_TABLE SCRIPT #####################
df$PrecipCustom <- df$pr/25.4
df$TmaxCustom <- 9/5 * (df$tasmax-273) + 32
df$TminCustom <- 9/5 * (df$tasmin-273) + 32
df$TavgCustom <- (df$TmaxCustom + df$TminCustom) / 2
df$RHmaxCustom <- df$rhsmax
df$RHminCustom <-df$rhsmin
df$GCM<-paste(df$model,df$rcp,sep=".")
df$Date<-as.POSIXlt(df$date,format="%Y-%m-%d")

# Date, GCM,PrecipCustom, TmaxCustom, TminCustom, RHmaxCustom, RHminCustom,TavgCustom
Baseline_all<-as.data.frame(subset(df,Date<"2006-01-01",select=c("Date", "GCM", "PrecipCustom", "TmaxCustom", "TminCustom", 
                                                                 "RHmaxCustom", "RHminCustom","TavgCustom")))
Future_all<-as.data.frame(subset(df,Date>"2005-12-31",select=c("Date", "GCM", "PrecipCustom", "TmaxCustom", "TminCustom", 
                                                               "RHmaxCustom", "RHminCustom","TavgCustom")))
save.image(paste(proj_dir,"/",site,"_init_parsed.RData",sep=""))

# Remove saved climate files

# Remove saved climate files
if(Remove_files == "Y") {
  do.call(file.remove, list(list.files(paste(proj_dir,site,sep="/"), full.names = TRUE)))
  print("Files removed")
} else {print("Files remain")}

######################################### PARSING SCRIPT END #####################################

######################################### CF CREATION ############################################


Baseline_all$Date = strptime(Baseline_all$Date, "%Y-%m-%d")
Future_all$Date = strptime(Future_all$Date, "%Y-%m-%d")

# # Subset Future_all to only be near future (2025-2055) and Baseline_all to only but until 2000
ALL_HIST<-Baseline_all
Baseline_all$Year<-format(as.Date(Baseline_all$Date, format="%Y-%m-%d"),"%Y")
Baseline_all<-subset(Baseline_all,Year<2000)
Baseline_all$Year<-NULL

ALL_FUTURE<-Future_all  
Future_all$yr = Future_all$Date$year + 1900
Future_all = subset(Future_all, yr >= Year - (Range/2) & yr <= (Year + (Range/2)))

####Set Average values for all four weather variables, using all baseline years and all climate models
BaseMeanPr = mean(Baseline_all$PrecipCustom)
BaseMeanTmx = mean(Baseline_all$TmaxCustom)
BaseMeanTmn = mean(Baseline_all$TminCustom)

####Create Future/Baseline means data tables, with averages for all four weather variables, organized by GCM
Future_Means = data.frame(aggregate(cbind(Future_all$PrecipCustom, Future_all$TmaxCustom, Future_all$TminCustom)
                                    ~ Future_all$GCM, Future_all, mean,na.rm=F))   # , Future_all$Wind
names(Future_Means) = c("GCM", "PrecipCustom", "TmaxCustom", "TminCustom")    # , "Wind"
Future_Means$TavgCustom = (Future_Means$TmaxCustom + Future_Means$TminCustom)/2

Baseline_Means = data.frame(aggregate(cbind(PrecipCustom, TmaxCustom, TminCustom)~GCM, 
                                      Baseline_all[which(Baseline_all$GCM %in% unique(Future_all$GCM)),], mean))    #  ,Baseline_all$Wind)
names(Baseline_Means) = c("GCM", "PrecipCustom", "TmaxCustom", "TminCustom")  #  , "Wind")
Baseline_Means$TavgCustom = (Baseline_Means$TmaxCustom + Baseline_Means$TminCustom)/2

#### add delta columns in order to classify CFs
Future_Means$DeltaPr = Future_Means$PrecipCustom - Baseline_Means$PrecipCustom
Future_Means$DeltaTmx = Future_Means$TmaxCustom - Baseline_Means$TmaxCustom
Future_Means$DeltaTmn = Future_Means$TminCustom - Baseline_Means$TminCustom
Future_Means$DeltaTavg = Future_Means$TavgCustom - Baseline_Means$TavgCustom

#### Set limits for CF classification
Pr0 = as.numeric(quantile(Future_Means$DeltaPr, 0))
Pr25 = as.numeric(quantile(Future_Means$DeltaPr, CFLow))
PrAvg = as.numeric(mean(Future_Means$DeltaPr))
Pr75 = as.numeric(quantile(Future_Means$DeltaPr, CFHigh))
Pr100 = as.numeric(quantile(Future_Means$DeltaPr, 1))
Tavg0 = as.numeric(quantile(Future_Means$DeltaTavg, 0))
Tavg25 = as.numeric(quantile(Future_Means$DeltaTavg, CFLow)) 
Tavg = as.numeric(mean(Future_Means$DeltaTavg))
Tavg75 = as.numeric(quantile(Future_Means$DeltaTavg, CFHigh))
Tavg100 = as.numeric(quantile(Future_Means$DeltaTavg, 1))

#### Designate Climate Future
Future_Means$CF1 = as.numeric((Future_Means$DeltaTavg<Tavg & Future_Means$DeltaPr>Pr75) | Future_Means$DeltaTavg<Tavg25 & Future_Means$DeltaPr>PrAvg)
Future_Means$CF2 = as.numeric((Future_Means$DeltaTavg>Tavg & Future_Means$DeltaPr>Pr75) | Future_Means$DeltaTavg>Tavg75 & Future_Means$DeltaPr>PrAvg)
Future_Means$CF3 = as.numeric((Future_Means$DeltaTavg>Tavg25 & Future_Means$DeltaTavg<Tavg75) & (Future_Means$DeltaPr>Pr25 & Future_Means$DeltaPr<Pr75))
Future_Means$CF4 = as.numeric((Future_Means$DeltaTavg<Tavg & Future_Means$DeltaPr<Pr25) | Future_Means$DeltaTavg<Tavg25 & Future_Means$DeltaPr<PrAvg)
Future_Means$CF5 = as.numeric((Future_Means$DeltaTavg>Tavg & Future_Means$DeltaPr<Pr25) | Future_Means$DeltaTavg>Tavg75 & Future_Means$DeltaPr<PrAvg)

#Assign full name of climate future to new variable CF
Future_Means$CF[Future_Means$CF1==1]=CFs[1]
Future_Means$CF[Future_Means$CF2==1]=CFs[2]
Future_Means$CF[Future_Means$CF3==1]=CFs[3]
Future_Means$CF[Future_Means$CF4==1]=CFs[4]
Future_Means$CF[Future_Means$CF5==1]=CFs[5]
Future_Means$CF=as.factor(Future_Means$CF)
Future_Means$CF = factor(Future_Means$CF,ordered=TRUE,levels=CFs)

#     Remove extraneous Climate Future columns
Future_Means$CF1 = NULL
Future_Means$CF2 = NULL
Future_Means$CF3 = NULL
Future_Means$CF4 = NULL
Future_Means$CF5 = NULL

#     Add column with emissions scenario for each GCM run
Future_Means$emissions[grep("rcp85",Future_Means$GCM)] = "RCP 8.5"
Future_Means$emissions[grep("rcp45",Future_Means$GCM)] = "RCP 4.5"

####Add column with CF classification to Future_all/Baseline_all
CF_GCM = data.frame(GCM = Future_Means$GCM, CF = Future_Means$CF)
Future_all = merge(Future_all, CF_GCM[1:2], by="GCM")
Baseline_all$CF = "Historical"

######################################### CF END #####################################

######################################### SCATTERPLOT CREATION ############################################
#Colors for CF values plotted side by side (match order of CFs vector)
colors5 <-  c("#8386CC","#12045C","white","#D4A99F","#E10720")

##Plot parameters

#Height and width 
PlotWidth = 15
PlotHeight = 9

#ggplot theme to control formatting parameters for plots with month on the x-axis
PlotTheme = theme(axis.text=element_text(size=20),    #Text size for axis tick mark labels
                  axis.title.x=element_blank(),               #Text size and alignment for x-axis label
                  axis.title.y=element_text(size=24, vjust=0.5,  margin=margin(t=20, r=20, b=20, l=20)),              #Text size and alignment for y-axis label
                  plot.title=element_text(size=26,face="bold",hjust=0.5, margin=margin(t=20, r=20, b=20, l=20)),      #Text size and alignment for plot title
                  legend.title=element_text(size=24),                                                                    #Text size of legend category labels
                  legend.text=element_text(size=22),                                                                   #Text size of legend title
                  legend.position = "bottom")                                                                            #Legend position

##### Scatterplots for presentation ######
## Scatterplots ##
head(Future_Means)
Longx<- "annual average temperature (F)"
Longy<- "annual average precipitation (in)"
x <- "DeltaTavg"
y <- "DeltaPr"

Future_Means$PrecipCustom<-Future_Means$PrecipCustom
Future_Means$DeltaPr<-Future_Means$DeltaPr

# No color
dualscatter = ggplot(Future_Means, aes(DeltaTavg, DeltaPr*365, xmin=Tavg25, xmax=Tavg75, ymin=Pr25*365, ymax=Pr75*365))
dualscatter  + geom_text_repel(aes(label=GCM)) +
  geom_point(colour="black",size=4) +
  theme(axis.text=element_text(size=18),
        axis.title.x=element_text(size=18,vjust=-0.2),
        axis.title.y=element_text(size=18,vjust=0.2),
        plot.title=element_text(size=18,face="bold",vjust=2,hjust=0.5),
        legend.text=element_text(size=18), legend.title=element_text(size=16)) + 
  ###
  labs(title =paste(site," Changes in climate means in 2040 by GCM run",sep=""), 
       x = paste("Changes in ",Longx,sep=""), # Change
       y = paste("Changes in ",Longy,sep="")) + #change
  scale_color_manual(name="Scenarios", values=c("black")) +
  # scale_fill_manual(name="Scenarios",values = c("black")) + 
  theme(legend.position="none") +
  geom_rect(color = "black", alpha=0) + 
  geom_hline(aes(yintercept=mean(DeltaPr*365)),linetype=2) + #change
  geom_vline(aes(xintercept=mean(DeltaTavg)),linetype=2) #change

ggsave(here::here(site, 
                  "figures",
                  paste("lat_", Lat, "_lon_", Lon, sep = ""), 
                  paste(site,"-Scatter-",x,"--",y,".png",sep="")), 
       width = 15, height = 9)

####### Scatterplot with CF color
FM<-Future_Means
# '%ni%' <- Negate('%in%')
FM$CFnew<-as.character(FM$CF)
# FM$CFnew[which(FM$CFnew %ni% FutureSubset)]<-"Not Selected"
FM$CFnew[which(FM$CFnew=="Central")]<-"Not Selected"
FM$CFnew<-factor(FM$CFnew,levels=c("Warm Wet","Hot Wet","Not Selected","Warm Dry","Hot Dry"))
levels(FM$CFnew)

ggplot(FM, aes(DeltaTavg, DeltaPr*365, xmin=Tavg25, xmax=Tavg75, ymin=Pr25*365, ymax=Pr75*365)) +
  geom_text_repel(aes(label=GCM,
                      color=CFnew),
                  box.padding = 0.5,
                  point.padding = 1.5) + 
  geom_point(size=5,
             colour="black")+
  geom_point(aes(color=CFnew),
             size=4) +
  theme(axis.text=element_text(size=18),
        axis.title.x=element_text(size=18,vjust=-0.2),
        axis.title.y=element_text(size=18,vjust=0.2),
        plot.title=element_text(size=20,face="bold",vjust=2,hjust=0.5),
        legend.text=element_text(size=20), legend.title=element_text(size=20)) + 
  ###
  labs(title =paste(" Changes in climate means centered on",Year,"\n relative to historical period (1950-2000) by GCM run",sep=" "), 
       x = paste("Change in ",Longx,sep=""), # Change
       y = paste("Change in ",Longy,sep="")) + #change
  scale_color_manual(name="Climate Futures", values=colors5) +
  scale_fill_manual(name="Climate Futures",values = colors5) + 
  guides(color=guide_legend(title="Climate Futures\n",override.aes = list(size=7))) +
  geom_rect(color = "black", alpha=0) + 
  geom_hline(aes(yintercept=mean(FM$DeltaPr*365)),linetype=2) + #change
  geom_vline(aes(xintercept=mean(FM$DeltaTavg)),linetype=2)  #change

ggsave(here::here(site, 
                  "figures",
                  paste("lat_", Lat, "_lon_", Lon, sep = ""), 
                  paste(site, "Scatter BY SCENARIO-",x,"--",y,".png",sep="")),
       width = 15, height = 9)

} #close loop for running all parks