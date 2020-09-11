# water_balance

This project is meant to download information from the thredds server for water balance projections (http://www.yellowstone.solutions/thredds/catalog.html) using a few specified values.
The values that need to be defined are at the tope of each rmd file. They are:

site = a common name for the site you are looking at
lat = latitude of the site
lon = longitude of the site
model_bc = which model have you selected to represent the "best case" scenario? Options are given in the code.
model_bc_rcp = what is the RCP of the model you have selected to represent the "best case" scenario? Options are given in the code
model_bc_rcp_name = a more "readable" version of the name for the RCP
model_wc = which model have you selected to represent the "worst case" scenario? Options are given in the code.
model_wc_rcp = what is the RCP of the model you have selected to represent the "worst case" scenario? Options are given in the code
model_wc_rcp_name = a more "readable" version of the name for the RCP
past_data = which data set have you selected to represent historical data? Options are given in the code.
dry_year = What is a historically dry year in the latitude and longitude you are looking at? Possibly a year with a lot of fire?
wet_year = what is a historically wet year in the latitude and logitude you are looking at? Possibly a year with flooding?

This code runs off the most recent version of R. Additionally, this code requires use of project directories and a basic understanding of the `here` package. File organization is key here, there are many articles on how to best organize your files, why projects (rather than using setwd()) are crucial to reproducible data, and why we should all be using them. I won't go into that here, but this blog (https://martinctc.github.io/blog/rstudio-projects-and-working-directories-a-beginner's-guide/) has a good summary. If you need help understanding how to set up a directory in R, this website (https://support.rstudio.com/hc/en-us/articles/200526207-Using-Projects) explains it pretty well.

There are two code chunks that set up the file paths in your working directory that will not be run with the rest of the code when you knit the document or select "run all", but need to be run individually, once.

To update R:

Enter the following code for windows:

1. install.packages("installr")
2. library(installr)
3. updateR()

More information here: https://www.r-statistics.com/2015/06/a-step-by-step-screenshots-tutorial-for-upgrading-r-on-windows/#:~:text=If%20you%20are%20running%20R,installr%20updateR()%20%23%20updating%20R.


Enter the following code for mac:

1. install.packages('devtools') assuming it is not already installed
2. library(devtools)
3. install_github('andreacirilloac/updateR')
4. library(updateR)
5. updateR(admin_password = 'Admin user password')

More information here: http://www.andreacirillo.com/2018/03/10/updater-package-update-r-version-with-a-function-on-mac-osx/


R may tell you to open RGui

More information about RGui here: https://www.dummies.com/programming/r/how-to-navigate-rgui/
