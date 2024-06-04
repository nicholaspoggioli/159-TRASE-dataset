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
  "httr"
))

# |- Setup Working Directory ----
path <- dirname(rstudioapi::getActiveDocumentContext()$path)
setwd(path)

##------------------------------------------------------------------------------
#Individual Products 

#(1165 Obs-9 Variables)
ArgentinaCotton <- read.csv("https://drive.google.com/uc?id=1xn4DXkDUAMc_U1aKx6kv_MBUAZrBqX8_", header = TRUE, fill = TRUE)

#(7942 Obs-9 Variables)
ArgentinaCorn <- read.csv("https://drive.google.com/uc?id=1x7Hv6t4_2xgBh7t-cV7srnMQOjWw-gbP", header = TRUE, fill = TRUE)

#(99 Obs-9 Variables)
ArgentinaWood <- read.csv("https://drive.google.com/uc?id=16SIPkhkTKw8exutwuygmVJoqcOucR41Y", header = TRUE, fill = TRUE)

#(406882 Obs-20 Variables)
ArgentinaSoy <- read.csv("https://drive.google.com/uc?id=13YIKtNUnaB7ik2yKeAHUS4Br4haJsiRX", header = TRUE, fill = TRUE)

##------------------------------------------------------------------------------
##Argentina (Drive) (22 Variables) (416088 Observations) (Correct)
Argentina <- list(
  Cotton = read.csv("https://drive.google.com/uc?id=1xn4DXkDUAMc_U1aKx6kv_MBUAZrBqX8_") %>% janitor::clean_names() %>%
    mutate(product = "cotton", country = "Argentina"),
  Corn = read.csv("https://drive.google.com/uc?id=1x7Hv6t4_2xgBh7t-cV7srnMQOjWw-gbP") %>% janitor::clean_names() %>%
    mutate(product = "corn", country = "Argentina"),
  Wood = read.csv("https://drive.google.com/uc?id=16SIPkhkTKw8exutwuygmVJoqcOucR41Y") %>% janitor::clean_names() %>%
    mutate(product = "wood-pulp", country = "Argentina"),
  Soy = read.csv("https://drive.google.com/uc?id=13YIKtNUnaB7ik2yKeAHUS4Br4haJsiRX")  %>% janitor::clean_names() %>%
    mutate(product = "soy", country = "Argentina") # soy has more variables than others
) 
Argentina <- rbindlist(Argentina, fill = TRUE)

##------------------------------------------------------------------------------
#Bolivia (Drive) (19 Variables) (14793 Observations)
Bolivia <- read.csv("https://drive.google.com/uc?id=1alOoHuKgzpSxhb0LNowT5a261HaPp_kI") %>% 
  janitor::clean_names() %>%
  mutate(product = "Soy", country = "Bolivia")

##------------------------------------------------------------------------------
#Individual Products Brazil

#(50190 Obs-21 Variables)
BrazilCocoa <- read.csv("https://drive.google.com/uc?id=1yPl5Uniq2BI4D2fo0oJCHWyd9LL9RhjT", header = TRUE, fill = TRUE)

#(Product desc could be dropped) (1294 Obs- 18 Variables)
BrazilCoffee <- read.csv("https://drive.google.com/uc?id=1JCYpvbhHdpSljdae_qCOd5NgeDmH9ldH", header = TRUE, fill = TRUE)

#(144237 Obs- 19 Variables)
BrazilCorn <- read.csv("https://drive.google.com/uc?id=1DpFdAv5BSR_7x2Q9nN0j1oTHiAOTmxRF", header = TRUE, fill = TRUE)

#(72614 Obs- 18 Variables)
BrazilCotton <- read.csv("https://drive.google.com/uc?id=1Mts3F0k3U6H0RRksw5XHt8Z06u4CCALi", header = TRUE, fill = TRUE)

#(8920 Obs- 18 Variables)
BrazilPalmKernal <- read.csv("https://drive.google.com/uc?id=14H83dAx3QN3r1Zm5Sdnl-nprjSASvEN2", header = TRUE, fill = TRUE)

#(111 Obs- 9 Variables)
BrazilPalmOil <- read.csv("https://drive.google.com/uc?id=1RrBZnbU03TqpjLMBwFHKBGv3kbX2N-Wh", header = TRUE, fill = TRUE)

#(147 Obs- 9 Variables)
BrazilPork <- read.csv("https://drive.google.com/uc?id=1SfU4sltTvRoMsKgjbquR6rpImX1oTajo", header = TRUE, fill = TRUE)

#(45515 Obs- 21 Variables)
BrazilSoy <- read.csv("https://drive.google.com/uc?id=1UVVXeRyWcEwrnQV-aBF4jpTnfybMo44T", header = TRUE, fill = TRUE)

#(7353 Obs- 9 Variables)
BrazilWoodPulp <- read.csv("https://drive.google.com/uc?id=1uoCoOrUc0j_p3VRCIVgpcm_1UyTVwBur", header = TRUE, fill = TRUE)

#(50190 Obs- 21 variables)
BrazilChicken <- read.csv("https://drive.google.com/uc?export=download&id=1yPl5Uniq2BI4D2fo0oJCHWyd9LL9RhjT", header = TRUE, fill = TRUE)

#These do not load properly (testing)-------------------------------------------
BrazilBeef <- read.csv("https://drive.google.com/uc?id=1PvDD4J7DQF2kpyElC3Xo7v05O-tFpdYD", header = TRUE, fill = TRUE)

BrazilSugarCane <- read.csv("https://drive.google.com/uc?id=1GhkZBK0eRU8YFFU7uU7xsTnOdaBvGglL", header = TRUE, fill = TRUE)

BrazilBeef <- read.csv("https://drive.google.com/uc?id=1PvDD4J7DQF2kpyElC3Xo7v05O-tFpdYD", 
                       header = TRUE, 
                       stringsAsFactors = FALSE)

BrazilBeef <- read.table("https://drive.google.com/uc?id=1PvDD4J7DQF2kpyElC3Xo7v05O-tFpdYD", header = TRUE, sep = ",", fill = TRUE)

# Open the file in append mode and write a newline character
cat("\n", file = "https://drive.google.com/uc?id=1GhkZBK0eRU8YFFU7uU7xsTnOdaBvGglL", append = TRUE)

#Testing file upload vs google drive
#(7353 Obs- 9 Variables)
brazil_sugarcane <- read_csv("brazil-sugarcane-v0.0.1-2024-01-17.csv")

#(6439259 obs- 23 variables)
brazil_beef <- read_csv("brazil-beef-v2.2.0-2024-01-17.csv")

--------------------------------------------------------------------------------
#Brazil Corrections Sugar Cane, Beef, and Chicken Fail to load properly
Brazil <- list(
  Beef = read.csv("https://drive.google.com/uc?id=1PvDD4J7DQF2kpyElC3Xo7v05O-tFpdYD", fill = TRUE) %>% janitor::clean_names() %>% 
    mutate(product = "Beef", country = "Brazil"),
  Chicken = read.csv("https://drive.google.com/uc?export=download&id=1yPl5Uniq2BI4D2fo0oJCHWyd9LL9RhjT", fill = TRUE) %>% janitor::clean_names() %>% 
    mutate(product = "Chicken", country = "Brazil"),
  Cocoa = read.csv("https://drive.google.com/uc?id=1yPl5Uniq2BI4D2fo0oJCHWyd9LL9RhjT", fill = TRUE) %>% janitor::clean_names() %>% 
    mutate(product = "Cocoa", country = "Brazil"),
  Coffee = read.csv("https://drive.google.com/uc?id=1JCYpvbhHdpSljdae_qCOd5NgeDmH9ldH", fill = TRUE) %>% janitor::clean_names() %>% 
    mutate(product = "Coffee", country = "Brazil"),
  Corn = read.csv("https://drive.google.com/uc?id=1DpFdAv5BSR_7x2Q9nN0j1oTHiAOTmxRF", fill = TRUE) %>% janitor::clean_names() %>% 
    mutate(product = "Corn", country = "Brazil"),
  Cotton = read.csv("https://drive.google.com/uc?id=1Mts3F0k3U6H0RRksw5XHt8Z06u4CCALi", fill = TRUE) %>% janitor::clean_names() %>% 
    mutate(product = "Cotton", country = "Brazil"),
  PalmKernal = read.csv("https://drive.google.com/uc?id=14H83dAx3QN3r1Zm5Sdnl-nprjSASvEN2", fill = TRUE) %>% janitor::clean_names() %>% 
    mutate(product = "PalmKernal", country = "Brazil"),
  PalmOil = read.csv("https://drive.google.com/uc?id=1RrBZnbU03TqpjLMBwFHKBGv3kbX2N-Wh", fill = TRUE) %>% janitor::clean_names() %>% 
    mutate(product = "PalmOil", country = "Brazil"),
  Pork = read.csv("https://drive.google.com/uc?id=1SfU4sltTvRoMsKgjbquR6rpImX1oTajo", fill = TRUE) %>% janitor::clean_names() %>% 
    mutate(product = "Pork", country = "Brazil"),
  Soy = read.csv("https://drive.google.com/uc?id=1UVVXeRyWcEwrnQV-aBF4jpTnfybMo44T", fill = TRUE) %>% janitor::clean_names() %>% 
    mutate(product = "Soy", country = "Brazil"),
  SugarCane = read.csv("https://drive.google.com/uc?id=1GhkZBK0eRU8YFFU7uU7xsTnOdaBvGglL", fill = TRUE) %>% janitor::clean_names() %>% 
    mutate(product = "SugarCane", country = "Brazil"),
  WoodPulp = read.csv("https://drive.google.com/uc?id=1uoCoOrUc0j_p3VRCIVgpcm_1UyTVwBur", fill = TRUE) %>% janitor::clean_names() %>% 
    mutate(product = "WoodPulp", country = "Brazil")
)

Brazil <- rbindlist(Brazil, fill = TRUE, idcol = "product")

##------------------------------------------------------------------------------
#Individual Products Columbia

#(902 Obs-10 Variables)
ColumbiaBeef <- read.csv("https://drive.google.com/uc?id=1sbJ0RITKW2v2mfXYHkuava45e7eL8YFA", header = TRUE, fill = TRUE)

#Problem File
ColumbiaCocoa <- read.csv("https://drive.google.com/file/d/1poEx5Iae29sGMhriC8anXYfrIzJeZqkK/view?usp=drive_link", header = TRUE, fill = TRUE)

#(1242 Obs-11 Variables)
ColumbiaCoffee <- read.csv("https://drive.google.com/uc?id=1poEx5Iae29sGMhriC8anXYfrIzJeZqkK", header = TRUE, fill = TRUE)

#(38948 Obs-15 Variables)
ColumbiaPalmKernel <- read.csv("https://drive.google.com/uc?id=140T49-DuaJhxIohiQNT8SJHng-iaTiWY", header = TRUE, fill = TRUE)

#(375 Obs- 10 Variables)
ColumbiaPalmOil <- read.csv("https://drive.google.com/uc?id=1a2jM721pQ1gPnR4NLFYFUM70Sfg02ZC7", header = TRUE, fill = TRUE)

#(698 Obs-10 Variables)
ColumbiaWoodPulp <- read.csv("https://drive.google.com/uc?id=1MK91_YpApl4ygS4SWgDrCbA9eakwKjQI", header = TRUE, fill = TRUE)


##------------------------------------------------------------------------------
##Colombia (Drive) (18 Variables) (43067 Observations) (Correct)
Colombia <- list(
  Beef = read.csv("https://drive.google.com/uc?id=1sbJ0RITKW2v2mfXYHkuava45e7eL8YFA") %>% janitor::clean_names() %>%
    mutate(product = "Beef", country = "Colombia"),
  Cocoa = read.csv("https://drive.google.com/uc?id=1sbJ0RITKW2v2mfXYHkuava45e7eL8YFA") %>% janitor::clean_names() %>%
    mutate(product = "Cocoa", country = "Colombia"),
  Coffee = read.csv("https://drive.google.com/uc?id=1poEx5Iae29sGMhriC8anXYfrIzJeZqkK") %>% janitor::clean_names() %>%
    mutate(product = "Coffee", country = "Colombia"),
  Palm_Kernel = read.csv("https://drive.google.com/uc?id=140T49-DuaJhxIohiQNT8SJHng-iaTiWY") %>% janitor::clean_names() %>%
    mutate(product = "Palm-Kernel", country = "Colombia"),
  Palm_Oil = read.csv("https://drive.google.com/uc?id=1a2jM721pQ1gPnR4NLFYFUM70Sfg02ZC7") %>% janitor::clean_names() %>%
    mutate(product = "Palm-Oil", country = "Colombia"),
  Wood_Pulp = read.csv("https://drive.google.com/uc?id=1MK91_YpApl4ygS4SWgDrCbA9eakwKjQI") %>% janitor::clean_names() %>%
    mutate(product = "Wood-Pulp", country = "Colombia")
) %>%
  rbindlist(fill = TRUE, idcol = "product") %>%
  select(all_of(names(.)))

##------------------------------------------------------------------------------
#CoteDIvoire (Drive) (17 Variables) (27636 Obs)
CoteDIvoire <- list(
  Cocoa = read.csv("https://drive.google.com/uc?id=1_p6gCQZ02ICnsvNupRzwwa4j2Sv_xBOm") %>% janitor::clean_names() %>%
    mutate(product = "Cocoa", country = "CoteDIvoire")
) %>%
  rbindlist(fill = TRUE, idcol = "product") %>%
  select(all_of(names(.)))

##------------------------------------------------------------------------------
#Individual Products Ecuador
#(9517 Obs-11 Variables)
EcuadorCocoa <- read.csv("https://drive.google.com/uc?id=1wymOQWWKLjhLWZ_0Fs-9TlQ1hP7mM2yS", header = TRUE, fill = TRUE)

#(96842 Obs-19 Variables)
EcuadorShrimp <- read.csv("https://drive.google.com/uc?id=1cO0swS-RBHXBxda4p7tcL5h7XFUmP5db", header = TRUE, fill = TRUE)

##------------------------------------------------------------------------------
#Ecuador (Drive) (22 Var) (106359 Obs) (Correct)
Ecuador <- list(
  Cocoa = read.csv("https://drive.google.com/uc?id=1wymOQWWKLjhLWZ_0Fs-9TlQ1hP7mM2yS") %>% janitor::clean_names() %>%
    mutate(product = "Cocoa", country = "Ecuador"),
  Shrimp = read.csv("https://drive.google.com/uc?id=1cO0swS-RBHXBxda4p7tcL5h7XFUmP5db") %>% janitor::clean_names() %>%
    mutate(product = "Shrimp", country = "Ecuador")
) %>%
  rbindlist(fill = TRUE, idcol = "product") %>%
  select(all_of(names(.)))


##------------------------------------------------------------------------------
#Ghana (Drive) (13 Variables-2111 Observations)
Ghana <- read.csv("https://drive.google.com/uc?id=1d1qbfB6zyhmsZnvgMb0RL0jTYzHjB0hS") %>%
  janitor::clean_names() %>%
  mutate(product = "Cocoa", country = "Ghana") %>%
  select(all_of(names(.)))


##------------------------------------------------------------------------------
#Individual Products Indonesia

#Problems Loading
IndonesiaPalmOil <- read.csv("https://drive.google.com/uc?export=download&id=1lW4ifV7A8BlkhDMe0_qKEvs7_oqHiPHv", header = TRUE, fill = TRUE)

IndonesiaPalmOil <- read.csv('https://drive.google.com/uc?export=download&id=1lW4ifV7A8BlkhDMe0_qKEvs7_oqHiPHv', sep = ",", quote = "\"", header = TRUE, fill = TRUE)

#(1773667 obs-27 Variables)
indonesia_palm_oil <- read_csv("indonesia-palm-oil-v1.2.1-2024-05-02.csv")

-----------------------------------------


#(30244 Obs-14 Variables)
IndonesiaShrimp <- read.csv("https://drive.google.com/uc?id=10iZjP6QoRSqHOi-kI4yhqljAmoKX0SoG", header = TRUE, fill = TRUE)

#(31456 obs- 34 Variables)
IndonesiaWoodPulp <- read.csv("https://drive.google.com/uc?export=download&id=1w0k1T9bhT3xsrTggMpuLV4w2WtJlkezr", header = TRUE, fill = TRUE)


##------------------------------------------------------------------------------
#Indonesia (Drive) 
Indonesia <- list(
  Palm_Oil = read.csv("https://drive.google.com/uc?id=1dwNPuzTnl4eXtmVan-vXNddcfkBXFg6m") %>% janitor::clean_names() %>%
    mutate(product = "Palm_Oil", country = "Indonesia"),
  Shrimp = read.csv("https://drive.google.com/uc?id=10iZjP6QoRSqHOi-kI4yhqljAmoKX0SoG") %>% janitor::clean_names() %>%
    mutate(product = "Shrimp", country = "Indonesia"),
  Wood_Pulp = read.csv("https://drive.google.com/uc?export=download&id=1w0k1T9bhT3xsrTggMpuLV4w2WtJlkezr", header = TRUE, fill = TRUE) %>% janitor::clean_names() %>%
    mutate(product = "Wood_Pulp", country = "Indonesia")
) %>%
  rbindlist(fill = TRUE, idcol = "product") %>%
  select(all_of(names(.)))

##------------------------------------------------------------------------------
#Individual Products Paraguay
#(7924 Observations- 18 Variables)
ParaguayBeef <- read.csv("https://drive.google.com/uc?id=1-GuZ_gIS_lrZGOwM_1UsgwHgDkFSMXjA", header = TRUE, fill = TRUE)

#(9395 Obs- 15 Variables)
ParaguayCorn <- read.csv("https://drive.google.com/uc?id=1IwD7SmzIXOTyQX2ZNtVefPx84dzuCoKJ", header = TRUE, fill = TRUE)

#(4234 Obs- 16 Variables)
ParaguaySoy <- read.csv('https://drive.google.com/uc?export=download&id=1lyuLHwHRyYvMRc7oM4uI_0sPQ0KuPZ1L', sep = ",", quote = "\"")

##------------------------------------------------------------------------------
##Paraguay (Drive) (Correct) (21553 Obs- 25 Variables)
Paraguay <- list(
  Beef = read.csv("https://drive.google.com/uc?id=1-GuZ_gIS_lrZGOwM_1UsgwHgDkFSMXjA") %>% janitor::clean_names() %>%
    mutate(product = "Beef", country = "Paraguay"),
  Corn = read.csv("https://drive.google.com/uc?id=1IwD7SmzIXOTyQX2ZNtVefPx84dzuCoKJ") %>% janitor::clean_names() %>%
    mutate(product = "Corn", country = "Paraguay"),
  Soy = read.csv('https://drive.google.com/uc?export=download&id=1lyuLHwHRyYvMRc7oM4uI_0sPQ0KuPZ1L', sep = ",", quote = "\"") %>% janitor::clean_names() %>%
    mutate(product = "Soy", country = "Paraguay")
) %>%
  rbindlist(fill = TRUE, idcol = "product") %>%
  select(all_of(names(.)))

##------------------------------------------------------------------------------
#Individual Products Peru
#(6064 Obs- 9 Variables)
PeruCocoa <- read.csv("https://drive.google.com/uc?id=1ZjN4jZfLUVej-ubT7xaBz-Uezqn5Hu6M", header = TRUE, fill = TRUE)

#(8748 Obs-9 Variables)
PeruCoffee <- read.csv("https://drive.google.com/uc?id=19f7rm6dwCNbk1YnLjh7YYv1tLOuhFSIN", header = TRUE, fill = TRUE)

#742 Obs-9 Variables)
PeruShrimp <- read.csv("https://drive.google.com/uc?id=17832yGZvBrnIe1UH7nXO5QnfLHsZ8k0v", header = TRUE, fill = TRUE)


##Peru (Drive) (11 Variables- Obs 15554) (Correct)
Peru <- list(
  Cocoa = read.csv("https://drive.google.com/uc?id=1ZjN4jZfLUVej-ubT7xaBz-Uezqn5Hu6M") %>% janitor::clean_names() %>%
    mutate(product = "Cocoa", country = "Peru"),
  Coffee = read.csv("https://drive.google.com/uc?id=19f7rm6dwCNbk1YnLjh7YYv1tLOuhFSIN") %>% janitor::clean_names() %>%
    mutate(product = "Coffee", country = "Peru"),
  Shrimp = read.csv("https://drive.google.com/uc?id=17832yGZvBrnIe1UH7nXO5QnfLHsZ8k0v")  %>% janitor::clean_names() %>%
    mutate(product = "Shrimp", country = "Peru")
) %>%
  rbindlist(fill = TRUE, idcol = "product") %>%
  select(all_of(names(.)))


