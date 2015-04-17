
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyServer(function(input, output) {
  
  output$distPlot <- renderPlot({

    rota2 <- cut(datasetM[, input$selection], input$bins, dig.lab = 4)
    barplot(table(rota2), main = input$selection, ylab="Number of Telephones", xlab="Year")
    

  })

})
