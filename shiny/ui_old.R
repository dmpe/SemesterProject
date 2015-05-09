# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(
  
  titlePanel("Un-explained Data -> Interactively"),
  helpText("Mistakes can occur !"),
           
  sidebarLayout(
    sidebarPanel(
      sliderInput("bins", "Number of bins:", min = 1, max = 50, value = 10), 
      
      selectInput("selection", "Choose a column:", choices = colnames(datasetM.withoutFour)),
      
      p("Click to choose the column and then display histogram and density."), 
      p("With love from D.P. :"), 
      a("http://shiny.rstudio.com"), 
      a("https://github.com/dmpe/SemesterProject")
    ),

    mainPanel(
      plotOutput("distPlot"),       
      plotOutput("distPlot2"), 
      DT::dataTableOutput('x1')
    )
  )
))
