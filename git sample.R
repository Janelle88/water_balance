library(RCurl)
library(tidyverse)
library(splines)


doy_avg_bc_test <- read_csv("https://raw.githubusercontent.com/Janelle88/water_balance/95bd248d6be22a8619026d5c43f2bc462aa09c8e/doy_avg_bc")


plot_decades_smooth = function(.y) { 
  
  .y_plot_bc <- ggplot(doy_avg_bc_test) + 
    stat_smooth(size = 1.5,
                se = FALSE,
                aes(x = doy,
                    y = .data[[.y]],
                    group = decades,
                    color = decades),
                method = glm,
                family = quasipoisson,
                formula = y ~ ns(x, 16)) +  
    scale_color_manual(breaks = c("1980-2019", "2020-2059", "2060-2099"),
                       values = c("#A3B86C", "#EBC944", "#1496BB"))
  
  gb <- ggplot_build(.y_plot_bc)
  
  exact_x_value_of_the_curve_maximum <- gb$data[[1]]$x[which(diff(sign(diff(gb$data[[1]]$y)))==-2)+1]
  
  .y_plot_bc <- .y_plot_bc + geom_vline(xintercept=exact_x_value_of_the_curve_maximum)
  
  print(.y_plot_bc)
}

plot_decades_smooth("runoff_daily")
plot_decades_smooth("soil_water_daily")
