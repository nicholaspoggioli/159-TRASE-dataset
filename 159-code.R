# |- Clean the global environment ----
rm(list = ls())
while (!is.null(dev.list())) {
  dev.off(dev.list()["RStudioGD"])
}

ipak <- function(pkg) {
  new.pkg <- pkg[!(pkg %in% installed.packages()[, "Package"])]
  if (length(new.pkg))
    install.packages(new.pkg,
                     dependencies = TRUE,
                     repos = "http://cran.us.r-project.org")
  sapply(pkg, require, character.only = TRUE)
}

ipak(c(
  "tseries",
  "lmtest",
  "forecast",
  "tidyverse",
  "data.table",
  "ggpubr",
  "ggmisc",
  "ggplot2",
  "openxlsx",
  "magrittr"
))

# |- Setup Working Directory ----
path <- dirname(rstudioapi::getActiveDocumentContext()$path)
setwd(path)

##------------------------------------------------------------------------------

##Argentina 
Argentina <- list(
  Cotton = read.csv("https://resources.trase.earth/data/supply-chains/argentina/corn/v0.2.3/argentina-corn-v0.2.3-2024-01-17.csv") %>% janitor::clean_names() %>%
    mutate(product = "cotton", country = "Argentina"),
  Corn = read.csv("https://resources.trase.earth/data/supply-chains/argentina/cotton/v0.2.3/argentina-cotton-v0.2.3-2024-01-17.csv") %>% janitor::clean_names() %>%
    mutate(product = "corn", country = "Argentina"),
  Wood = read.csv("https://resources.trase.earth/data/supply-chains/argentina/soy/v1.1.1/argentina-soy-v1.1.1-2024-01-17.csv") %>% janitor::clean_names() %>%
    mutate(product = "wood-pulp", country = "Argentina"),
  Soy = read.csv("https://resources.trase.earth/data/supply-chains/argentina/wood-pulp/v0.2.3/argentina-wood-pulp-v0.2.3-2024-01-17.csv")  %>% janitor::clean_names() %>%
    mutate(product = "soy") # soy has more variables than others
) %>%
  rbindlist(use.names = TRUE,
            fill = TRUE,
            idcol = "product") %>%
  select(all_of(names(.)))

##------------------------------------------------------------------------------

#Bolivia
Bolivia <- read.csv("https://resources.trase.earth/data/supply-chains/bolivia/soy/v1.0.0/bolivia-soy-v1.0.0-2024-01-17.csv") %>% janitor::clean_names() %>% 
  mutate(product = "Soy")

##------------------------------------------------------------------------------

#Brazil
Brazil_Load <- list(
  Beef = read.csv("https://resources.trase.earth/data/supply-chains/brazil/beef/v2.2.0/brazil-beef-v2.2.0-2024-01-17.csv") %>% janitor::clean_names() %>% 
    mutate(product = "Beef", country = "Brazil"),
  Chicken = read.csv("https://resources.trase.earth/data/supply-chains/brazil/chicken/v2.0.1/brazil-chicken-v2.0.1-2024-01-17.csv") %>% janitor::clean_names() %>% 
    mutate(product = "Chicken", country = "Brazil"),
  Cocoa = read.csv("https://resources.trase.earth/data/supply-chains/brazil/cocoa/v2.5.0/brazil-cocoa-v2.5.0-2024-01-17.csv") %>% janitor::clean_names() %>% 
    mutate(product = "Cocoa", country = "Brazil"),
  Coffee = read.csv("https://resources.trase.earth/data/supply-chains/brazil/coffee/v2.5.1/brazil-coffee-v2.5.1-2024-01-17.csv") %>% janitor::clean_names() %>% 
    mutate(product = "Coffee", country = "Brazil"),
  Corn = read.csv("https://resources.trase.earth/data/supply-chains/brazil/corn/v2.5.1/brazil-corn-v2.5.1-2024-01-17.csv") %>% janitor::clean_names() %>% 
    mutate(product = "Corn", country = "Brazil"),
  Cotton = read.csv("https://resources.trase.earth/data/supply-chains/brazil/cotton/v2.5.1/brazil-cotton-v2.5.1-2024-01-17.csv") %>% janitor::clean_names() %>% 
    mutate(product = "Cotton", country = "Brazil"),
  PalmKernal = read.csv("https://resources.trase.earth/data/supply-chains/brazil/palm-kernel/v0.0.1/brazil-palm-kernel-v0.0.1-2024-01-17.csv") %>% janitor::clean_names() %>% 
    mutate(product = "PalmKernal", country = "Brazil"),
  PalmOil = read.csv("https://resources.trase.earth/data/supply-chains/brazil/palm-oil/v0.0.2/brazil-palm-oil-v0.0.2-2024-01-17.csv") %>% janitor::clean_names() %>% 
    mutate(product = "PalmOil", country = "Brazil"),
  Pork = read.csv("https://resources.trase.earth/data/supply-chains/brazil/pork/v2.0.1/brazil-pork-v2.0.1-2024-01-17.csv") %>% janitor::clean_names() %>% 
    mutate(product = "Pork", country = "Brazil"),
  Soy = read.csv("https://resources.trase.earth/data/supply-chains/brazil/soy/v2.6.0/brazil-soy-v2.6.0-2024-01-17.csv") %>% janitor::clean_names() %>% 
    mutate(product = "Soy", country = "Brazil"),
  SugarCane = read.csv("https://resources.trase.earth/data/supply-chains/brazil/sugarcane/v0.0.1/brazil-sugarcane-v0.0.1-2024-01-17.csv") %>% janitor::clean_names() %>% 
    mutate(product = "SugarCane", country = "Brazil"),
  WoodPulp = read.csv("https://resources.trase.earth/data/supply-chains/brazil/wood-pulp/v0.0.1/brazil-wood-pulp-v0.0.1-2024-01-17.csv") %>% janitor::clean_names() %>% 
    mutate(product = "WoodPulp", country = "Brazil")
)
Brazil <- rbindlist(lapply(Brazil_Load, as.data.frame), use.names = TRUE, fill = TRUE, idcol = "product") %>%
  select(all_of(names(.)))
rm(Brazil_Load)

##------------------------------------------------------------------------------

##Columbia
Columbia <- list(
  Beef = read.csv("https://resources.trase.earth/data/supply-chains/colombia/beef/v0.0.1/colombia-beef-v0.0.1-2024-01-17.csv") %>% janitor::clean_names() %>%
    mutate(product = "Beef", country = "Columbia"),
  Cocoa = read.csv("https://resources.trase.earth/data/supply-chains/colombia/cocoa/v0.0.0/colombia-cocoa-v0.0.0-2024-01-17.csv") %>% janitor::clean_names() %>%
    mutate(product = "Cocoa", country = "Columbia"),
  Coffee = read.csv("https://resources.trase.earth/data/supply-chains/colombia/coffee/v1.0.3/colombia-coffee-v1.0.3-2024-01-17.csv") %>% janitor::clean_names() %>%
    mutate(product = "Coffee", country = "Columbia"),
  Palm_Kernal = read.csv("https://resources.trase.earth/data/supply-chains/colombia/palm-kernel/v0.0.1/colombia-palm-kernel-v0.0.1-2024-01-17.csv") %>% janitor::clean_names() %>%
    mutate(product = "Palm-Kernal", country = "Columbia"),
  Palm_Oil = read.csv("https://resources.trase.earth/data/supply-chains/colombia/palm-oil/v0.0.3/colombia-palm-oil-v0.0.3-2024-01-17.csv") %>% janitor::clean_names() %>%
    mutate(product = "Palm-Oil", country = "Columbia"),
  Wood_Pulp = read.csv("https://resources.trase.earth/data/supply-chains/colombia/wood-pulp/v0.0.1/colombia-wood-pulp-v0.0.1-2024-01-17.csv") %>% janitor::clean_names() %>%
    mutate(product = "Wood-Pulp", country = "Columbia")
) %>%
  rbindlist(use.names = TRUE,
            fill = TRUE,
            idcol = "product") %>%
  select(all_of(names(.)))

##------------------------------------------------------------------------------

#CoteDIvoire
CoteDIvoire <- list(
  Cocoa = read.csv("https://resources.trase.earth/data/supply-chains/cote-divoire/cocoa/v1.0.5/cote-divoire-cocoa-v1.0.5-2024-01-17.csv") %>% janitor::clean_names() %>%
    mutate(product = "Cocoa", country = "CoteDIvoire")
) %>%
  rbindlist(use.names = TRUE,
            fill = TRUE,
            idcol = "product") %>%
  select(all_of(names(.)))
##------------------------------------------------------------------------------

#Ecuador
Ecuador <- list(
  Cocoa = read.csv("https://resources.trase.earth/data/supply-chains/ecuador/cocoa/v0.0.0/ecuador-cocoa-v0.0.0-2024-01-17.csv") %>% janitor::clean_names() %>%
    mutate(product = "Cocoa", country = "Ecuador"),
  Shrimp = read.csv("https://resources.trase.earth/data/supply-chains/ecuador/shrimp/v1.0.1/ecuador-shrimp-v1.0.1-2024-01-17.csv") %>% janitor::clean_names() %>%
    mutate(product = "Shrimp" , country = "Ecuador")
) %>%
  rbindlist(use.names = TRUE,
            fill = TRUE,
            idcol = "product") %>%
  select(all_of(names(.)))

##------------------------------------------------------------------------------
#Ghana
Ghana <- list(
  Cocoa = read.csv("https://resources.trase.earth/data/supply-chains/ghana/cocoa/v0.0.2/ghana-cocoa-v0.0.2-2024-01-17.csv") %>% janitor::clean_names() %>%
    mutate(product = "Cocoa" , country = "Ghana")
) %>%
  rbindlist(use.names = TRUE,
            fill = TRUE,
            idcol = "product") %>%
  select(all_of(names(.)))

##------------------------------------------------------------------------------
#Indonesia
Indonesia <- list(
  Palm_Oil = read.csv("https://resources.trase.earth/data/supply-chains/indonesia/palm-oil/v1.2.1/indonesia-palm-oil-v1.2.1-2024-01-17.csv") %>% janitor::clean_names() %>%
    mutate(product = "Palm_Oil", country = "Indonesia"),
  Shrimp = read.csv("https://resources.trase.earth/data/supply-chains/indonesia/shrimp/v1.0.0/indonesia-shrimp-v1.0.0-2024-01-17.csv") %>% janitor::clean_names() %>%
    mutate(product = "Shrimp", country = "Indonesia"),
  Wood_Pulp = read.csv("https://resources.trase.earth/data/supply-chains/indonesia/wood-pulp/v3.1.0/indonesia-wood-pulp-v3.1.0-2024-01-17.csv") %>% janitor::clean_names() %>%
    mutate(product = "Wood_Pulp", country = "Indonesia")
) %>%
  rbindlist(use.names = TRUE,
            fill = TRUE,
            idcol = "product") %>%
  select(all_of(names(.)))

##------------------------------------------------------------------------------
##Paraguay 
Paraguay <- list(
  Beef = read.csv("https://resources.trase.earth/data/supply-chains/paraguay/beef/v1.2.4/paraguay-beef-v1.2.4-2024-01-17.csv") %>% janitor::clean_names() %>%
    mutate(product = "Beef", country = "Paraguay"),
  Corn = read.csv("https://resources.trase.earth/data/supply-chains/paraguay/corn/v1.0.0/paraguay-corn-v1.0.0-2024-01-17.csv") %>% janitor::clean_names() %>%
    mutate(product = "corn", country = "Paraguay"),
  Soy = read.csv("https://resources.trase.earth/data/supply-chains/paraguay/soy/v1.2.6/paraguay-soy-v1.2.6-2024-01-17.csv")  %>% janitor::clean_names() %>%
    mutate(product = "soy", country = "Paraguay")
) %>%
  rbindlist(use.names = TRUE,
            fill = TRUE,
            idcol = "product") %>%
  select(all_of(names(.)))

##------------------------------------------------------------------------------

##Peru 
Peru <- list(
  Cocoa = read.csv("https://resources.trase.earth/data/supply-chains/peru/cocoa/v0.1.0/peru-cocoa-v0.1.0-2024-01-17.csv") %>% janitor::clean_names() %>%
    mutate(product = "Cocoa", country = "Peru"),
  Coffee = read.csv("https://resources.trase.earth/data/supply-chains/peru/coffee/v0.2.0/peru-coffee-v0.2.0-2024-01-17.csv") %>% janitor::clean_names() %>%
    mutate(product = "Coffee", country = "Peru"),
  Shrimp = read.csv("https://resources.trase.earth/data/supply-chains/peru/shrimp/v0.0.1/peru-shrimp-v0.0.1-2024-01-17.csv")  %>% janitor::clean_names() %>%
    mutate(product = "Shrimp", country = "Peru")
) %>%
  rbindlist(use.names = TRUE,
            fill = TRUE,
            idcol = "product") %>%
  select(all_of(names(.)))

##------------------------------------------------------------------------------

glimpse(Argentina)
glimpse(Bolivia)
# glimpse(Brazil)
glimpse(Columbia)
glimpse(CoteDIvoire)
glimpse(Ecuador)
glimpse(Ghana)
glimpse(Indonesia)
glimpse(Paraguay)
glimpse(Peru)

##------------------------------------------------------------------------------

combined_countries <- rbindlist(list(Argentina, Bolivia, Columbia, CoteDIvoire, Ecuador, Ghana, Indonesia, Paraguay, Peru), 
                                use.names = TRUE, fill = TRUE)

glimpse(combined_countries)
str(combined_countries)

#d_countries %>%
#  data.table::fwrite("combined_countries.csv")

#Outputting the data sets to a text file
# Argentina %>%
#   write.table("Argentina.txt")
# 
# Ecuador %>%
#   write.table("Ecuador.txt")
# 
# Paraguay %>%
#   write.table("Paraguay.txt")
# 
# Indonesia %>%
#   write.table("Indonesia.txt")
# 
# Peru %>%
#   write.table("Peru.txt")
# 
# Ghana %>%
#   write.table("Ghana.txt")
# 
# Brazil %>%
#   write.table("Brazil.txt")
# 
# Columbia %>%
#   write.table("Columbia.txt")
# 
# Bolivia %>%
#   write.table("Bolivia.txt")
# 
# CoteDIvoire %>%
#   write.table("CoteDIvoire.txt")

balance_avg_by_port_dest_product_year <- expand.grid(
  year = combined_countries %>% pull(year) %>% unique(),
  country_of_destination = combined_countries %>% pull(country_of_destination) %>% unique(),
  product = combined_countries %>% pull(product) %>% unique(),
  port_of_export = combined_countries %>% pull(port_of_export) %>% unique()
) %>% 
  mutate(
    avg_vol = mean(combined_countries$volume, na.rm = TRUE),
    avg_fob = mean(combined_countries$fob, na.rm = TRUE)
  )

# This will have avg by year, by destination, by products, by port as well
avg_by_port_dest_product_year <- combined_countries %>%
  group_by(year, country_of_destination, product, port_of_export) %>%
  summarise(avg_vol = volume %>% mean(na.rm = T),
            avg_fob = fob %>% mean(na.rm = T))

# Balanced data
combined_countries %>% pull(year) %>% unique() # 19 years
combined_countries %>% pull(country_of_destination) %>% unique() # 235 countries
combined_countries %>% pull(product) %>% unique() # 17 products

# 19 * 235 * 17 = 75905

avg_by_port_dest_product_year %>% nrow()

common_vars <- c("product", "year", "country_of_production", "exporter", "country_of_destination", "volume")

common_data <- combined_countries %>%
  select(all_of(common_vars))


Unique_combined <- common_data %>%
  distinct(year, country_of_destination, product, country_of_production, exporter) %>%
  mutate(
    avg_vol = mean(common_data$volume, na.rm = TRUE)
  )



