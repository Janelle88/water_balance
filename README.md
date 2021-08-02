# Water Balance Projections

This project is meant to download information from the [thredds server](http://www.yellowstone.solutions/thredds/catalog.html) for water balance projections  using a few specified values.
The values that need to be defined are at the tope of each rmd file. They are:

- site = a common name for the site you are looking at
- lat = latitude of the site
- lon = longitude of the site
- model_bc = which model have you selected to represent the "best case" scenario? Options are given in the code.
- model_bc_rcp = what is the RCP of the model you have selected to represent the "best case" scenario? Options are given in the code
- model_bc_rcp_name = a more "readable" version of the name for the RCP
- model_wc = which model have you selected to represent the "worst case" scenario? Options are given in the code.
- model_wc_rcp = what is the RCP of the model you have selected to represent the "worst case" scenario? Options are given in the code
- model_wc_rcp_name = a more "readable" version of the name for the RCP
- past_data = which data set have you selected to represent historical data? Options are given in the code.
- dry_year = What is a historically dry year in the latitude and longitude you are looking at? Possibly a year with a lot of fire?
- wet_year = what is a historically wet year in the latitude and logitude you are looking at? Possibly a year with flooding?

This code runs has been run off of 4.1, but it still works with earlier versions (I have not tested to see how far back it will work). Additionally, this code requires use of project directories and a basic understanding of the `here` package. File organization is key here, there are many articles on how to best organize your files, why projects (rather than using setwd()) are crucial to reproducible data, and why we should all be using them. I won't go into that here, but [this blog](https://martinctc.github.io/blog/rstudio-projects-and-working-directories-a-beginner's-guide/) has a good summary. If you need help understanding how to set up a directory in R, [this website](https://support.rstudio.com/hc/en-us/articles/200526207-Using-Projects) explains it pretty well.

When opening and running the project for always make sure to open the .Rproj file, otherwise your code may tell you that it cannot find the file, causing the code to abort. 


## To update R:

### Enter the following code for windows:

1. install.packages("installr")
2. library(installr)
3. updateR()

[More information here](https://www.r-statistics.com/2015/06/a-step-by-step-screenshots-tutorial-for-upgrading-r-on-windows/#:~:text=If%20you%20are%20running%20R,installr%20updateR()%20%23%20updating%20R.)


### Enter the following code for mac

1. install.packages('devtools') assuming it is not already installed
2. library(devtools)
3. install_github('andreacirilloac/updateR')
4. library(updateR)
5. updateR(admin_password = 'Admin user password')

[More information here](http://www.andreacirillo.com/2018/03/10/updater-package-update-r-version-with-a-function-on-mac-osx/)


R may tell you to open RGui

[More information about RGui here](https://www.dummies.com/programming/r/how-to-navigate-rgui/)

You can run this code on a newer version of R but still have access to your older version if needed. This can be done by going to tools -> global options and changing the version of R to run this code. [This website](https://support.rstudio.com/hc/en-us/articles/212364537-Multiple-Versions-of-R-in-RStudio-Server-Pro) gives a bit more information about doing this, and [this website](https://cran.r-project.org/bin/windows/base/old/) gives access to all the previous and most recent version of R.

### How to have (and switch between) multiple versions of R on RStudio

Oftentimes, people need to work in older versions of R for certain packages. Fortunately, RStudio can support more than one version, allowing you to switch between them easily. [This website](http://derekogle.com/IFAR/supplements/installations/InstallRStudioWin.html) gives detail instructions on how to switch between Rstudo versions.


### Run the scripts in the following order:

1. Create model scatterplot and select models to be used. This can be done one of two ways:
    + Go to the [MACA website](https://climate.northwestknowledge.net/MACA/vis_scatterplot.php), and enter in your latitude and longitude, change the x axis to mean temperature and Jan-Dec, change the y axis to precipitation - absolute change and Jan-Dec, and press get visualization.
    ![MACA screenshot](https://github.com/Janelle88/water_balance/blob/master/figures/Screenshot%20(98).png)
    + copy the data (inclding the headers) from the data tab into your notepad and save it as a .txt file labeled Sitename_t_v_p.txt (sitename should be changed to the EXACT way it will be written in the code, i.e. if you are writing site = "YELL", this file should be named YELL_t_v_p.txt) and save it in the raw_data file of your site folder. You can create the folder structure by running the directory create code chunk from the water_balance_data.Rmd file (lines 148 - 176).
    + model_selection_graph.R OR select your models using the scatterplot on the [MACA website](https://climate.northwestknowledge.net/MACA/vis_scatterplot.php). Keep in mind that model selection isn't always intuitive, but using the scatterplot, you can select for what type of future you would like to see. There are some models that do not represent certain parts of the country well, so be aware of that as well.
    + this allows you to select which models you believe will best bracket your climate futures. Once you have run this code, you must select two models from the graph along with their RCPs (either 4.5 or 8.5) which will be input into the following two steps
2. water_balance_data.Rmd
    + this downloads all the data required to run the graphs script. I recommend running it over night, as the data can take quite some time to download.
3. water_balance_graphs.Rmd
    + this is the final report, which displays the data in graphical form
    
#### Run multiple sites at once using run_rmd
If you have a csv that has column headers as displayed in the run_multiple_sites.csv file, you should be able to use the run_rmd to run the report from that csv. This is especially useful if you have a number of latitudes and longitudes you would like to look at, it will essentially loop through the data download and the report generation for each latitude and longitude
     ***IMPORTANT*** be sure to make sure that the variable names within the Rmd are commented out. If you don't do this, it will create the exact same report for all of your sites but just change the file name.
