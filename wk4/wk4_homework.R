## load packages
library(tmap)
library(sf)
library(dplyr)
library(janitor)
library(countrycode)


## load data
World <- st_read("World_Countries_Generalized_Shapefile/World_Countries_Generalized.shp")
HDI <-  read.csv("HDR23-24_Composite_indices_complete_time_series.csv")


## column names 
HDIcols<- HDI %>%
  clean_names() %>%
  select(iso3, country, gii_2019, gii_2010) %>%
  mutate(difference = gii_2019-gii_2010) %>%
  mutate(iso_code = countrycode(country, origin = 'country.name', destination = 'iso2c')) %>%
  mutate(iso_code2 = countrycode(iso3, origin ='iso3c', destination = 'iso2c'))


## join
Join_HDI <- World %>% 
  clean_names() %>%
  left_join(., 
            HDIcols,
            by = c("aff_iso" = "iso_code"))


## problem
Join_HDI_GB<-Join_HDI %>%
  filter(aff_iso =="GB")


##plot
tmap_mode("plot")
tmap_options(check.and.fix = TRUE)

map_difference <- qtm(Join_HDI,
                      fill = "difference",
                      fillNA = "gray90",         
                      fill.palette = "RdBu",   
                      fill.midpoint = median(Join_HDI$difference, na.rm = TRUE)) 

map_difference




