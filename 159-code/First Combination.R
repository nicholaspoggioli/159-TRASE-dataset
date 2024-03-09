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

ipak(c("plyr",
       "dplyr",
       "readr",
       "purrr"))


# |- Setup Working Directory ----
path <- dirname(rstudioapi::getActiveDocumentContext()$path)

setwd(path)

#4. Find total Observations from original sets ----
#Testing to ensure proper data merging occured
argentina_corn <-
  read_csv("Argentina/argentina-corn-v0.2.3-2024-01-17.csv.csv")
argentina_cotton <-
  read_csv("Argentina/argentina-cotton-v0.2.3-2024-01-17.csv.csv")
argentina_soy <-
  read_csv("Argentina/argentina-soy-v1.1.1-2024-01-17.csv.csv")
argentina_wood_pulp <-
  read_csv("Argentina/argentina-wood-pulp-v0.2.3-2024-01-17.csv.csv")

#Counting Proper Total Observations
# Create a list of data frames
list_of_dfs <-
  list(argentina_corn,
       argentina_cotton,
       argentina_soy,
       argentina_wood_pulp)

# Count observations across data frames
total_observations <- sum(sapply(list_of_dfs, nrow))

# Print the total number of observations
print(total_observations)

#416088 Rows Should be Present


#5.Merge existing csv files in folder
data_all <-
  list.files(path = "C:/Users/gruberrd/Documents/GA RStudio Cleaning/Argentina",
             pattern = "*.csv",
             full.names = TRUE) %>%
  lapply(read.csv) %>%
  bind_rows


#remove x column that was generated
data_all <- data_all %>% select(-X)


#Not Working Purr not being recognized as installed
install.packages("purrr")
library(purrr)

data_join <-
  list.files(path = "C:/Users/gruberrd/Documents/GA RStudio Cleaning/Argentina",
             pattern = "*.csv",
             full.names = TRUE) %>%
  lapply(read.csv) %>%
  purrr::reduce(fulljoin, by = "id")

.libPaths()

#6. Check Data Types/Observations Total
glimpse(data_all)


#For Some Reason the dataframe has double the observations
# Assuming 'file_path' is the path to an individual CSV file
duplicate_rows <- data_all[duplicated(data_all),]


#7. Use write.csv to save the data frame as a CSV file
write.csv(data_all, file = "Combined_Argentina_Data.csv")


#Testing
