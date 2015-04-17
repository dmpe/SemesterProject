
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#
# library(xlsx)
library(shiny)
# datasetM <- read.xlsx("/srv/shiny-server/SemesterProject/Data/DataSet_01.xlsx", sheetIndex = 1, endRow=277)

shinyUI(fluidPage(

  # Application title
  titlePanel("Un-explained Data -> Interactively"),
  helpText("Mistakes can occur !"),
  hr(),
           
  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      sliderInput("bins",
                  "Number of bins:",
                  min = 1,
                  max = 50,
                  value = 10), 
      selectInput("selection", "Choose a book:", choices = colnames(datasetM[2:11]))
    ),

    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("distPlot")
    )
  )
))
