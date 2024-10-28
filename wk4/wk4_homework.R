##load library
library(tmap)
library(sf)
library(dplyr)
library(janitor)

##load data
countries <- st_read("wk4/World_Countries_Generalized_Shapefile/World_Countries_Generalized.shp")
gii <-  read.csv("wk4/gii_2010-2019.csv")

##edit data
gii <- gii %>%
  clean_names()
countries <- countries %>%
  clean_names()
gii2 <- gii %>%
  mutate(difference = gii_2019 - gii_2010)

##join
countries <- countries%>%
  merge(.,
        gii2,
        by.x="country", 
        by.y="country")

##plot
tmap_mode("plot")
tmap_options(check.and.fix = TRUE)

map_2010 <- qtm(countries,
                fill = "gii_2010",
                fillNA = "gray90",         
                    fill.palette = "Reds")
map_2010

map_2019 <- qtm(countries,
                fill = "gii_2019",
                fillNA = "gray90",         
                fill.palette = "Reds")
map_2019

map_difference <- qtm(countries,
                      fill = "difference",
                      fillNA = "gray90",         
                      fill.palette = "RdBu",   
                      fill.midpoint = median(countries$difference, na.rm = TRUE)) 

map_difference




