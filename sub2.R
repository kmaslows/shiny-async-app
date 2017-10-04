library(shiny)
source("helpers.R")

# Example of async server component
subServer2 <- function(input, output, session, future){
  # If you use doAsync is several places, make sure you use different reactive value to store the job
  future <- reactiveValues(future = NULL)
  getData <- reactive({
    doAsync(doStuff,future$future,input$bins)
  })
  
  output$FuturePlot <- renderPlot({
    input$MakePlot
    input$bins
    cat("renderPlot\n")
    x <- getData()
    
    plot(x)
  })
}

doStuff <- function(arg){
  Sys.sleep(4)
  cbind(rnorm(arg*10), rnorm(arg*10))
}