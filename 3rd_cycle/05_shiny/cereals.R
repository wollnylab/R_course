# data from: https://www.kaggle.com/datasets/crawford/80-cereals

# clean up data
cereals <- read.csv(file = "~/PI/Lectures/R_course/3rd_cycle/05_shiny/cereal.csv", sep = ";") %>% 
  as_tibble() %>% 
  filter(name != "String") %>% 
  select(name, protein, sugars) %>% 
  mutate_at(c("protein", "sugars"), as.numeric) %>% 
  filter(protein > 0,
         sugars > 0) 

# plot data
cereals %>% 
  pivot_longer(cols = c(protein, sugars), names_to = "nutrient", values_to = "grams") %>% 
  ggplot(aes(x = name, y = grams, fill = nutrient)) +
  geom_col() +
  facet_wrap(~nutrient) +
  coord_flip() +
  labs(x = "")
