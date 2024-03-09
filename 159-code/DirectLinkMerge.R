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

##Argentina 
Argentina <- list(
  Cotton = read.csv("https://resources.trase.earth/data/supply-chains/argentina/corn/v0.2.3/argentina-corn-v0.2.3-2024-01-17.csv") %>% janitor::clean_names() %>%
    mutate(identifier = "cotton"),
  Corn = read.csv("https://resources.trase.earth/data/supply-chains/argentina/cotton/v0.2.3/argentina-cotton-v0.2.3-2024-01-17.csv") %>% janitor::clean_names() %>%
    mutate(identifier = "corn"),
  Wood = read.csv("https://resources.trase.earth/data/supply-chains/argentina/soy/v1.1.1/argentina-soy-v1.1.1-2024-01-17.csv") %>% janitor::clean_names() %>%
    mutate(identifier = "wood-pulp"),
  Soy = read.csv("https://resources.trase.earth/data/supply-chains/argentina/wood-pulp/v0.2.3/argentina-wood-pulp-v0.2.3-2024-01-17.csv")  %>% janitor::clean_names() %>%
    mutate(identifier = "soy") # soy has more variables than others
) %>%
  rbindlist(use.names = TRUE,
            fill = TRUE,
            idcol = "product") %>%
  select(all_of(names(.)))

#Bolivia
Bolivia <- read_csv("https://resources.trase.earth/data/supply-chains/bolivia/soy/v1.0.0/bolivia-soy-v1.0.0-2024-01-17.csv") %>% janitor::clean_names() %>% 
  mutate(identifier = "Soy")

#Brazil
Brazil_Load <- list(
  Beef = read_csv("https://resources.trase.earth/data/supply-chains/brazil/beef/v2.2.0/brazil-beef-v2.2.0-2024-01-17.csv") %>% janitor::clean_names() %>% 
    mutate(identifier = "Beef"),
  Chicken = read_csv("https://resources.trase.earth/data/supply-chains/brazil/chicken/v2.0.1/brazil-chicken-v2.0.1-2024-01-17.csv") %>% janitor::clean_names() %>% 
    mutate(identifier = "Chicken"),
  Cocoa = read_csv("https://resources.trase.earth/data/supply-chains/brazil/cocoa/v2.5.0/brazil-cocoa-v2.5.0-2024-01-17.csv") %>% janitor::clean_names() %>% 
    mutate(identifier = "Cocoa"),
  Coffee = read_csv("https://resources.trase.earth/data/supply-chains/brazil/coffee/v2.5.1/brazil-coffee-v2.5.1-2024-01-17.csv") %>% janitor::clean_names() %>% 
    mutate(identifier = "Coffee"),
  Corn = read_csv("https://resources.trase.earth/data/supply-chains/brazil/corn/v2.5.1/brazil-corn-v2.5.1-2024-01-17.csv") %>% janitor::clean_names() %>% 
    mutate(identifier = "Corn"),
  Cotton = read_csv("https://resources.trase.earth/data/supply-chains/brazil/cotton/v2.5.1/brazil-cotton-v2.5.1-2024-01-17.csv") %>% janitor::clean_names() %>% 
    mutate(identifier = "Cotton"),
  PalmKernal = read_csv("https://resources.trase.earth/data/supply-chains/brazil/palm-kernel/v0.0.1/brazil-palm-kernel-v0.0.1-2024-01-17.csv") %>% janitor::clean_names() %>% 
    mutate(identifier = "PalmKernal"),
  PalmOil = read_csv("https://resources.trase.earth/data/supply-chains/brazil/palm-oil/v0.0.2/brazil-palm-oil-v0.0.2-2024-01-17.csv") %>% janitor::clean_names() %>% 
    mutate(identifier = "PalmOil"),
  Pork = read_csv("https://resources.trase.earth/data/supply-chains/brazil/pork/v2.0.1/brazil-pork-v2.0.1-2024-01-17.csv") %>% janitor::clean_names() %>% 
    mutate(identifier = "Pork"),
  Soy = read_csv("https://resources.trase.earth/data/supply-chains/brazil/soy/v2.6.0/brazil-soy-v2.6.0-2024-01-17.csv") %>% janitor::clean_names() %>% 
    mutate(identifier = "Soy"),
  SugarCane = read_csv("https://resources.trase.earth/data/supply-chains/brazil/sugarcane/v0.0.1/brazil-sugarcane-v0.0.1-2024-01-17.csv") %>% janitor::clean_names() %>% 
    mutate(identifier = "SugarCane"),
  WoodPulp = read_csv("https://resources.trase.earth/data/supply-chains/brazil/wood-pulp/v0.0.1/brazil-wood-pulp-v0.0.1-2024-01-17.csv") %>% janitor::clean_names() %>% 
    mutate(identifier = "WoodPulp")
)
Brazil <- rbindlist(lapply(Brazil_Load, as.data.frame), use.names = TRUE, fill = TRUE, idcol = "product") %>%
  select(all_of(names(.)))
rm(Brazil_Load)

##Columbia
Columbia <- list(
  Beef = read.csv("https://resources.trase.earth/data/supply-chains/colombia/beef/v0.0.1/colombia-beef-v0.0.1-2024-01-17.csv") %>% janitor::clean_names() %>%
    mutate(identifier = "Beef"),
  Cocoa = read.csv("https://resources.trase.earth/data/supply-chains/colombia/cocoa/v0.0.0/colombia-cocoa-v0.0.0-2024-01-17.csv") %>% janitor::clean_names() %>%
    mutate(identifier = "Cocoa"),
  Coffee = read.csv("https://resources.trase.earth/data/supply-chains/colombia/coffee/v1.0.3/colombia-coffee-v1.0.3-2024-01-17.csv") %>% janitor::clean_names() %>%
    mutate(identifier = "Coffee"),
  Palm_Kernal = read.csv("https://resources.trase.earth/data/supply-chains/colombia/palm-kernel/v0.0.1/colombia-palm-kernel-v0.0.1-2024-01-17.csv") %>% janitor::clean_names() %>%
    mutate(identifier = "Palm-Kernal"),
  Palm_Oil = read.csv("https://resources.trase.earth/data/supply-chains/colombia/palm-oil/v0.0.3/colombia-palm-oil-v0.0.3-2024-01-17.csv") %>% janitor::clean_names() %>%
    mutate(identifier = "Palm-Oil"),
  Wood_Pulp = read.csv("https://resources.trase.earth/data/supply-chains/colombia/wood-pulp/v0.0.1/colombia-wood-pulp-v0.0.1-2024-01-17.csv") %>% janitor::clean_names() %>%
    mutate(identifier = "Wood-Pulp")
) %>%
  rbindlist(use.names = TRUE,
            fill = TRUE,
            idcol = "product") %>%
  select(all_of(names(.)))

#CoteDIvoire
CoteDIvoire <- list(
  Cocoa = read.csv("https://resources.trase.earth/data/supply-chains/cote-divoire/cocoa/v1.0.5/cote-divoire-cocoa-v1.0.5-2024-01-17.csv") %>% janitor::clean_names() %>%
    mutate(identifier = "Cocoa")
) %>%
  rbindlist(use.names = TRUE,
            fill = TRUE,
            idcol = "product") %>%
  select(all_of(names(.)))

#Ecuador
Ecuador <- list(
  Cocoa = read.csv("https://resources.trase.earth/data/supply-chains/ecuador/cocoa/v0.0.0/ecuador-cocoa-v0.0.0-2024-01-17.csv") %>% janitor::clean_names() %>%
    mutate(identifier = "Cocoa"),
  Shrimp = read.csv("https://resources.trase.earth/data/supply-chains/ecuador/shrimp/v1.0.1/ecuador-shrimp-v1.0.1-2024-01-17.csv") %>% janitor::clean_names() %>%
    mutate(identifier = "Shrimp")
) %>%
  rbindlist(use.names = TRUE,
            fill = TRUE,
            idcol = "product") %>%
  select(all_of(names(.)))

#Ghana
Ghana <- list(
  Cocoa = read.csv("https://resources.trase.earth/data/supply-chains/ghana/cocoa/v0.0.2/ghana-cocoa-v0.0.2-2024-01-17.csv") %>% janitor::clean_names() %>%
    mutate(identifier = "Cocoa")
) %>%
  rbindlist(use.names = TRUE,
            fill = TRUE,
            idcol = "product") %>%
  select(all_of(names(.)))

#Indonesia
Indonesia <- list(
  Palm_Oil = read.csv("https://resources.trase.earth/data/supply-chains/indonesia/palm-oil/v1.2.1/indonesia-palm-oil-v1.2.1-2024-01-17.csv") %>% janitor::clean_names() %>%
    mutate(identifier = "Palm_Oil"),
  Shrimp = read.csv("https://resources.trase.earth/data/supply-chains/indonesia/shrimp/v1.0.0/indonesia-shrimp-v1.0.0-2024-01-17.csv") %>% janitor::clean_names() %>%
    mutate(identifier = "Shrimp"),
  Wood_Pulp = read.csv("https://resources.trase.earth/data/supply-chains/indonesia/wood-pulp/v3.1.0/indonesia-wood-pulp-v3.1.0-2024-01-17.csv") %>% janitor::clean_names() %>%
    mutate(identifier = "Wood_Pulp")
) %>%
  rbindlist(use.names = TRUE,
            fill = TRUE,
            idcol = "product") %>%
  select(all_of(names(.)))

##Paraguay 
Paraguay <- list(
  Beef = read.csv("https://resources.trase.earth/data/supply-chains/paraguay/beef/v1.2.4/paraguay-beef-v1.2.4-2024-01-17.csv") %>% janitor::clean_names() %>%
    mutate(identifier = "Beef"),
  Corn = read.csv("https://resources.trase.earth/data/supply-chains/paraguay/corn/v1.0.0/paraguay-corn-v1.0.0-2024-01-17.csv") %>% janitor::clean_names() %>%
    mutate(identifier = "corn"),
  Soy = read.csv("https://resources.trase.earth/data/supply-chains/paraguay/soy/v1.2.6/paraguay-soy-v1.2.6-2024-01-17.csv")  %>% janitor::clean_names() %>%
    mutate(identifier = "soy")
) %>%
  rbindlist(use.names = TRUE,
            fill = TRUE,
            idcol = "product") %>%
  select(all_of(names(.)))

##Peru 
Peru <- list(
  Cocoa = read.csv("https://resources.trase.earth/data/supply-chains/peru/cocoa/v0.1.0/peru-cocoa-v0.1.0-2024-01-17.csv") %>% janitor::clean_names() %>%
    mutate(identifier = "Cocoa"),
  Coffee = read.csv("https://resources.trase.earth/data/supply-chains/peru/coffee/v0.2.0/peru-coffee-v0.2.0-2024-01-17.csv") %>% janitor::clean_names() %>%
    mutate(identifier = "Coffee"),
  Shrimp = read.csv("https://resources.trase.earth/data/supply-chains/peru/shrimp/v0.0.1/peru-shrimp-v0.0.1-2024-01-17.csv")  %>% janitor::clean_names() %>%
    mutate(identifier = "Shrimp")
) %>%
  rbindlist(use.names = TRUE,
            fill = TRUE,
            idcol = "product") %>%
  select(all_of(names(.)))

#Outputting the data sets to a text file
Argentina %>%
  write.table("Argentina.txt")

Ecuador %>%
  write.table("Ecuador.txt")

Paraguay %>%
  write.table("Paraguay.txt")

Indonesia %>%
  write.table("Indonesia.txt")

Peru %>%
  write.table("Peru.txt")

Ghana %>%
  write.table("Ghana.txt")

Brazil %>%
  write.table("Brazil.txt")

Columbia %>%
  write.table("Columbia.txt")

Bolivia %>%
  write.table("Bolivia.txt")

CoteDIvoire %>%
  write.table("CoteDIvoire.txt")



