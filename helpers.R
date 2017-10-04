library(future)
library(shiny)
# BASED ON http://www.blog.zstat.pl/2017/04/24/make-asynchronous-call-in-shiny./


doAsync <- function(fun,future,...){
  x <- NULL
  
  # This is needed to register potential "input" dependencies to Shiny
  isTRUE(...)
  
  isolate({
    # First check if there is already job scheudled
    if(is.null(future$future)) {
      future$future <- future({
        # here magic
        fun(...)
      })
      cat("Work scheduled\n")
    } else if(!resolved(future$future)) {
      cat("Waiting\n")
    } else {
      x <- value(future$future)
      future$future <- NULL
      cat("Done!\n")
    }
  })
  
  if(is.null(x)) invalidateLater(250) # Wait 1s
  
  req(x) # Stop there if x is still null
  return(x)
}