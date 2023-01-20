# Required packages 
library(shiny)
library(ggplot2)
library(dplyr) 

# load data
cereals <- read.csv(file = "~/PI/Lectures/R_course/3rd_cycle/05_shiny/cereal.csv", sep = ";") %>% 
  filter(name != "String") %>% 
  select(name, protein, sugars) %>% 
  mutate_at(c("protein", "sugars"), as.numeric) %>% 
  filter(protein > 0,
         sugars > 0) 

# Define UI for application
ui <- fluidPage(
  # title of the app
  titlePanel("My favourite cereals"),
  # the layout of the app: sidebar-layout
  sidebarLayout(
    sidebarPanel(
      sliderInput(inputId = "sugar", 
                  label = "Max. amount of sugar?", 
                  min=min(cereals$sugars), max=max(cereals$sugars), value= c(7)),
      sliderInput(inputId = "protein", 
                  label = "Max. amount of protein?", 
                  min=min(cereals$protein), max=max(cereals$protein), value= c(3))
    ),
    mainPanel(plotOutput("cereal_plot"))
  )
)

# Computation of the app
server <- function(input, output) {
  output$cereal_plot <- renderPlot({cereals %>% 
                              filter(sugars <= input$sugar, protein <= input$protein) %>% 
                              pivot_longer(cols = c(protein, sugars), names_to = "nutrient", values_to = "grams") %>% 
                              ggplot(aes(x = name, y = grams, fill = nutrient)) +
                              geom_col() +
                              facet_wrap(~nutrient) +
                              coord_flip() +
                              labs(x = "")
  })
}

# Run the app
shinyApp(ui = ui, server = server)

