library(shiny)
library(ggplot2)
library(DT)
library(car)
library(corrplot)

shinyServer(function(input, output) {
  
  output$distPlot <- renderPlot({
    m <- ggplot(datasetM.withoutFour, aes_string(x=input$selection))
    m <- m + geom_histogram(aes(y=..density..), colour="black", fill="white")
    m <- m + geom_density()
    m
  })
  
  # https://rstudio.github.io/DT/
  output$x1 = DT::renderDataTable({
    datatable(datasetM.withoutFour, rownames = row.names(datasetM))
  })
  
  output$distPlot2 <- renderPlot({
    rota2 <- cut(datasetM.withoutFour[, input$selection], input$bins, dig.lab = 4)
    barplot(table(rota2), main = input$selection, ylab="Number of occurences", xlab="Breaks")
    # http://stackoverflow.com/questions/19531729/shiny-fill-value-not-passed-to-ggplot-correctly-in-shiny-server-error-object
  })
  
  output$scat <- renderPlot({
    scatterplot(datasetM.withoutFour[, input$selection1], datasetM.withoutFour[, input$selection2], xlab = "x - 1", ylab = "y - 2")
    # scatterplot(datasetM$User.Engage, datasetM$Experience)
  })
  
  output$correlation <- renderPlot({
    corrrePart <- cor(datasetM.withoutFour)
    corrplot(corrrePart, order = "hclust", type = "lower",  method = "number")
    
    corrrePart[lower.tri(corrrePart)] <- NA
    corrrePart <- data.frame(corrrePart)
    corrrePart
  })
  
})
