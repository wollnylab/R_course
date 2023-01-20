#########################################
### Intro to table joining with dplyr ###
#########################################

# load library
library(dplyr)

# Introducing the 'joins'
# # # # # # # # # # # # #

# draw df1 & df2 (see below) on the board and explain the key
# 'id' column is the key column by which tables will be merged -> explain what key is

# Create first example data frame
df1 <- data.frame(id = 1:2,
                  fruits = c("apple", "banana"))
# Create second example data frame
df2 <- data.frame(id = 2:3,
                  vegtables = c("tomato", "potato"))

# inner_join keeps all observations that are in BOTH tables
inner_join(df1, df2, by = "id")
# full join keeps all observations in df1 and df2.
full_join(df1, df2, by = "id")

# left join keeps all observations in df1.
# The most commonly used join is the left join: 
left_join(df1, df2, by = "id")
# right join keeps all observations in df2.
right_join(df1, df2, by = "id")

# Keys are not identical
# # # # # # # # # # # # #
df2 <- data.frame(ID = 2:3,
                  vegtables = c("tomato", "potato"))
inner_join(df1, df2, by = "id") # does not work
inner_join(df1, df2, by = c("id" = "ID"))

# Duplicate keys problem
# # # # # # # # # # # # #
df1 <- data.frame(id = c(1,2,2,3),
                  fruits = c("apple", "banana", "banana", "orange"))
df2 <- data.frame(id = 2:3,
                  vegtables = c("tomato", "potato"))

left_join(df1, df2, by = "id")
# careful: the number of tomatos in our list has been doubled!

# Almost identical key problem
# # # # # # # # # # # # # # # #
df1 <- data.frame(id = c("germany", "denmark"),
                  fruits = c("apple", "banana"))
df2 <- data.frame(id = c("germany", "denmark."),
                  vegtables = c("tomato", "potato"))
left_join(df1,df2, by = "id")
# careful: you lost some data! 
# how can you avoid that? -> anti_join() sanity check
# anti_join() drops all observations in df1 that have a match in df2
anti_join(df1, df2, by = "id")
