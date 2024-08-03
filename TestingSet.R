# Clean the global environment ----
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
  "rstudioapi",
  "tidyverse",
  "ggplot2",
  "dplyr",
  "data.table",
  "janitor",
  "openxlsx",
  "forecast",
  "lmtest",
  "ggpmisc",
  "ggpubr",
  "httr",
  "tmap"
))

## |- Setup Working Directory
path <- dirname(rstudioapi::getActiveDocumentContext()$path)
setwd(path)


#--------------------------------------------------------------------------------
#Notes
# To be able to run all code you must download 4 Files into your own file folder
# Indonesia Palm Oil, Brazil Sugar Cane, Soy, Beef


# Argentina --------------------------------------------------------------------

#Individual Products 
#(1165 Obs-9 Variables)
ArgentinaCotton <- read.csv("https://drive.google.com/uc?id=1xn4DXkDUAMc_U1aKx6kv_MBUAZrBqX8_", header = TRUE, fill = TRUE)

#(7942 Obs-9 Variables)
ArgentinaCorn <- read.csv("https://drive.google.com/uc?id=1x7Hv6t4_2xgBh7t-cV7srnMQOjWw-gbP", header = TRUE, fill = TRUE)

#(99 Obs-9 Variables)
ArgentinaWood <- read.csv("https://drive.google.com/uc?id=16SIPkhkTKw8exutwuygmVJoqcOucR41Y", header = TRUE, fill = TRUE)

#(406882 Obs-20 Variables)
ArgentinaSoy <- read.csv("https://drive.google.com/uc?id=13YIKtNUnaB7ik2yKeAHUS4Br4haJsiRX", header = TRUE, fill = TRUE)

#remove single data sets
rm(ArgentinaCotton, ArgentinaCorn, ArgentinaWood, ArgentinaSoy)

##Argentina (Drive) (22 Variables) (416088 Observations) (Correct)
Argentina <- list(
  Cotton = read.csv("https://drive.google.com/uc?id=1xn4DXkDUAMc_U1aKx6kv_MBUAZrBqX8_") %>% janitor::clean_names() %>%
    mutate(product = "cotton", country = "Argentina"),
  Corn = read.csv("https://drive.google.com/uc?id=1x7Hv6t4_2xgBh7t-cV7srnMQOjWw-gbP") %>% janitor::clean_names() %>%
    mutate(product = "corn", country = "Argentina"),
  Wood = read.csv("https://drive.google.com/uc?id=16SIPkhkTKw8exutwuygmVJoqcOucR41Y") %>% janitor::clean_names() %>%
    mutate(product = "woodpulp", country = "Argentina"),
  Soy = read.csv("https://drive.google.com/uc?id=13YIKtNUnaB7ik2yKeAHUS4Br4haJsiRX")  %>% janitor::clean_names() %>%
    mutate(product = "soy", country = "Argentina") # soy has more variables than others
) 

Argentina <- rbindlist(Argentina, fill = TRUE)

# Bolivia ---------------------------------------------------------------------
#Bolivia (Drive) (19 Variables) (14793 Observations)
Bolivia <- read.csv("https://drive.google.com/uc?id=1alOoHuKgzpSxhb0LNowT5a261HaPp_kI") %>% 
  janitor::clean_names() %>%
  mutate(product = "soy", country = "Bolivia")

# Brazil -----------------------------------------------------------------------
#Individual Products Brazil

#(1293 obs-18 Variables)
BrazilCocoa <- read.csv("https://drive.google.com/uc?id=1JCYpvbhHdpSljdae_qCOd5NgeDmH9ldH", header = TRUE, fill = TRUE)

#(144237 obs-19 variables)
BrazilCoffee <- read.csv("https://drive.google.com/uc?id=1DpFdAv5BSR_7x2Q9nN0j1oTHiAOTmxRF", header = TRUE, fill = TRUE)

#(72614 obs-18 variables)
BrazilCorn <- read.csv("https://drive.google.com/uc?id=1Mts3F0k3U6H0RRksw5XHt8Z06u4CCALi", header = TRUE, fill = TRUE)

#(8920 obs-18 variables)
BrazilCotton <- read.csv("https://drive.google.com/uc?id=14H83dAx3QN3r1Zm5Sdnl-nprjSASvEN2", header = TRUE, fill = TRUE)

#(111 obs-9 variables)
BrazilPalmKernal <- read.csv("https://drive.google.com/uc?id=1RrBZnbU03TqpjLMBwFHKBGv3kbX2N-Wh", header = TRUE, fill = TRUE)

#(147 obs- 9 variables)
BrazilPalmOil <- read.csv("https://drive.google.com/uc?id=1SfU4sltTvRoMsKgjbquR6rpImX1oTajo", header = TRUE, fill = TRUE)

#(45515 obs- 21 variables)
BrazilPork <- read.csv("https://drive.google.com/uc?id=1UVVXeRyWcEwrnQV-aBF4jpTnfybMo44T", header = TRUE, fill = TRUE)

#(904 obs-9 variables)
BrazilWoodPulp <- read.csv("https://drive.google.com/uc?export=download&id=1ONKwEtzAA-gOoX6yMIie6Dq4_H5ifdqW", header = TRUE, fill = TRUE)

#(50190 obs-21 variables)
BrazilChicken <- read.csv("https://drive.google.com/uc?id=1yPl5Uniq2BI4D2fo0oJCHWyd9LL9RhjT", header = TRUE, fill = TRUE)

--------------------------------------------------------------------------------
#Testing file upload vs google drive
#(7353 Obs- 9 Variables)
brazil_sugarcane <- read_csv("brazil-sugarcane-v0.0.1-2024-01-17.csv")

#(6439259 obs- 23 variables)
brazil_beef <- read_csv("brazil-beef-v2.2.0-2024-01-17.csv")

#(354815 obs- 23 variables)
brazil_soy <- read_csv("brazil-soy-v2.6.0-2024-01-17.csv")

#remove single data sets
rm(BrazilCocoa, BrazilCoffee, BrazilCorn, BrazilCotton, BrazilPalmKernal, BrazilPalmOil, BrazilPork, BrazilWoodPulp, BrazilChicken, brazil_sugarcane, brazil_beef, brazil_soy)
--------------------------------------------------------------------------------
#(7125359 obs - 46 variables)
Brazil <- list(
  Beef = read.csv("brazil-beef-v2.2.0-2024-01-17.csv", fill = TRUE) %>% janitor::clean_names() %>% 
    mutate(product = "beef", country = "Brazil"),
  Chicken = read.csv("https://drive.google.com/uc?export=download&id=1yPl5Uniq2BI4D2fo0oJCHWyd9LL9RhjT", fill = TRUE) %>% janitor::clean_names() %>% 
    mutate(product = "chicken", country = "Brazil"),
  Cocoa = read.csv("https://drive.google.com/uc?id=1JCYpvbhHdpSljdae_qCOd5NgeDmH9ldH", fill = TRUE) %>% janitor::clean_names() %>% 
    mutate(product = "cocoa", country = "Brazil"),
  Coffee = read.csv("https://drive.google.com/uc?id=1DpFdAv5BSR_7x2Q9nN0j1oTHiAOTmxRF", fill = TRUE) %>% janitor::clean_names() %>% 
    mutate(product = "coffee", country = "Brazil"),
  Corn = read.csv("https://drive.google.com/uc?id=1Mts3F0k3U6H0RRksw5XHt8Z06u4CCALi", fill = TRUE) %>% janitor::clean_names() %>% 
    mutate(product = "corn", country = "Brazil"),
  Cotton = read.csv("https://drive.google.com/uc?id=14H83dAx3QN3r1Zm5Sdnl-nprjSASvEN2", fill = TRUE) %>% janitor::clean_names() %>% 
    mutate(product = "cotton", country = "Brazil"),
  PalmKernal = read.csv("https://drive.google.com/uc?id=1RrBZnbU03TqpjLMBwFHKBGv3kbX2N-Wh", fill = TRUE) %>% janitor::clean_names() %>% 
    mutate(product = "palmkernal", country = "Brazil"),
  PalmOil = read.csv("https://drive.google.com/uc?id=1SfU4sltTvRoMsKgjbquR6rpImX1oTajo", fill = TRUE) %>% janitor::clean_names() %>% 
    mutate(product = "palmOil", country = "Brazil"),
  Pork = read.csv("https://drive.google.com/uc?id=1UVVXeRyWcEwrnQV-aBF4jpTnfybMo44T", fill = TRUE) %>% janitor::clean_names() %>% 
    mutate(product = "pork", country = "Brazil"),
  Soy = read.csv("brazil-soy-v2.6.0-2024-01-17.csv", fill = TRUE) %>% janitor::clean_names() %>% 
    mutate(product = "soy", country = "Brazil"),
  SugarCane = read.csv("brazil-sugarcane-v0.0.1-2024-01-17.csv", fill = TRUE) %>% janitor::clean_names() %>% 
    mutate(product = "sugarcane", country = "Brazil"),
  WoodPulp = read.csv("https://drive.google.com/uc?export=download&id=1ONKwEtzAA-gOoX6yMIie6Dq4_H5ifdqW", fill = TRUE) %>% janitor::clean_names() %>% 
    mutate(product = "Woodpulp", country = "Brazil")
)

Brazil <- rbindlist(Brazil, fill = TRUE, idcol = "product")


# Colombia ---------------------------------------------------------------------
#Individual Products Colombia

#(902 Obs-10 Variables)
ColombiaBeef <- read.csv("https://drive.google.com/uc?id=1sbJ0RITKW2v2mfXYHkuava45e7eL8YFA", header = TRUE, fill = TRUE)

#Problem File
ColombiaCocoa <- read.csv("https://drive.google.com/file/d/1poEx5Iae29sGMhriC8anXYfrIzJeZqkK/view?usp=drive_link", header = TRUE, fill = TRUE)

#(1242 Obs-11 Variables)
ColombiaCoffee <- read.csv("https://drive.google.com/uc?id=1poEx5Iae29sGMhriC8anXYfrIzJeZqkK", header = TRUE, fill = TRUE)

#(38948 Obs-15 Variables)
ColombiaPalmKernel <- read.csv("https://drive.google.com/uc?id=140T49-DuaJhxIohiQNT8SJHng-iaTiWY", header = TRUE, fill = TRUE)

#(375 Obs- 10 Variables)
ColombiaPalmOil <- read.csv("https://drive.google.com/uc?id=1a2jM721pQ1gPnR4NLFYFUM70Sfg02ZC7", header = TRUE, fill = TRUE)

#(698 Obs-10 Variables)
ColombiaWoodPulp <- read.csv("https://drive.google.com/uc?id=1MK91_YpApl4ygS4SWgDrCbA9eakwKjQI", header = TRUE, fill = TRUE)

#remove single data sets
rm(ColombiaBeef, ColombiaCocoa, ColombiaCoffee, ColombiaPalmKernel, ColombiaWoodPulp, ColombiaPalmOil)
------------------------------------------------------------------------------
##Colombia (Drive) (18 Variables) (43067 Observations) (Correct)
Colombia <- list(
  Beef = read.csv("https://drive.google.com/uc?id=1sbJ0RITKW2v2mfXYHkuava45e7eL8YFA") %>% janitor::clean_names() %>%
    mutate(product = "beef", country = "Colombia"),
  Cocoa = read.csv("https://drive.google.com/uc?id=1sbJ0RITKW2v2mfXYHkuava45e7eL8YFA") %>% janitor::clean_names() %>%
    mutate(product = "cocoa", country = "Colombia"),
  Coffee = read.csv("https://drive.google.com/uc?id=1poEx5Iae29sGMhriC8anXYfrIzJeZqkK") %>% janitor::clean_names() %>%
    mutate(product = "coffee", country = "Colombia"),
  Palm_Kernel = read.csv("https://drive.google.com/uc?id=140T49-DuaJhxIohiQNT8SJHng-iaTiWY") %>% janitor::clean_names() %>%
    mutate(product = "palmkernel", country = "Colombia"),
  Palm_Oil = read.csv("https://drive.google.com/uc?id=1a2jM721pQ1gPnR4NLFYFUM70Sfg02ZC7") %>% janitor::clean_names() %>%
    mutate(product = "palmOil", country = "Colombia"),
  Wood_Pulp = read.csv("https://drive.google.com/uc?id=1MK91_YpApl4ygS4SWgDrCbA9eakwKjQI") %>% janitor::clean_names() %>%
    mutate(product = "woodpulp", country = "Colombia")
) %>%
  rbindlist(fill = TRUE, idcol = "product") %>%
  select(all_of(names(.)))

# Cote d'Ivoire ----------------------------------------------------------------
#CoteDIvoire (Drive) (17 Variables) (27636 Obs)
CoteDIvoire <- list(
  Cocoa = read.csv("https://drive.google.com/uc?id=1_p6gCQZ02ICnsvNupRzwwa4j2Sv_xBOm") %>% janitor::clean_names() %>%
    mutate(product = "Cocoa", country = "CoteDIvoire")
) %>%
  rbindlist(fill = TRUE, idcol = "product") %>%
  select(all_of(names(.)))

# Ecuador ----------------------------------------------------------------------
#Individual Products Ecuador
#(9517 Obs-11 Variables)
EcuadorCocoa <- read.csv("https://drive.google.com/uc?id=1wymOQWWKLjhLWZ_0Fs-9TlQ1hP7mM2yS", header = TRUE, fill = TRUE)

#(96842 Obs-19 Variables)
EcuadorShrimp <- read.csv("https://drive.google.com/uc?id=1cO0swS-RBHXBxda4p7tcL5h7XFUmP5db", header = TRUE, fill = TRUE)

#remove single data sets
rm(EcuadorShrimp, EcuadorCocoa)
------------------------------------------------------------------------------
#Ecuador (Drive) (22 Var) (106359 Obs) (Correct)
Ecuador <- list(
  Cocoa = read.csv("https://drive.google.com/uc?id=1wymOQWWKLjhLWZ_0Fs-9TlQ1hP7mM2yS") %>% janitor::clean_names() %>%
    mutate(product = "cocoa", country = "Ecuador"),
  Shrimp = read.csv("https://drive.google.com/uc?id=1cO0swS-RBHXBxda4p7tcL5h7XFUmP5db") %>% janitor::clean_names() %>%
    mutate(product = "shrimp", country = "Ecuador")
) %>%
  rbindlist(fill = TRUE, idcol = "product") %>%
  select(all_of(names(.)))


# Ghana ------------------------------------------------------------------------
#Ghana (Drive) (13 Variables-2111 Observations)
Ghana <- read.csv("https://drive.google.com/uc?id=1d1qbfB6zyhmsZnvgMb0RL0jTYzHjB0hS") %>%
  janitor::clean_names() %>%
  mutate(product = "cocoa", country = "Ghana") %>%
  select(all_of(names(.)))


# Indonesia --------------------------------------------------------------------
#Individual Products Indonesia

#(1773667 obs-27 Variables)
indonesia_palm_oil <- read_csv("indonesia-palm-oil-v1.2.1-2024-05-02.csv")

#(30244 Obs-14 Variables)
IndonesiaShrimp <- read.csv("https://drive.google.com/uc?id=10iZjP6QoRSqHOi-kI4yhqljAmoKX0SoG", header = TRUE, fill = TRUE)

#(31456 obs- 34 Variables)
IndonesiaWoodPulp <- read.csv("https://drive.google.com/uc?export=download&id=1w0k1T9bhT3xsrTggMpuLV4w2WtJlkezr", header = TRUE, fill = TRUE)

#remove single data sets
rm(IndonesiaWoodPulp, IndonesiaShrimp, indonesia_palm_oil)
------------------------------------------------------------------------------
#Indonesia (Drive)  (1835367 obs- 60 variables)
Indonesia <- list(
  Palm_Oil = read.csv("indonesia-palm-oil-v1.2.1-2024-05-02.csv") %>% janitor::clean_names() %>%
    mutate(product = "palmOil", country = "Indonesia"),
  Shrimp = read.csv("https://drive.google.com/uc?id=10iZjP6QoRSqHOi-kI4yhqljAmoKX0SoG") %>% janitor::clean_names() %>%
    mutate(product = "shrimp", country = "Indonesia"),
  Wood_Pulp = read.csv("https://drive.google.com/uc?export=download&id=1w0k1T9bhT3xsrTggMpuLV4w2WtJlkezr", header = TRUE, fill = TRUE) %>% janitor::clean_names() %>%
    mutate(product = "Woodpulp", country = "Indonesia")
) %>%
  rbindlist(fill = TRUE, idcol = "product") %>%
  select(all_of(names(.)))

# Paraguay ---------------------------------------------------------------------
#Individual Products Paraguay
#(7924 Observations- 18 Variables)
ParaguayBeef <- read.csv("https://drive.google.com/uc?id=1-GuZ_gIS_lrZGOwM_1UsgwHgDkFSMXjA", header = TRUE, fill = TRUE)

#(9395 Obs- 15 Variables)
ParaguayCorn <- read.csv("https://drive.google.com/uc?id=1IwD7SmzIXOTyQX2ZNtVefPx84dzuCoKJ", header = TRUE, fill = TRUE)

#(4234 Obs- 16 Variables)
ParaguaySoy <- read.csv('https://drive.google.com/uc?export=download&id=1R3ArgyWgtODgQfaS6riwW9rGbb1kldc-', sep = ",", quote = "\"")

#remove single data sets
rm(ParaguaySoy, ParaguayCorn, ParaguayBeef)
------------------------------------------------------------------------------
##Paraguay (Drive) (Correct) (21553 Obs- 25 Variables)
Paraguay <- list(
  Beef = read.csv("https://drive.google.com/uc?id=1-GuZ_gIS_lrZGOwM_1UsgwHgDkFSMXjA") %>% janitor::clean_names() %>%
    mutate(product = "beef", country = "Paraguay"),
  Corn = read.csv("https://drive.google.com/uc?id=1IwD7SmzIXOTyQX2ZNtVefPx84dzuCoKJ") %>% janitor::clean_names() %>%
    mutate(product = "corn", country = "Paraguay"),
  Soy = read.csv('https://drive.google.com/uc?export=download&id=1R3ArgyWgtODgQfaS6riwW9rGbb1kldc-', sep = ",", quote = "\"") %>% janitor::clean_names() %>%
    mutate(product = "soy", country = "Paraguay")
) %>%
  rbindlist(fill = TRUE, idcol = "product") %>%
  select(all_of(names(.)))

# Peru -------------------------------------------------------------------------
#Individual Products Peru
#(6064 Obs- 9 Variables)
PeruCocoa <- read.csv("https://drive.google.com/uc?id=1ZjN4jZfLUVej-ubT7xaBz-Uezqn5Hu6M", header = TRUE, fill = TRUE)

#(8748 Obs-9 Variables)
PeruCoffee <- read.csv("https://drive.google.com/uc?id=19f7rm6dwCNbk1YnLjh7YYv1tLOuhFSIN", header = TRUE, fill = TRUE)

#742 Obs-9 Variables)
PeruShrimp <- read.csv("https://drive.google.com/uc?id=17832yGZvBrnIe1UH7nXO5QnfLHsZ8k0v", header = TRUE, fill = TRUE)

#remove single data sets
rm(PeruShrimp, PeruCoffee, PeruCocoa)

##Peru (Drive) (11 Variables- Obs 15554) (Correct)
Peru <- list(
  Cocoa = read.csv("https://drive.google.com/uc?id=1ZjN4jZfLUVej-ubT7xaBz-Uezqn5Hu6M") %>% janitor::clean_names() %>%
    mutate(product = "cocoa", country = "Peru"),
  Coffee = read.csv("https://drive.google.com/uc?id=19f7rm6dwCNbk1YnLjh7YYv1tLOuhFSIN") %>% janitor::clean_names() %>%
    mutate(product = "coffee", country = "Peru"),
  Shrimp = read.csv("https://drive.google.com/uc?id=17832yGZvBrnIe1UH7nXO5QnfLHsZ8k0v")  %>% janitor::clean_names() %>%
    mutate(product = "shrimp", country = "Peru")
) %>%
  rbindlist(fill = TRUE, idcol = "product") %>%
  select(all_of(names(.)))

#--------------------------------------------------------------------------------
#Combination of all 10 Countires import/export data
#(9607887 obs- 111 variables)
combined_countries <- rbindlist(list(Argentina, Bolivia, Colombia, CoteDIvoire, Ecuador, Ghana, Indonesia, Paraguay, Peru, Brazil), 
                                use.names = TRUE, fill = TRUE)  

#Remove extra dataframes after completely combined
rm(Argentina, Bolivia, Colombia, CoteDIvoire, Ecuador, Ghana, Indonesia, Paraguay, Peru, Brazil)

--------------------------------------------------------------------------------
#Cleaning
# Check for missing values
colSums(is.na(combined_countries))

# Handle missing values (example: removing rows with NA in critical columns)
combined_countries <- combined_countries %>% drop_na(fob) %>% drop_na(volume)

# Clean column names to ensure uniqueness
combined_countries <- clean_names(combined_countries)

# Check for duplicate column names
duplicated(names(combined_countries))

# Inspect the cleaned data
glimpse(combined_countries)

#Reducing the variables for analysis
common_vars <- c("product", "year", "country_of_production", "port_of_export", "exporter", "exporter_group", "economic_bloc", "country_of_destination", "volume", "fob", "country")

common_data <- combined_countries %>%
  select(all_of(common_vars))


#Shows that there are non-numeric values in fob and volume
common_data <- combined_countries %>%
  select(all_of(common_vars)) %>%
  mutate(
    fob = as.numeric(gsub("[^0-9.]", "", fob)),
    volume = as.numeric(gsub("[^0-9.]", "", volume)),
    year = as.numeric(year)
  )

#Could be the reason not all countries are grabbed
#Remove Na's in volume and fob

#common_data <- na.omit(volume, fob)


# Check for any issues in the conversion
summary(common_data$fob)
summary(common_data$volume)

# Inspect the cleaned data
glimpse(common_data)

#removing to run faster after grabbing select variables
rm(combined_countries)
--------------------------------------------------------------------------------
# Ensure that the 'year' column contains only valid years
common_data %>% pull(year) %>% unique()

# Check unique values in 'country_of_production'
common_data %>% pull(country_of_production) %>% unique()

# Check unique values in 'port_of_export'
common_data %>% pull(port_of_export) %>% unique()

# Check unique values in 'exporter'
common_data %>% pull(exporter) %>% unique()

# Check unique values in 'country_of_destination'
common_data %>% pull(country_of_destination) %>% unique()

# Check unique values in 'economic_bloc'
common_data %>% pull(economic_bloc) %>% unique()

#Noticed Bolivia is not present
common_data %>% pull(country) %>% unique()

#pulling all products included
common_data %>% pull(product) %>% unique()

--------------------------------------------------------------------------------
# Summary statistics
common_data %>%
  select(volume, fob) %>%
  summary()


#Visualizations
# Distribution of volume
ggplot(data = common_data, mapping = aes(x = year, y = volume)) +
  geom_point() +
  geom_hline(yintercept = 0,
             color = "red",
             linetype = "dashed")+
  theme_minimal()

# Volume over time
ggplot(common_data, aes(x = year, y = volume, color = country_of_production)) +
  geom_line() +
  labs(title = "Volume Over Time", x = "Year", y = "Volume")


# Distribution of fob
ggplot(data = common_data, mapping = aes(x = year, y = fob)) +
  geom_point() +
  geom_hline(yintercept = 0,
             color = "red",
             linetype = "dashed")+
  theme_minimal()

# FOB over time
ggplot(common_data, aes(x = year, y = fob, color = country_of_production)) +
  geom_line() +
  labs(title = "FOB Over Time", x = "Year", y = "FOB")
--------------------------------------------------------------------------------
#Averages of Volumem and Fob
avg_measures <- common_data %>%
  group_by(year, country_of_destination) %>%
  summarise(
    avg_vol = round(mean(volume, na.rm = TRUE), 2),
    avg_fob = round(mean(fob, na.rm = TRUE), 2)
  )

avg_measures


# This will have avg by year, by destination, by products
avg_by_dest_product_year <- common_data %>%
  group_by(year, country_of_destination, product) %>%
  summarise(
    avg_vol = round(mean(volume, na.rm = TRUE), 2),
    avg_fob = round(mean(fob, na.rm = TRUE), 2)
  )

avg_by_dest_product_year

# This will have avg by year, by destination, by products, by port as well
avg_by_port_dest_product_year <- common_data %>%
  group_by(year, country_of_destination, product, port_of_export) %>%
  summarise(
    avg_vol = round(mean(volume, na.rm = TRUE), 2),
    avg_fob = round(mean(fob, na.rm = TRUE), 2)
  )

avg_by_port_dest_product_year

#-------------------------------------------------------------------------------

# We must be sure that data is adequately represented
balance_avg_by_dest_product_year <- expand.grid(
  year = common_data %>% pull(year) %>% unique(),
  country_of_destination = common_data %>% pull(country_of_destination) %>% unique(),
  product = common_data %>% pull(product) %>% unique()
) %>%
  merge(
    avg_by_dest_product_year,
    by = c("year", "country_of_destination", "product"),
    all.x = T
  )

#Shows instances where products never go to this country?
head(balance_avg_by_dest_product_year)
#Just double checking
colSums(is.na(common_data))

#Include the port of export
balance_avg_by_port_dest_product_year <- expand.grid(
  year = common_data %>% pull(year) %>% unique(),
  country_of_destination = common_data %>% pull(country_of_destination) %>% unique(),
  product = common_data %>% pull(product) %>% unique(),
  port_of_export = common_data %>% pull(port_of_export) %>% unique()
) %>%
  merge(
    avg_by_port_dest_product_year,
    by = c("year", "country_of_destination", "product", "port_of_export"),
    all.x = T
  )

head(balance_avg_by_port_dest_product_year)


#-------------------------------------------------------------------------------

# Create a new data frame with average volume and FOB by year
avg_data <- common_data %>%
  group_by(year) %>%
  summarise(avg_volume = mean(volume, na.rm = TRUE),
            avg_fob = mean(fob, na.rm = TRUE))

# Plot the overall trend for average volume and FOB by year
ggplot(avg_data, aes(x = year)) +
  geom_line(aes(y = avg_fob, color = "Average FOB")) +
  labs(title = "Overall Trend of Average Volume and FOB by Year",
       x = "Year",
       y = "Value",
       color = "Metric") +
  theme_minimal()

ggplot(avg_data, aes(x = year)) +
  geom_line(aes(y = avg_volume, color = "Average Volume")) +
  labs(title = "Overall Trend of Average Volume and FOB by Year",
       x = "Year",
       y = "Value",
       color = "Metric") +
  theme_minimal()

# Separate plots for each country by year
country_data <- common_data %>%
  group_by(year, country) %>%
  summarise(avg_volume = mean(volume, na.rm = TRUE),
            avg_fob = mean(fob, na.rm = TRUE))

# Plot trends by country and year
# Notice not all countries are present
ggplot(country_data, aes(x = year)) +
  geom_line(aes(y = avg_volume, color = "Average Volume")) +
  geom_line(aes(y = avg_fob, color = "Average FOB")) +
  facet_wrap(~ country) +
  labs(title = "Trend of Average Volume and FOB by Country and Year",
       x = "Year",
       y = "Value",
       color = "Metric") +
  theme_minimal()

glimpse(common_data)
--------------------------------------------------------------------------------
# Summarize or aggregate data by country_of_production
summary_data <- common_data %>%
  group_by(country_of_production) %>%
  summarise(total_volume = sum(volume), total_fob = sum(fob))

# Calculate the average volume and FOB for each country
avg_by_country <- common_data %>%
  group_by(country) %>%
  summarise(
    avg_volume = round(mean(volume, na.rm = TRUE), 2),
    avg_fob = round(mean(fob, na.rm = TRUE), 2)
  )

# Plot Average Volume by Country
ggplot(avg_by_country, aes(x = reorder(country, avg_volume), y = avg_volume)) +
  geom_bar(stat = "identity") +
  coord_flip() +
  labs(title = "Average Volume by Country", x = "Country", y = "Average Volume") +
  theme_minimal()

# Plot Average FOB by Country
ggplot(avg_by_country, aes(x = reorder(country, avg_fob), y = avg_fob)) +
  geom_bar(stat = "identity") +
  coord_flip() +
  labs(title = "Average FOB by Country", x = "Country", y = "Average FOB") +
  theme_minimal()

--------------------------------------------------------------------------------

# Analysis of volume and FOB by product
avg_by_product <- common_data %>%
  group_by(product) %>%
  summarise(avg_volume = round(mean(volume, na.rm = TRUE), 2), 
            avg_fob = round(mean(fob, na.rm = TRUE), 2))

ggplot(avg_by_product, aes(x = reorder(product, avg_volume), y = avg_volume)) +
  geom_bar(stat = "identity") +
  coord_flip() +
  labs(title = "Average Volume by Product", x = "Product", y = "Average Volume") +
  theme_minimal()

ggplot(avg_by_product, aes(x = reorder(product, avg_fob), y = avg_fob)) +
  geom_bar(stat = "identity") +
  coord_flip() +
  labs(title = "Average FOB by Product", x = "Product", y = "Average FOB") +
  theme_minimal()

--------------------------------------------------------------------------------
# Analysis of volume and FOB by port of export
avg_by_port <- common_data %>%
  group_by(port_of_export) %>%
  summarise(
    avg_volume = round(mean(volume, na.rm = TRUE), 2),
    avg_fob = round(mean(fob, na.rm = TRUE), 2)
  )

ggplot(avg_by_port, aes(x = reorder(port_of_export, avg_volume), y = avg_volume)) +
  geom_bar(stat = "identity") +
  coord_flip() +
  labs(title = "Average Volume by Port of Export", x = "Port of Export", y = "Average Volume") +
  theme_minimal()

ggplot(avg_by_port, aes(x = reorder(port_of_export, avg_fob), y = avg_fob)) +
  geom_bar(stat = "identity") +
  coord_flip() +
  labs(title = "Average FOB by Port of Export", x = "Port of Export", y = "Average FOB") +
  theme_minimal()

--------------------------------------------------------------------------------

# Yearly trends for each country of production
yearly_trends <- common_data %>%
  filter(year %in% sort(unique(common_data$year), decreasing = TRUE)[1:10]) %>%
  group_by(year, country_of_production) %>%
  summarise(
    total_volume = sum(volume, na.rm = TRUE),
    total_fob = sum(fob, na.rm = TRUE)
  )

#Yearly Trends of Volume and FOB by Country
ggplot(yearly_trends, aes(x = year)) +
  geom_line(aes(y = total_volume, color = "Total Volume")) +
  geom_line(aes(y = total_fob, color = "Total FOB")) +
  facet_wrap(~ country_of_production) +
  labs(title = "Yearly Trends of Volume and FOB by Country",
       x = "Year", y = "Total", color = "Metric") +
  theme_minimal()

# Top exporters by volume and FOB
top_exporters <- common_data %>%
  filter(year %in% sort(unique(common_data$year), decreasing = TRUE)[1:10]) %>%
  group_by(exporter) %>%
  summarise(
    total_volume = sum(volume, na.rm = TRUE),
    total_fob = sum(fob, na.rm = TRUE)
  ) %>%
  arrange(desc(total_volume))