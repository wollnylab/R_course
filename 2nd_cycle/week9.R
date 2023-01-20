### homework week 8

# load libraries
library(dplyr)
library(ggplot2)
library(stringr)
library(tidyr)

# load data
fert_data <- read.csv(file = "~/PI/Lectures/R_course/2nd_cycle/doi_10.5061_dryad.2rbnzs7qh__v6/FUBC_1_to_9_data.csv") %>% 
  as_tibble()

### histogramm
test <- fert_data %>% 
  filter(Year_FUBC_publication == 2022) %>% 
  filter(str_detect(string = Crop, pattern = "[Mm]aize")) %>% 
  group_by(Country) %>% 
  summarise(maize_area = sum(Crop_area_k_ha)) 

ave <- mean(test$maize_area)
med <- median(test$maize_area)
test %>% 
  ggplot(mapping = aes(maize_area)) +
  geom_histogram(color = "black", fill = "white", bins = 15) +
  scale_x_continuous(trans = "log10") +
  geom_vline(xintercept = ave, linetype = 2, color = "red", size = 2, alpha = .5) + 
  geom_vline(xintercept = med, linetype = 2, color = "blue", size = 2, alpha = .5) +
  theme_bw() +
  annotate(
    geom = "text",
    label = " --- mean", 
    x = 5, y = 11, size = 5, color = "red"
   ) +
  annotate(
    geom = "text",
    label = " --- median", 
    x = 5, y = 10, size = 5, color = "blue"
  )

### bar plot
fert_data %>% 
  filter(Year_FUBC_publication == 2022) %>% 
  ggplot(aes(x = Crop)) +
  geom_bar(aes(fill = Crop)) + 
  scale_fill_viridis_d(option = "plasma") +
  theme(axis.text.x = element_text(face = "bold", color = "black", angle = 90, hjust=1,vjust=0.5)) #+
  #theme_bw() 
  

### stacked bar plot
fert_data %>% 
  filter(Year_FUBC_publication == 2022) %>% 
  group_by(Crop, Year) %>% 
  summarise(mean_land_space = mean(Crop_area_k_ha)) %>% 
  ggplot() +
  geom_bar(aes(x = Year, y = mean_land_space, fill = Crop), stat = "identity", color = "white", position = "dodge") 
  
