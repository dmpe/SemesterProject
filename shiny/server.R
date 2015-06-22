library(shiny)
library(ggplot2)
library(DT)
library(car)
library(corrplot)
library(RColorBrewer)
options(width = 300)

shinyServer(function(input, output) {
  
  output$distPlot <- renderPlot({
    m <- ggplot(joinedDataSets.withoutMany, aes_string(x=input$selection))
    m <- m + geom_histogram(aes(y=..density..), colour="black", fill="white")
    m <- m + geom_density() + ggtitle("Gemeinsamen Datensatz")
    m
  })
  
  output$datAtable = DT::renderDataTable({
    DT::datatable(joinedDataSets.without, rownames = row.names(joinedDataSets.without))
  })
  
  output$distPlot2 <- renderPlot({
    m <- ggplot( data.frame(((joinedDataSets.withoutMany^input$lambda-1)/input$lambda)), aes_string(x = input$selection))
    m <- m + geom_histogram(aes(y=..density..), colour="black", fill="white")
    m <- m + geom_density() + ggtitle("Gemeinsamen Datensatz - Transformiert")
    m
  })
  #   output$distPlot2 <- renderPlot({
  #     # http://stackoverflow.com/questions/19531729/shiny-fill-value-not-passed-to-ggplot-correctly-in-shiny-server-error-object
  #     
  #     rota2 <- cut(datasetM.withoutFour[, input$selection], input$bins, dig.lab = 4)
  #     barplot(table(rota2), main = input$selection, ylab="Number of occurences", xlab="Breaks")
  #   })
  
  output$scat <- renderPlot({
    scatterplot(datasetM.withoutFour[, input$selection1], 
                datasetM.withoutFour[, input$selection2], xlab = "x - 1", ylab = "y - 2", 
                main = "Service", smoother = FALSE)
  })
  
  output$correlation <- renderPlot({
    corrplot(dataset.product.correlation.cor, order = "hclust", type = "lower",  method = "number")
  })
  
  output$scatProduct <- renderPlot({
    scatterplot(dataset.product.withoutFour[, input$selection3], 
                dataset.product.withoutFour[, input$selection4], xlab = "x - 3", ylab = "y - 4", 
                main = "Produkt", smoother= FALSE)
  })
  
  output$correlationProduct <- renderPlot({
    corrplot(dataset.product.correlation.cor, order = "hclust", hclust.method = "ward", type = "lower",  method = "number")
  })
  
  #   output$onlyCorrelation <- renderPlot({
  #     # corrrePart2 <- cor(datasetM.correlation)order = "hclust",
  #     # product2 <- cor(dataset.product.correlation)
  #     # http://r.789695.n4.nabble.com/main-title-in-plot-outer-TRUE-cut-off-td4204006.html
  #     par(mfrow = c(1, 2), omi = c(0,1,1,0.5))
  #     corrplot(dataset.product.correlation.cor, type="lower", method="number") 
  #     title(outer=TRUE, adj = 0, main = list("Produkt Korrelation", cex=1.1, col="black", font=2), line = -1) 
  #     
  #     corrplot(datasetM.correlation.cor, type = "lower",  method = "number")
  #     title(outer=TRUE, adj = 1, main = list("Service Korrelation", cex=1.1, col="black", font=2), line = -1) 
  #     
  #   })
  #   
  #   output$onlyCorrelation2 <- renderPlot({
  #     cols <- rev(colorRampPalette(brewer.pal(10, "RdBu"))(20))
  #     rozdil <- datasetM.correlation.cor - dataset.product.correlation.cor
  #     corrplot.mixed(rozdil, lower = "circle",  upper = "number",  diag='n', outline=T, col=cols, 
  #                    tl.pos="lt", addgrid.col="grey", cl.lim=c(-0.5,0.5), cl.length=length(cols)/2+1)
  #   })
  #   output$vsechno <- renderPrint({
  #     tp1 <- dataset.product.correlation.cor
  #     tp1[lower.tri(tp1)] <- NA
  #     tp2<- datasetM.correlation.cor
  #     tp2[lower.tri(tp2)] <- NA
  #     
  #     writeLines("dataset.product.correlation.cor - datasetM.correlation.cor\n")
  #     
  #     rozdil3 <- tp1 - tp2
  #     rozdil3
  #   })
  #   
  #   output$Facet <- renderPlot({
  #     # https://gist.github.com/jcheng5/3239667
  #     sp <- ggplot(joinedDataSets.without, aes_string(x=input$selection5, y=input$selection6)) 
  #     sp <- sp + geom_point(shape=1) + stat_smooth(method = "lm")
  #     # MANUAL required
  #     sp <- sp + facet_grid(Gender ~ TypeDataSet)
  #     print(sp)
  #   })
  
  output$renderqqPlot2 <- renderPlot({
    qqnorm(joinedDataSets.withoutMany[, input$selection15])
    qqline(joinedDataSets.withoutMany[, input$selection15])
  })
  
  output$renderqqPlot <- renderPlot({
    reactivejoinedVar <- joinedDataSets.withoutMany[, input$selection15]
    df.reactivejoinedVar <- (reactivejoinedVar^input$lambdaQQPlots-1)/input$lambdaQQPlots
    qqnorm(df.reactivejoinedVar)
    qqline(df.reactivejoinedVar)
  })
  
  output$renderProductEllipse <- renderPlot({
    xAQ2 <- (dataset.product.withoutFour$Acquaintance^0.5-1)/0.5
    yAQ2 <- (dataset.product.withoutFour$User.Engage^0.5-1)/0.5
    
    confidenceEllipse(lm(yAQ2 ~ xAQ2), levels = input$levels2, main = "Produkt")
  })
  
  output$renderServiceEllipse <- renderPlot({
    xAQ22 <- (datasetM.correlation$Acquaintance^0.5-1)/0.5
    yAQ23 <- (datasetM.correlation$User.Engage^0.5-1)/0.5
    
    confidenceEllipse(lm(yAQ23 ~ xAQ22), levels = input$levels2, main = "Service", xlim = c(25, 45), ylim = c(0.4,0.8))
  })
  
  output$renderJoinedEllipse <- renderPlot({
    xAQ221 <- (joinedDataSets.withoutMany$Acquaintance^0.5-1)/0.5
    yAQ231 <- (joinedDataSets.withoutMany$User.Engage^0.5-1)/0.5
    
    confidenceEllipse(lm(yAQ231 ~ xAQ221), levels = input$levels2, main = "Gemeinsamen Datensatz")
  })
  
  
})
