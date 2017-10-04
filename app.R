library(future)
library(shiny)
plan(multiprocess)

ui <- fluidPage(
  
  # Application title
  titlePanel("Old Faithful Geyser Data"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      sliderInput("bins",
                  "Number of bins:",
                  min = 1,
                  max = 50,
                  value = 30),
      actionButton("MakePlot", "MakePlot")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      fluidRow(
        column(6, plotOutput("distPlot")),
        column(6, plotOutput("FuturePlot")))
    )
  )
)

# Define server logic required to draw a histogram
source("helpers.R")
source("sub1.R")
source("sub2.R")
server <- function(input, output, session) {
  
  subServer1(input, output, session)
  subServer2(input, output, session)
}



shinyApp(ui = ui, server = server)