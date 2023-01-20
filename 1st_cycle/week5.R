library(tidyverse)

cov <- read.csv(file = "~/PI/Lectures/R_course/1st_cycle/new_covid_data.csv") %>% as_tibble()

# explain that you can pipe the results from df into ggplot

# introduce labs() 
cov %>% 
  filter(continent != "") %>% 
  filter(date == "2022-09-27") %>% 
  select(location, aged_70_older, total_deaths_per_million, continent) %>% 
  ggplot() +
  geom_point(aes(x = aged_70_older, y = total_deaths_per_million, color = continent), size = 3) +
  labs(title = "Age vs. Death rate", x = "Fraction of pop. over 70 years", y = "Deaths / million people", color = "Continent")

# Introduce geom_label()
cov %>% 
  filter(continent != "") %>% 
  filter(date == "2022-09-27") %>% 
  select(location, aged_70_older, total_deaths_per_million, continent) %>% 
  ggplot(aes(x = aged_70_older, y = total_deaths_per_million, color = continent)) +
  geom_point(size = 3) +
  labs(title = "Age vs. Death rate", x = "Fraction of pop. over 70 years", y = "Deaths / million people", color = "Continent") +
  geom_label(mapping = aes(label = location), data = cov %>% filter(date == "2022-09-27", total_deaths_per_million > 6000)) #+
  #geom_label(label = "Country") 
  # where are my dots? demonstrate by switching the layer geom_point & geom_label

# Introduce geom_boxplot() -> explain the detail about a boxplot
cov %>% 
  filter(continent == "South America") %>% 
  ggplot(aes(x = location, y = total_deaths_per_million)) +
  geom_boxplot() +
  coord_flip()

# Introduce geom_line -> explain group -> explain inheritance of aes() and put it in ggplot() function
cov %>% 
  select(date, location, total_cases) %>% 
  filter(location == "United States") %>% 
  head() %>% 
  ggplot() +
  geom_line(aes(x=date, y=total_cases, group = location)) +
  geom_point(aes(x=date, y=total_cases))

# homework recap: Introduce scale_y_continous
cov %>% 
  filter(date == '2022-09-27') %>%
  filter(continent != "") %>% 
  select(location, continent, population_density, reproduction_rate) %>% 
  ggplot() +
  geom_point( mapping = aes(x = population_density, y = reproduction_rate, color = continent)
              , size = 5, alpha = 0.6) +
  scale_x_continuous(trans = "log10")
  
# homework recap: explore stringency index
# Government Response Stringency Index: composite measure based on 9 response indicators including school closures, workplace closures, 
# and travel bans, rescaled to a value from 0 to 100 (100 = strictest response)
cov %>% filter(location == "Peru" | location == "Japan") %>% select(date, location, stringency_index) %>% 
  mutate(date = as.Date(date)) %>% 
  ggplot(aes(x = date, y = stringency_index, color = location)) +
  geom_line(group = "location")


cov %>% 
  select(date, continent, location, total_deaths_per_million) %>% 
  filter(date == "2021-01-01" | date == "2022-01-01", continent == "Europe", 
         location == "Hungary" | location == "Iceland" | location == "Austria") %>%
  ggplot() +
  geom_line(aes(x=date, y=total_deaths_per_million, group = location, color = location)) +
  geom_point(aes(x=date, y=total_deaths_per_million)) +
  labs(title = "Death toll of 2021", x = "Dates", y = "Deaths / million")
