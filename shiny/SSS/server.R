
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(ggplot2)

shinyServer(function(input, output) {
  
  output$distPlot <- renderPlot({
    m <- ggplot(datasetM.withoutFour, aes_string(x=input$selection))
    m <- m + geom_histogram(aes(y=..density..), colour="black", fill="white")
    m <- m + geom_density()
    m
  })
  
  output$distPlot2 <- renderPlot({
    rota2 <- cut(datasetM.withoutFour[, input$selection], input$bins, dig.lab = 4)
    barplot(table(rota2), main = input$selection, ylab="Number of occurences", xlab="Breaks")
    # http://stackoverflow.com/questions/19531729/shiny-fill-value-not-passed-to-ggplot-correctly-in-shiny-server-error-object
    
  })
  
})
