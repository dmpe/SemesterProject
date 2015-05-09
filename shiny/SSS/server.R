library(shiny)
library(ggplot2)
library(DT)
library(car)
library(corrplot)
library(RColorBrewer)

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
  })
  
  output$correlation <- renderPlot({
    corrrePart <- cor(datasetM.withoutFour)
    corrplot(corrrePart, order = "hclust", type = "lower",  method = "number")
  })
  
  output$scatProduct <- renderPlot({
    scatterplot(dataset.product.withoutFour[, input$selection3], dataset.product.withoutFour[, input$selection4], xlab = "x - 3", ylab = "y - 4")
  })
  
  output$correlationProduct <- renderPlot({
    corrrePart <- cor(dataset.product.withoutFour)
    corrplot(corrrePart, order = "hclust", type = "lower",  method = "number")
  })
  
  output$onlyCorrelation <- renderPlot({
    # corrrePart2 <- cor(datasetM.correlation)
    #     product2 <- cor(dataset.product.correlation)
    par(mfrow = c(1,2))
    corrplot(cor(dataset.product.correlation), order = "hclust", type="lower", method="number")
    corrplot(cor(datasetM.correlation), order = "hclust", type = "lower",  method = "number")
  })
  
  output$onlyCorrelation2 <- renderPlot({
    #     datasetM.correlation.cor[lower.tri(datasetM.correlation.cor)] <- NA
    #     dataset.product.correlation.cor[lower.tri(dataset.product.correlation.cor)] <- NA
    cols <- rev(colorRampPalette(brewer.pal(10, "RdBu"))(20))
    rozdil <- datasetM.correlation.cor - dataset.product.correlation.cor
    corrplot.mixed(rozdil, lower = "number",  upper = "circle",  diag='n', outline=T, col=cols, tl.pos="lt", addgrid.col="grey", cl.lim=c(-0.5,0.5), cl.length=length(cols)/2+1)
  })
  
  output$Facet <- renderPlot({
    # https://gist.github.com/jcheng5/3239667
    sp <- ggplot(joinedDataSets.without, aes_string(x=input$selection5, y=input$selection6)) + geom_point(shape=1) + stat_smooth(method = "lm")
    facets <- paste(input$selection7, '~', input$selection8)
    if (facets != '. ~ .') {
      sp <- sp + facet_grid(facets)
    }
    sp
  })
  
})
