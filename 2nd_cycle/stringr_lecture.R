# get libraries
library(dplyr)
library(ggplot2)
library(stringr)

# get data
firt_data <- read.csv(file = "~/PI/Lectures/R_course/2nd_cycle/doi_10.5061_dryad.2rbnzs7qh__v6/FUBC_1_to_9_data.csv") %>% 
  as_tibble()

# What are the 3 most common crops?
firt_data %>% count(Crop) %>% arrange(desc(n)) %>% head(3)

# Problem: There are many entries containing Maize that are not exactly called "Maize". See:
firt_data %>% count(Crop) %>% View()

# How can we filter for all rows containg the word maize -> intro stringr / regex
firt_data %>% filter(str_detect(string = Crop, pattern = "Maize")) %>% count(Crop)

# Problem: "maize" is not inside because no capital "M" -> intro regex
test_string <- c("apple", "banana", "pear")
# basic matching
str_detect(string = test_string, pattern = "a")
str_detect(string = test_string, pattern = "ap")
# "." -> any character
str_detect(string = test_string, pattern = "ap.le")
# "^" anchor beginning of sting; "$" anchor end of string
str_detect(string = test_string, pattern = "^a")
str_detect(string = test_string, pattern = "a$")
# multiple matches
str_detect(string = test_string, pattern = "a[pr]")
x <- c("apple", "Apple")
str_detect(string = x, pattern = "[Aa]pple")
str_detect(string = x, pattern = ".pple")

# lets get all maize's
firt_data %>% filter(str_detect(string = Crop, pattern = "[Mm]aize")) %>% count(Crop)

# Analyse Germany's maize production over time?
firt_data %>% 
  filter(str_detect(string = Crop, pattern = "[M|m]aize")) %>% 
  filter(Country == "Germany") %>% 
  group_by(Year) %>% 
  summarise(maize_area = sum(Crop_area_k_ha)) %>% 
  ggplot(aes(x = Year, y = maize_area, group = 1)) +
  geom_point() +
  geom_line()