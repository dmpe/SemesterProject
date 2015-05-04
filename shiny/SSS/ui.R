library(shiny)
# https://github.com/rstudio/shiny-examples/blob/master/063-superzip-example/ui.R
# http://shiny.rstudio.com/articles/layout-guide.html

shinyUI(navbarPage("Un-explained Data", id="nav",
                   tabPanel("DT + Histograms",
                            
                            #titlePanel("Un-explained Data -> Interactively"),
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
                            
                   ), 
                   tabPanel("DT + Histograms",
                            sidebarLayout(
                              sidebarPanel(
                                selectInput("selection1", "Choose a column:", choices = colnames(datasetM.withoutFour)),
                                selectInput("selection2", "Choose a column:", choices = colnames(datasetM)),
                                
                                p("Click to choose the column and then display histogram and density."), 
                                p("With love from D.P. :"), 
                                a("http://shiny.rstudio.com"), 
                                a("https://github.com/dmpe/SemesterProject")
                              ),
                              mainPanel(
                                plotOutput("scat"),
                                plotOutput("correlation")
                              )
                            )
                   )
))
