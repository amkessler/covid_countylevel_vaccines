# cdc dashboard lives here:
# https://covid.cdc.gov/covid-data-tracker/#county-view
# h/t to Matt Stiles for doing this in Python here: 
# https://github.com/stiles/notebooks/blob/master/coronavirus/11-vaccine-counties.ipynb

library(tidyverse)
library(janitor)
library(jsonlite)
options(scipen = 999)
options(stringsAsFactors = FALSE)

# set the url target for the ajax endpoint
data_url <- "https://covid.cdc.gov/covid-data-tracker/COVIDData/getAjaxData?id=vaccination_county_condensed_data"

# parse the json
content <- fromJSON(data_url)
# returns a list
class(content)

# second element contains our the county dataset 
content[[2]] 

# create dataframe (tibble) from just the second element
content2_df <- as_tibble(content[[2]])

# take a look at what we have
glimpse(content2_df)

# clean up column names and create more descriptive df object name
cdc_vaxdata_countylevel <-  content2_df %>% 
  janitor::clean_names()

head(cdc_vaxdata_countylevel)

# export results to csv
write_csv(cdc_vaxdata_countylevel, "cdc_vaxdata_countylevel.csv")
# and rds
saveRDS(cdc_vaxdata_countylevel, "cdc_vaxdata_countylevel.rds")

