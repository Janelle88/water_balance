# -------------
# water deficit monthly 1980 and 2018 graph
# -------------

ggplot(data = site_1980_2018) +
  geom_line(data = site_1980_2018, 
            aes(x = lubridate::month(date_new, 
                                     label = TRUE, 
                                     abbr = TRUE),
                y = deficit_monthly, # change for other measurements
                group = factor(year(date_new)),
                color = factor(lubridate::year(date_new)))) +
  geom_point(data = site_1980_2018, 
             aes(x = lubridate::month(date_new, 
                                      label = TRUE, 
                                      abbr = TRUE),
                 y = deficit_monthly,
                 group = factor(year(date_new)),
                 color = factor(lubridate::year(date_new)))) +
  theme_minimal() +
  labs(x = "Month",
       y = "Water Deficit (mm)", # change for other measurements
       color = "Year") +
  theme(legend.position = c(0.85,0.5),
        panel.grid = element_blank()) + # if direct.labels doesn't work remove this line
  # geom_dl(data = site_1980_2018,
  #         aes(x = month,
  #             y = deficit_monthly,
  #             label = factor(lubridate::year(date_new))),
  #         method = list("smart.grid")) + #smart.grid puts labs in good spot, look into other options
  scale_color_manual(breaks = c("1980", "2018"), 
                     values = c("turquoise4", "darkolivegreen3"))
# would like to make labs same colors, struggling

ggsave(here::here("figures", paste(site,lat,lon, sep = ""), paste(site,lat,lon, "deficit", "1980-2018", ".png", sep = "")))

# having issues with ggplot wanting to graph this as a continuous line
# group = is a key component here - can't say what it does, but IT IS NECCESSARY
# factor is used to make years not continuous but instead discrete

# -------------
# soil water monthly 1980 and 2018 graph
# -------------

ggplot(data = site_1980_2018) +
  geom_line(data = site_1980_2018, 
            aes(x = lubridate::month(date_new, 
                                     label = TRUE, 
                                     abbr = TRUE),
                y = soil_water_monthly, # change for other measurements
                group = factor(year(date_new)),
                color = factor(lubridate::year(date_new)))) +
  geom_point(data = site_1980_2018, 
             aes(x = lubridate::month(date_new, 
                                      label = TRUE, 
                                      abbr = TRUE),
                 y = soil_water_monthly,
                 group = factor(year(date_new)),
                 color = factor(lubridate::year(date_new)))) +
  theme_minimal() +
  labs(x = "Month",
       y = "Water (mm)", # change for other measurements
       color = "Year",
       title = "Soil Water") +
  theme(legend.position = c(0.85,0.7),
        panel.grid = element_blank()) + # if direct.labels doesn't work remove this line
  # geom_dl(data = site_1980_2018,
  #         aes(x = month,
  #             y = soil_water_monthly,
  #             label = factor(lubridate::year(date_new))),
  #         method = list("smart.grid")) +#smart.grid puts labs in good spot, look into other options
  scale_color_manual(breaks = c("1980", "2018"), 
                     values = c("cyan4", "coral3"))
# would like to make labs same colors, struggling

ggsave(here::here("figures", paste(site,lat,lon, sep = ""), paste(site,lat,lon, "soil_water", "1980-2018", ".png", sep = "")))

# -------------
# runoff monthly 1980 and 2018 graph
# -------------

ggplot(data = site_1980_2018) +
  geom_line(data = site_1980_2018, 
            aes(x = lubridate::month(date_new, 
                                     label = TRUE, 
                                     abbr = TRUE),
                y = runoff_monthly, # change for other measurements
                group = factor(year(date_new)),
                color = factor(lubridate::year(date_new)))) +
  geom_point(data = site_1980_2018, 
             aes(x = lubridate::month(date_new, 
                                      label = TRUE, 
                                      abbr = TRUE),
                 y = runoff_monthly,
                 group = factor(year(date_new)),
                 color = factor(lubridate::year(date_new)))) +
  theme_minimal() +
  labs(x = "Month",
       y = "Water (mm)", # change for other measurements
       color = "Year",
       title = "Runoff") +
  theme(legend.position = c(0.85,0.7),
        panel.grid = element_blank()) + # if direct.labels doesn't work remove this line
  # geom_dl(data = site_1980_2018,
  #         aes(x = month,
  #             y = runoff_monthly,
  #             label = factor(lubridate::year(date_new))),
  #         method = list("smart.grid")) +#smart.grid puts labs in good spot, look into other options
  scale_color_manual(breaks = c("1980", "2018"), 
                     values = c("cyan4", "coral3"))

ggsave(here::here("figures", paste(site,lat,lon, sep = ""), paste(site,lat,lon, "runoff", "1980-2018", ".png", sep = "")))

# -------------
# rain monthly 1980 and 2018 graph
# -------------

ggplot(data = site_1980_2018) +
  geom_line(data = site_1980_2018, 
            aes(x = lubridate::month(date_new, 
                                     label = TRUE, 
                                     abbr = TRUE),
                y = rain_monthly, # change for other measurements
                group = factor(year(date_new)),
                color = factor(lubridate::year(date_new)))) +
  geom_point(data = site_1980_2018, 
             aes(x = lubridate::month(date_new, 
                                      label = TRUE, 
                                      abbr = TRUE),
                 y = rain_monthly,
                 group = factor(year(date_new)),
                 color = factor(lubridate::year(date_new)))) +
  theme_minimal() +
  labs(x = "Month",
       y = "Water (mm)", # change for other measurements
       color = "Year",
       title = "Rain") +
  theme(legend.position = c(0.85,0.7),
        panel.grid = element_blank()) + # if direct.labels doesn't work remove this line
  # geom_dl(data = site_1980_2018,
  #         aes(x = month,
  #             y = rain_monthly,
  #             label = factor(lubridate::year(date_new))),
  #         method = list("smart.grid")) +#smart.grid puts labs in good spot, look into other options
  scale_color_manual(breaks = c("1980", "2018"), 
                     values = c("cyan4", "coral3"))

ggsave(here::here("figures", paste(site,lat,lon, sep = ""), paste(site,lat,lon, "rain", "1980-2018", ".png", sep = "")))

# -------------
# agdd monthly 1980 and 2018 graph
# -------------

ggplot(data = site_1980_2018) +
  geom_line(data = site_1980_2018, 
            aes(x = lubridate::month(date_new, 
                                     label = TRUE, 
                                     abbr = TRUE),
                y = agdd_monthly, # change for other measurements
                group = factor(year(date_new)),
                color = factor(lubridate::year(date_new)))) +
  geom_point(data = site_1980_2018, 
             aes(x = lubridate::month(date_new, 
                                      label = TRUE, 
                                      abbr = TRUE),
                 y = agdd_monthly,
                 group = factor(year(date_new)),
                 color = factor(lubridate::year(date_new)))) +
  theme_minimal() +
  labs(x = "Month",
       y = "Days", # change for other measurements
       color = "Year",
       title = "Accumulated Growing Degree Days") +
  theme(legend.position = c(0.85,0.7),
        panel.grid = element_blank()) + # if direct.labels doesn't work remove this line
  # geom_dl(data = site_1980_2018,
  #         aes(x = month,
  #             y = agdd_monthly,
  #             label = factor(lubridate::year(date_new))),
  #         method = list("smart.grid")) +#smart.grid puts labs in good spot, look into other options
  scale_color_manual(breaks = c("1980", "2018"), 
                     values = c("cyan4", "coral3"))

ggsave(here::here("figures", paste(site,lat,lon, sep = ""), paste(site,lat,lon, "agdd", "1980-2018", ".png", sep = "")))

# -------------
# accumulated swe 1980 and 2018 monthly graph
# -------------

ggplot(data = site_1980_2018) +
  geom_line(data = site_1980_2018, 
            aes(x = lubridate::month(date_new, 
                                     label = TRUE, 
                                     abbr = TRUE),
                y = accumswe_monthly, # change for other measurements
                group = factor(year(date_new)),
                color = factor(lubridate::year(date_new)))) +
  geom_point(data = site_1980_2018, 
             aes(x = lubridate::month(date_new, 
                                      label = TRUE, 
                                      abbr = TRUE),
                 y = accumswe_monthly,
                 group = factor(year(date_new)),
                 color = factor(lubridate::year(date_new)))) +
  theme_minimal() +
  labs(x = "Month",
       y = "Water (mm)", # change for other measurements
       color = "Year",
       title = "Accumulated Snow Water Equvalent") +
  theme(legend.position = c(0.85,0.7),
        panel.grid = element_blank()) + # if direct.labels doesn't work remove this line
  # geom_dl(data = site_1980_2018,
  #         aes(x = month,
  #             y = accumswe_monthly,
  #             label = factor(lubridate::year(date_new))),
  #         method = list("smart.grid")) +#smart.grid puts labs in good spot, look into other options
  scale_color_manual(breaks = c("1980", "2018"), 
                     values = c("cyan4", "coral3"))

ggsave(here::here("figures", paste(site,lat,lon, sep = ""), paste(site,lat,lon, "accumswe", "1980-2018", ".png", sep = "")))


# -------------
# pet monthly 1980 and 2018 graph
# -------------

ggplot(data = site_1980_2018) +
  geom_line(data = site_1980_2018, 
            aes(x = lubridate::month(date_new, 
                                     label = TRUE, 
                                     abbr = TRUE),
                y = pet_monthly, # change for other measurements
                group = factor(year(date_new)),
                color = factor(lubridate::year(date_new)))) +
  geom_point(data = site_1980_2018, 
             aes(x = lubridate::month(date_new, 
                                      label = TRUE, 
                                      abbr = TRUE),
                 y = pet_monthly,
                 group = factor(year(date_new)),
                 color = factor(lubridate::year(date_new)))) +
  theme_minimal() +
  labs(x = "Month",
       y = "Water (mm)", # change for other measurements
       color = "Year",
       title = "Potential Evapotranspiration") +
  theme(legend.position = c(0.85,0.7),
        panel.grid = element_blank()) + # if direct.labels doesn't work remove this line
  # geom_dl(data = site_1980_2018,
  #         aes(x = month,
  #             y = pet_monthly,
  #             label = factor(lubridate::year(date_new))),
  #         method = list("smart.grid")) +#smart.grid puts labs in good spot, look into other options
  scale_color_manual(breaks = c("1980", "2018"), 
                     values = c("cyan4", "coral3"))

ggsave(here::here("figures", paste(site,lat,lon, sep = ""), paste(site,lat,lon, "pet", "1980-2018", ".png", sep = "")))

# -------------
# aet monthly 1980 and 2018 graph
# -------------

ggplot(data = site_1980_2018) +
  geom_line(data = site_1980_2018, 
            aes(x = lubridate::month(date_new, 
                                     label = TRUE, 
                                     abbr = TRUE),
                y = aet_monthly, # change for other measurements
                group = factor(year(date_new)),
                color = factor(lubridate::year(date_new)))) +
  geom_point(data = site_1980_2018, 
             aes(x = lubridate::month(date_new, 
                                      label = TRUE, 
                                      abbr = TRUE),
                 y = aet_monthly,
                 group = factor(year(date_new)),
                 color = factor(lubridate::year(date_new)))) +
  theme_minimal() +
  labs(x = "Month",
       y = "Water (mm)", # change for other measurements
       color = "Year",
       title = "Actual Evapostranspiration") +
  theme(legend.position = c(0.85,0.7),
        panel.grid = element_blank()) + # if direct.labels doesn't work remove this line
  # geom_dl(data = site_1980_2018,
  #         aes(x = month,
  #             y = aet_monthly,
  #             label = factor(lubridate::year(date_new))),
  #         method = list("smart.grid")) +#smart.grid puts labs in good spot, look into other options
  scale_color_manual(breaks = c("1980", "2018"), 
                     values = c("cyan4", "coral3"))

ggsave(here::here("figures", paste(site,lat,lon, sep = ""), paste(site,lat,lon, "aet", "1980-2018", ".png", sep = "")))


# -------------
# water deficit monthly by decade graph
# -------------

ggplot(data = site_decades) +
  geom_line(data = site_decades, 
            aes(x = month,
                group = decades,
                color = decades,
                y = deficit_monthly), # change for other measurements),
            size = 1) +
  theme_minimal() +
  labs(x = "Month",
       y = "Water (mm)", # change for other measurements
       color = "Decade",
       title = "Water Deficit") +
  theme(legend.position = c(0.85,0.5),
        panel.grid = element_blank()) + # if direct.labels doesn't work remove this line
  # geom_dl(data = site_1980_2018,
  #         aes(x = month,
  #             y = deficit_monthly,
  #             label = factor(lubridate::year(date_new))),
  #         method = list("smart.grid")) + #smart.grid puts labs in good spot, look into other options
  scale_color_manual(breaks = c("1980s", "2010s"),
                     values = c("cyan4", "coral3"))
# would like to make labs same colors, struggling

ggsave(here::here("figures", paste(site,lat,lon, sep = ""), paste(site,lat,lon, "deficit", "decade", ".png", sep = "")))

# direct.label(site_wd_graph) # direct labels has to be its own line of code
# requires making the graph an object

# -------------
# soil water monthly by decade graph
# -------------

ggplot(data = site_decades) +
  geom_line(data = site_decades, 
            aes(x = month,
                y = soil_water_monthly, # change for other measurements
                group = decades,
                color = decades),
            size = 1) +
  # geom_point(data = site_decades, 
  #            aes(x = month,
  #                y = soil_water_monthly,
  #                group = decades,
  #                color = decades)) +
  theme_minimal() +
  labs(x = "Month",
       y = "Water (mm)", # change for other measurements
       color = "Decade",
       title = "Soil Water") +
  theme(legend.position = c(0.85,0.9),
        panel.grid = element_blank()) + # if direct.labels doesn't work remove this line
  # geom_dl(data = site_decades,
  #         aes(x = month,
  #             y = soil_water_monthly,
  #             label = factor(lubridate::year(date_new))),
  #         method = list("smart.grid")) +#smart.grid puts labs in good spot, look into other options
  scale_color_manual(breaks = c("1980s", "2010s"), 
                     values = c("cyan4", "coral3"))
# would like to make labs same colors, struggling

ggsave(here::here("figures", paste(site,lat,lon, sep = ""), paste(site,lat,lon, "soil_water", "decade", ".png", sep = "")))

# -------------
# runoff monthly by decade graph
# -------------

ggplot(data = site_decades) +
  geom_line(data = site_decades, 
            aes(x = month,
                y = runoff_monthly, # change for other measurements
                group = decades,
                color = decades),
            size = 1) +
  # geom_point(data = site_decades,
  #            aes(x = month,
  #                y = runoff_monthly,
  #                group = decades,
  #                color = decades)) +
  theme_minimal() +
  labs(x = "Month",
       y = "Water (mm)", # change for other measurements
       color = "Decade",
       title = "Runoff") +
  theme(legend.position = c(0.85,0.7),
        panel.grid = element_blank()) + # if direct.labels doesn't work remove this line
  # geom_dl(data = site_decades,
  #         aes(x = month,
  #             y = runoff_monthly,
  #             label = factor(lubridate::year(date_new))),
  #         method = list("smart.grid")) +#smart.grid puts labs in good spot, look into other options
  scale_color_manual(breaks = c("1980s", "2010s"), 
                     values = c("cyan4", "coral3")) 

ggsave(here::here("figures", paste(site,lat,lon, sep = ""), paste(site,lat,lon, "runoff", "decade", ".png", sep = "")))

# -------------
# rain monthly by decade graph
# -------------

ggplot(data = site_decades) +
  geom_line(data = site_decades, 
            aes(x = month,
                y = rain_monthly, # change for other measurements
                group = decades,
                color = decades),
            size = 1) +
  # geom_point(data = site_decades, 
  #            aes(x = month,
  #                y = rain_monthly,
  #                group = decades,
  #                color = decades)) +
  theme_minimal() +
  labs(x = "Month",
       y = "Water (mm)", # change for other measurements
       color = "Decade",
       title = "Rain") +
  theme(legend.position = c(0.85,0.7),
        panel.grid = element_blank()) + # if direct.labels doesn't work remove this line
  # geom_dl(data = site_decades,
  #         aes(x = month,
  #             y = rain_monthly,
  #             label = factor(lubridate::year(date_new))),
  #         method = list("smart.grid")) +#smart.grid puts labs in good spot, look into other options
  scale_color_manual(breaks = c("1980s", "2010s"), 
                     values = c("cyan4", "coral3"))

ggsave(here::here("figures", paste(site,lat,lon, sep = ""), paste(site,lat,lon, "rain", "decade", ".png", sep = "")))

# -------------
# agdd monthly by decade graph
# -------------

ggplot(data = site_decades) +
  geom_line(data = site_decades, 
            aes(x = month,
                y = agdd_monthly, # change for other measurements
                group = decades,
                color = decades),
            size = 1) +
  # geom_point(data = site_decades, 
  #            aes(x = month,
  #                y = agdd_monthly,
  #                group = decades,
  #                color = decades)) +
  theme_minimal() +
  labs(x = "Month",
       y = "Days", # change for other measurements
       color = "Decade",
       title = "Accumulated Growing Degree Days") +
  theme(legend.position = c(0.85,0.7),
        panel.grid = element_blank()) + # if direct.labels doesn't work remove this line
  # geom_dl(data = site_decades,
  #         aes(x = month,
  #             y = agdd_monthly,
  #             label = factor(lubridate::year(date_new))),
  #         method = list("smart.grid")) +#smart.grid puts labs in good spot, look into other options
  scale_color_manual(breaks = c("1980s", "2010s"), 
                     values = c("cyan4", "coral3"))

ggsave(here::here("figures", paste(site,lat,lon, sep = ""), paste(site,lat,lon, "agdd", "decade", ".png", sep = "")))

# -------------
# accumulated swe monthly by decade graph
# -------------

ggplot(data = site_decades) +
  geom_line(data = site_decades, 
            aes(x = month,
                y = accumswe_monthly, # change for other measurements
                group = decades,
                color = decades),
            size = 1) +
  # geom_point(data = site_decades, 
  #            aes(x = month,
  #                y = accumswe_monthly,
  #                group = decades,
  #                color = decades)) +
  theme_minimal() +
  labs(x = "Month",
       y = "Water (mm)", # change for other measurements
       color = "Decade",
       title = "Accumulated Snow Water Equvalent") +
  theme(legend.position = c(0.85,0.7),
        panel.grid = element_blank()) + # if direct.labels doesn't work remove this line
  # geom_dl(data = site_decades,
  #         aes(x = month,
  #             y = accumswe_monthly,
  #             label = factor(lubridate::year(date_new))),
  #         method = list("smart.grid")) +#smart.grid puts labs in good spot, look into other options
  scale_color_manual(breaks = c("1980s", "2010s"), 
                     values = c("cyan4", "coral3"))

ggsave(here::here("figures", paste(site,lat,lon, sep = ""), paste(site,lat,lon, "accumswe", "decade", ".png", sep = "")))


# -------------
# pet monthly by decade graph
# -------------

ggplot(data = site_decades) +
  geom_line(data = site_decades, 
            aes(x = month,
                y = pet_monthly, # change for other measurements
                group = decades,
                color = decades),
            size = 1) +
  # geom_point(data = site_decades, 
  #            aes(x = month,
  #                y = pet_monthly,
  #                group = decades,
  #                color = decades)) +
  theme_minimal() +
  labs(x = "Month",
       y = "Water (mm)", # change for other measurements
       color = "Decade",
       title = "Potential Evapotranspiration") +
  theme(legend.position = c(0.85,0.7),
        panel.grid = element_blank()) + # if direct.labels doesn't work remove this line
  # geom_dl(data = site_decades,
  #         aes(x = month,
  #             y = pet_monthly,
  #             label = factor(lubridate::year(date_new))),
  #         method = list("smart.grid")) +#smart.grid puts labs in good spot, look into other options
  scale_color_manual(breaks = c("1980s", "2010s"), 
                     values = c("cyan4", "coral3"))

ggsave(here::here("figures", paste(site,lat,lon, sep = ""), paste(site,lat,lon, "pet", "decade", ".png", sep = "")))

# -------------
# aet monthly by decade graph
# -------------

ggplot(data = site_decades) +
  geom_line(data = site_decades, 
            aes(x = month,
                y = aet_monthly, # change for other measurements
                group = decades,
                color = decades),
            size = 1) +
  # geom_point(data = site_decades, 
  #            aes(x = month,
  #                y = aet_monthly,
  #                group = decades,
  #                color = decades)) +
  theme_minimal() +
  labs(x = "Month",
       y = "Water (mm)", # change for other measurements
       color = "Decade",
       title = "Actual Evapostranspiration") +
  theme(legend.position = c(0.85,0.7),
        panel.grid = element_blank()) + # if direct.labels doesn't work remove this line
  # geom_dl(data = site_decades,
  #         aes(x = month,
  #             y = aet_monthly,
  #             label = factor(lubridate::year(date_new))),
  #         method = list("smart.grid")) +#smart.grid puts labs in good spot, look into other options
  scale_color_manual(breaks = c("1980s", "2010s"), 
                     values = c("cyan4", "coral3"))

ggsave(here::here("figures", paste(site,lat,lon, sep = ""), paste(site,lat,lon, "aet", "decade", ".png", sep = "")))


# -------------
# water deficit monthly by pre_post_2000 graph
# -------------

ggplot(data = site_pre_post_2000s) +
  geom_line(data = site_pre_post_2000s, 
            aes(x = month,
                y = deficit_monthly, # change for other measurements
                group = decade,
                color = decade),
            size = 1) +
  # geom_point(data = site_pre_post_2000s, 
  #            aes(x = month,
  #                y = deficit_monthly,
  #                group = decade,
  #                color = decade)) +
  theme_minimal() +
  labs(x = "Month",
       y = "Water (mm)", # change for other measurements
       color = "Decade",
       title = "Water Deficit") +
  theme(legend.position = c(0.85,0.5),
        panel.grid = element_blank()) + # if direct.labels doesn't work remove this line
  # geom_dl(data = site_1980_2018,
  #         aes(x = month,
  #             y = deficit_monthly,
  #             label = factor(lubridate::year(date_new))),
  #         method = list("smart.grid")) + #smart.grid puts labs in good spot, look into other options
  scale_color_manual(breaks = c("Pre 2000s", "Post 2000s"),
                     values = c("cyan4", "coral3"))
# would like to make labs same colors, struggling

ggsave(here::here("figures", paste(site,lat,lon, sep = ""), paste(site,lat,lon, "deficit", "pre_post_2000", ".png", sep = "")))

# direct.label(site_wd_graph) # direct labels has to be its own line of code
# requires making the graph an object

# -------------
# soil water monthly by pre_post_2000 graph
# -------------

ggplot(data = site_pre_post_2000s) +
  geom_line(data = site_pre_post_2000s, 
            aes(x = month,
                y = soil_water_monthly, # change for other measurements
                group = decade,
                color = decade),
            size = 1) +
  # geom_point(data = site_pre_post_2000s, 
  #            aes(x = month,
  #                y = soil_water_monthly,
  #                group = decade,
  #                color = decade)) +
  theme_minimal() +
  labs(x = "Month",
       y = "Water (mm)", # change for other measurements
       color = "Decade",
       title = "Soil Water") +
  theme(legend.position = c(0.85,0.9),
        panel.grid = element_blank()) + # if direct.labels doesn't work remove this line
  # geom_dl(data = site_pre_post_2000s,
  #         aes(x = month,
  #             y = soil_water_monthly,
  #             label = factor(lubridate::year(date_new))),
  #         method = list("smart.grid")) +#smart.grid puts labs in good spot, look into other options
  scale_color_manual(breaks = c("Pre 2000s", "Post 2000s"), 
                     values = c("cyan4", "coral3"))
# would like to make labs same colors, struggling

ggsave(here::here("figures", paste(site,lat,lon, sep = ""), paste(site,lat,lon, "soil_water", "pre_post_2000", ".png", sep = "")))

# -------------
# runoff monthly by pre_post_2000 graph
# -------------

ggplot(data = site_pre_post_2000s) +
  geom_line(data = site_pre_post_2000s, 
            aes(x = month,
                y = runoff_monthly, # change for other measurements
                group = decade,
                color = decade),
            size = 1) +
  # geom_point(data = site_pre_post_2000s,
  #            aes(x = month,
  #                y = runoff_monthly,
  #                group = decade,
  #                color = decade)) +
  theme_minimal() +
  labs(x = "Month",
       y = "Water (mm)", # change for other measurements
       color = "Decade",
       title = "Runoff") +
  theme(legend.position = c(0.85,0.7),
        panel.grid = element_blank()) + # if direct.labels doesn't work remove this line
  # geom_dl(data = site_pre_post_2000s,
  #         aes(x = month,
  #             y = runoff_monthly,
  #             label = factor(lubridate::year(date_new))),
  #         method = list("smart.grid")) +#smart.grid puts labs in good spot, look into other options
  scale_color_manual(breaks = c("Pre 2000s", "Post 2000s"), 
                     values = c("cyan4", "coral3")) 

ggsave(here::here("figures", paste(site,lat,lon, sep = ""), paste(site,lat,lon, "runoff", "pre_post_2000", ".png", sep = "")))

# -------------
# rain monthly by pre_post_2000 graph
# -------------

ggplot(data = site_pre_post_2000s) +
  geom_line(data = site_pre_post_2000s, 
            aes(x = month,
                y = rain_monthly, # change for other measurements
                group = decade,
                color = decade),
            size = 1) +
  # geom_point(data = site_pre_post_2000s, 
  #            aes(x = month,
  #                y = rain_monthly,
  #                group = decade,
  #                color = decade)) +
  theme_minimal() +
  labs(x = "Month",
       y = "Water (mm)", # change for other measurements
       color = "Decade",
       title = "Rain") +
  theme(legend.position = c(0.85,0.7),
        panel.grid = element_blank()) + # if direct.labels doesn't work remove this line
  # geom_dl(data = site_pre_post_2000s,
  #         aes(x = month,
  #             y = rain_monthly,
  #             label = factor(lubridate::year(date_new))),
  #         method = list("smart.grid")) +#smart.grid puts labs in good spot, look into other options
  scale_color_manual(breaks = c("Pre 2000s", "Post 2000s"), 
                     values = c("cyan4", "coral3"))

ggsave(here::here("figures", paste(site,lat,lon, sep = ""), paste(site,lat,lon, "rain", "pre_post_2000", ".png", sep = "")))

# -------------
# agdd monthly by pre_post_2000 graph
# -------------

ggplot(data = site_pre_post_2000s) +
  geom_line(data = site_pre_post_2000s, 
            aes(x = month,
                y = agdd_monthly, # change for other measurements
                group = decade,
                color = decade),
            size = 1) +
  # geom_point(data = site_pre_post_2000s, 
  #            aes(x = month,
  #                y = agdd_monthly,
  #                group = decade,
  #                color = decade)) +
  theme_minimal() +
  labs(x = "Month",
       y = "Days", # change for other measurements
       color = "Decade",
       title = "Accumulated Growing Degree Days") +
  theme(legend.position = c(0.85,0.7),
        panel.grid = element_blank()) + # if direct.labels doesn't work remove this line
  # geom_dl(data = site_pre_post_2000s,
  #         aes(x = month,
  #             y = agdd_monthly,
  #             label = factor(lubridate::year(date_new))),
  #         method = list("smart.grid")) +#smart.grid puts labs in good spot, look into other options
  scale_color_manual(breaks = c("Pre 2000s", "Post 2000s"), 
                     values = c("cyan4", "coral3"))

ggsave(here::here("figures", paste(site,lat,lon, sep = ""), paste(site,lat,lon, "agdd", "pre_post_2000", ".png", sep = "")))

# -------------
# accumulated swe monthly by pre_post_2000 graph
# -------------

ggplot(data = site_pre_post_2000s) +
  geom_line(data = site_pre_post_2000s, 
            aes(x = month,
                y = accumswe_monthly, # change for other measurements
                group = decade,
                color = decade),
            size = 1) +
  # geom_point(data = site_pre_post_2000s, 
  #            aes(x = month,
  #                y = accumswe_monthly,
  #                group = decade,
  #                color = decade)) +
  theme_minimal() +
  labs(x = "Month",
       y = "Water (mm)", # change for other measurements
       color = "Decade",
       title = "Accumulated Snow Water Equvalent") +
  theme(legend.position = c(0.85,0.7),
        panel.grid = element_blank()) + # if direct.labels doesn't work remove this line
  # geom_dl(data = site_pre_post_2000s,
  #         aes(x = month,
  #             y = accumswe_monthly,
  #             label = factor(lubridate::year(date_new))),
  #         method = list("smart.grid")) +#smart.grid puts labs in good spot, look into other options
  scale_color_manual(breaks = c("Pre 2000s", "Post 2000s"), 
                     values = c("cyan4", "coral3"))

ggsave(here::here("figures", paste(site,lat,lon, sep = ""), paste(site,lat,lon, "accumswe", "pre_post_2000", ".png", sep = "")))


# -------------
# pet monthly by pre_post_2000 graph
# -------------

ggplot(data = site_pre_post_2000s) +
  geom_line(data = site_pre_post_2000s, 
            aes(x = month,
                y = pet_monthly, # change for other measurements
                group = decade,
                color = decade),
            size = 1) +
  # geom_point(data = site_pre_post_2000s, 
  #            aes(x = month,
  #                y = pet_monthly,
  #                group = decade,
  #                color = decade)) +
  theme_minimal() +
  labs(x = "Month",
       y = "Water (mm)", # change for other measurements
       color = "Decade",
       title = "Potential Evapotranspiration") +
  theme(legend.position = c(0.85,0.7),
        panel.grid = element_blank()) + # if direct.labels doesn't work remove this line
  # geom_dl(data = site_pre_post_2000s,
  #         aes(x = month,
  #             y = pet_monthly,
  #             label = factor(lubridate::year(date_new))),
  #         method = list("smart.grid")) +#smart.grid puts labs in good spot, look into other options
  scale_color_manual(breaks = c("Pre 2000s", "Post 2000s"), 
                     values = c("cyan4", "coral3"))

ggsave(here::here("figures", paste(site,lat,lon, sep = ""), paste(site,lat,lon, "pet", "pre_post_2000", ".png", sep = "")))

# -------------
# aet monthly by pre_post_2000 graph
# -------------

ggplot(data = site_pre_post_2000s) +
  geom_line(data = site_pre_post_2000s, 
            aes(x = month,
                y = aet_monthly, # change for other measurements
                group = decade,
                color = decade),
            size = 1) +
  # geom_point(data = site_pre_post_2000s, 
  #            aes(x = month,
  #                y = aet_monthly,
  #                group = decade,
  #                color = decade)) +
  theme_minimal() +
  labs(x = "Month",
       y = "Water (mm)", # change for other measurements
       color = "Decade",
       title = "Actual Evapostranspiration") +
  theme(legend.position = c(0.85,0.7),
        panel.grid = element_blank()) + # if direct.labels doesn't work remove this line
  # geom_dl(data = site_pre_post_2000s,
  #         aes(x = month,
  #             y = aet_monthly,
  #             label = factor(lubridate::year(date_new))),
  #         method = list("smart.grid")) +#smart.grid puts labs in good spot, look into other options
  scale_color_manual(breaks = c("Pre 2000s", "Post 2000s"), 
                     values = c("cyan4", "coral3"))

ggsave(here::here("figures", paste(site,lat,lon, sep = ""), paste(site,lat,lon, "aet", "pre_post_2000", ".png", sep = "")))

site_year_df <- site_df %>% 
  mutate(year = as.numeric(as.character(year)), 
         month = as.numeric(as.character(month))) %>% 
  group_by(year) %>% 
  summarize(runoff_yearly = sum(runoff_monthly),
            accumswe_yearly = sum(accumswe_monthly),
            rain_yearly = sum(rain_monthly),
            pet_yearly = sum(pet_monthly),
            aet_yearly = sum(aet_monthly),
            soil_water_yearly = sum(soil_water_monthly),
            agdd_yearly = sum(agdd_monthly),
            deficit_yearly = sum(deficit_monthly))  


