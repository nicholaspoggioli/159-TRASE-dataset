# |- Clean the global environment ----
rm(list = ls())
while (!is.null(dev.list())) {
  dev.off(dev.list()["RStudioGD"])
}

# |- Load all the required packages ----
ipak <- function(pkg) {
  new.pkg <- pkg[!(pkg %in% installed.packages()[, "Package"])]
  if (length(new.pkg))
    install.packages(new.pkg,
                     dependencies = TRUE,
                     repos = "http://cran.us.r-project.org")
  sapply(pkg, require, character.only = TRUE)
}

ipak(c(
  "rstudioapi",
  "tidyverse",
  "ggplot2",
  "dplyr",
  "data.table",
  "janitor"
))

# |- Setup Working Directory ----
# Note by Poggioli: This code sets the working directory to the location
#   of the R script. So all of our data need to be in the same directory
#   as the R script.
# To resolve this, I am creating a new directory in the project folder
#  for data cleaning. It will contain the raw data and code scripts and no
#  sub-directories.
path <- dirname(rstudioapi::getActiveDocumentContext()$path)
setwd(path)

###### Poggioli:  The path variable is to the directory with the code files, but the data files
#                 are in a different directory. We now need to navigate to that directory.


# |- My thinking process ----
corn <- read.csv("159-data-original/argentina-corn-v0.2.3-2024-01-17.csv") %>%
  janitor::clean_names()

# column names
corn %>% colnames()

# quick checking
corn %>% pull(year) %>% unique()
corn %>% pull(country_of_production) %>% unique()
corn %>% pull(port_of_export) %>% unique()
corn %>% pull(exporter) %>% unique()
corn %>% pull(country_of_destination) %>% unique()
corn %>% pull(economic_bloc) %>% unique()

# I want to see the difference between country_of_destination and economic_bloc

chk1 <- corn %>%
  distinct(country_of_destination, economic_bloc) %>%
  mutate(chk = country_of_destination == economic_bloc)

chk1 %>% filter(chk == FALSE)

# It seems that economic_bloc comprises various countries with EU.
# In that regards, we should consider maybe just the country_of_destination

rm(chk1)

avg_corn <- corn %>%
  group_by(year, country_of_destination) %>%
  summarise(avg_vol = volume %>% mean(na.rm = T),
            avg_fob = fob %>% mean(na.rm = T))

# here I can see avg_corn, I don't; know why you were not able to see it.

# Let me delete everything and not delete what I will need later
rm(list = ls()[!ls() %in% c("path", "ipak")])

# Main script starts here!
# |- Actual data management ----
dt <- list(
  Cotton = read.csv("159-data-original/argentina-cotton-v0.2.3-2024-01-17.csv") %>% 
    janitor::clean_names(),
  Corn = read.csv("159-data-original/argentina-corn-v0.2.3-2024-01-17.csv") %>% 
    janitor::clean_names(),
  Wood = read.csv("159-data-original/argentina-wood-pulp-v0.2.3-2024-01-17.csv") %>% 
    janitor::clean_names(),
  Soy = read.csv("159-data-original/argentina-soy-v1.1.1-2024-01-17.csv")  %>% 
    janitor::clean_names()# soy has more variables than others
) %>%
  rbindlist(use.names = T,
            fill = TRUE,
            idcol = "product") %>%
  select(year,
         country_of_destination,
         product,
         port_of_export,
         volume,
         fob)

rm(list = ls()[!ls() %in% c("path", "ipak", "dt")])

# This will have avg by year, by destination, by products, by port as well

####### Poggioli: na.rm=T removes rows with missing observations? If so, confirm if
#         losing these data affects the data quality.
avg_by_port_dest_product_year <- dt %>%
  group_by(year, country_of_destination, product, port_of_export) %>%
  summarise(avg_vol = volume %>% mean(na.rm = T),
            avg_fob = fob %>% mean(na.rm = T))

# Balanced data

###### Poggioli: Is this dropping rows or adding new rows to force the data
#         to be "balanced"? If so, check this for its impact on data quality.
dt %>% pull(year) %>% unique() # 5 years
dt %>% pull(country_of_destination) %>% unique() # 151 countries
dt %>% pull(product) %>% unique() # 4 products

# If such is the case what should be the numbers of rows for the data?
5 * 151 * 4 # 3020, however, when you examine the avg_by_dest_product_year it has 1279 observations
dt %>% nrow()

# With same logic, let's work through the avg product by port as well
balance_avg_by_port_dest_product_year <- expand.grid(
  year = dt %>% pull(year) %>% unique(),
  country_of_destination = dt %>% pull(country_of_destination) %>% unique(),
  product = dt %>% pull(product) %>% unique(),
  port_of_export = dt %>% pull(port_of_export) %>% unique()
) %>%
  merge(
    avg_by_port_dest_product_year,
    by = c("year", "country_of_destination", "product", "port_of_export"),
    all.x = T
  )

head(balance_avg_by_port_dest_product_year)
# As you see that Cotton has not been exported to Uruguay from Buenos Aires.

# Export to csv file
### POGGIOLI: I'm commenting this out so it doesn't create a large file each time
# balance_avg_by_port_dest_product_year %>%
#  data.table::fwrite("159-data-processed/balance_avg_by_port_dest_product_year.csv")



###### POGGIOLI RESUME EDITING HERE

# Some graphs
ggplot(
  data = balance_avg_by_dest_product_year %>%
    filter(product == "Wood", country_of_destination == "BRAZIL"),
  mapping = aes(x = year, y = avg_vol)
) +
  geom_line(color = "blue",
            linewidth = 1.2,
            alpha = 0.5) +
  theme_minimal() +
  labs(x = "", y = "Average annual volumn of \n Wood exported to Brazil")


ggplot(
  data = balance_avg_by_port_dest_product_year %>%
    filter(product == "Wood", 
           country_of_destination == "BRAZIL", 
           port_of_export == "BERNARDO DE YRIGOYEN"),
  mapping = aes(x = year, y = avg_vol)
) +
  geom_line(color = "blue",
            linewidth = 1.2,
            alpha = 0.5) +
  theme_minimal() +
  labs(x = "", y = "Average annual volumn of \n Wood exported to Brazil \n from BERNARDO DE YRIGOYEN port")

