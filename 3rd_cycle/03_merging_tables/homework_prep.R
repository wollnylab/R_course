# Table joining - Homework preparation
cov <- read.csv(file = "/Users/damian_wollny/PI/Lectures/R_course/1st_cycle/new_covid_data.csv") %>% as_tibble()

df1 <- cov %>% 
  filter(location == "Germany") %>% 
  select(date, new_deaths_per_million) %>% 
  drop_na()

df2 <- cov %>% 
  filter(location == "Germany") %>% 
  select(date, new_cases_per_million)

write.csv(df1, file = "~/PI/Lectures/R_course/3rd_cycle/03_merging_tables/ger_deaths.csv", row.names = F)
write.csv(df2, file = "~/PI/Lectures/R_course/3rd_cycle/03_merging_tables/ger_cases.csv", row.names = F)

left_join(df2, df1, by = "date") %>% 
  #Case-Fatality Ratio (%) = Number recorded deaths / Number cases
  mutate(cfr = new_cases_per_million / new_deaths_per_million) %>% 
  mutate(date = as.Date(date)) %>% 
  filter(new_deaths_per_million != 0) %>% 
  ggplot(aes(x = date, y = cfr)) +
  geom_line()

df3 <- left_join(df2, df1, by = "date") %>% 
  #Case-Fatality Ratio (%) = Number recorded deaths / Number cases
  mutate(cfr = new_cases_per_million / new_deaths_per_million)
