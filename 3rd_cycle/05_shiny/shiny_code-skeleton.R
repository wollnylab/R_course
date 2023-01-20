# - - - - - - - - - - - - - - - - - 
# shiny app skeleton (sidebarLayout)
# - - - - - - - - - - - - - - - - - 

# Load required packages 

# load data

# Define UI for application
ui <- fluidPage(
  # title of the app
  titlePanel("Title"),
  # the layout of the app: sidebar-layout
  sidebarLayout(
    sidebarPanel(sliderInput()),
    mainPanel()
  )
)

# Computation of the app
server <- function(input, output) {}

# Run the app
shinyApp(ui = ui, server = server)