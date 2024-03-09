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
  "tidyverse",
  "ggplot2",
  "dplyr",
  "data.table",
  "forecast",
  "tseries",
  "ggpmisc",
  "ggpubr",
  "lmtest"
))

# |- Setup Working Directory ----
path <- dirname(rstudioapi::getActiveDocumentContext()$path)
setwd(path)

set.seed(123)

# 50 observation
n <- 50
intercept <- 1
slope <- 0.5

# Create Data Frame
df <- data.frame(x = 1:50,
                 e = rnorm(n = n, mean = 0, sd = 2))
df %>% head()

##---------------------------
df <- data.frame(x = 1:50,
                 epsilon = rnorm(n)) %>% 
  mutate(y = intercept + slope * x + epsilon)

df %>% head()

#----------------------------
df %>% select(x,y) %>% head()

#----------------------------
#the first 45 observations are training data
dt <- df %>% filter(x %in% c(1:45))

dtest <- df %>% filter(x %in% c(46:nrow(.)))

##--------fig.height =3, fig.width=8--------
ggplot(data = dt, mapping = aes(x = x, y = y)) +
  geom_line() +geom_point() +theme_minimal()

##---------------
tslm <- lm(y~x, data = dt)

##----------eval = F------
# tslm %>% summary()

##------echo = F--------
tslm %>% summary()

##--------------------
attributes(tslm)

##----------eval = F-------
tslm$model
tslm$coefficients
tslm$residuals
tslm$fitted.values

##--------------------------
dt <- dt %>% 
  mutate(yhat = tslm$fitted.values,
         # check_residuals = y -yhat,
         e = tslm$residuals)
head(dt)

