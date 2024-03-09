df <- read_csv("Argentina/argentina-corn-v0.2.3-2024-01-17.csv.csv") %>% janitor::clean_names() %>% ungroup()

df$country_of_destination %>% unique()

chk <- df %>% 
  select(year, country_of_destination, volume, fob) %>%
  group_by(year, country_of_destination) %>% 
  summarise(total_vol = volume %>% sum(na.rm = T),
            total_fob = fob %>% sum(na.rm = T))
colnames(df)
