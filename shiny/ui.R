library(shiny)
# https://github.com/rstudio/shiny-examples/blob/master/063-superzip-example/ui.R
# http://shiny.rstudio.com/articles/layout-guide.html

shinyUI(navbarPage("Semester Project Interactivelly", id="nav",
                   tabPanel("DT + Histograms",
                            sidebarLayout(
                              sidebarPanel(
                                p("Click to choose the column and then display histogram and density."), 
                                
                                sliderInput("bins", "Number of bins:", min = 1, max = 50, value = 10), 
                                selectInput("selection", "Choose a column:", choices = colnames(datasetM.withoutFour)),
                                
                                a(href="http://shiny.rstudio.com", "http://shiny.rstudio.com"), 
                                a(href="https://github.com/dmpe/SemesterProject", "https://github.com/dmpe/SemesterProject"),
                                width = 3
                              ),
                              mainPanel(
                                plotOutput("distPlot"),       
                                plotOutput("distPlot2"), 
                                DT::dataTableOutput('x1')
                              )
                            )
                   ), 
                   tabPanel("Cor./Scat. - Service/Produkt",
                            sidebarLayout(
                              sidebarPanel(
                                selectInput("selection1", "Choose a column 1:", choices = colnames(datasetM.withoutFour)),
                                selectInput("selection2", "Choose a column 2:", choices = colnames(datasetM.withoutFour)),
                                selectInput("selection3", "Choose a column 3:", choices = colnames(dataset.product.withoutFour)),
                                selectInput("selection4", "Choose a column 4:", choices = colnames(dataset.product.withoutFour)),
                                
                                p("Click to choose the columns and then display correlations (with regression)."), 
                                a(href="http://shiny.rstudio.com", "http://shiny.rstudio.com"), 
                                a(href="https://github.com/dmpe/SemesterProject", "https://github.com/dmpe/SemesterProject"),
                                width = 2
                                
                              ),
                              mainPanel(
                                fluidRow(
                                  column(8,
                                         plotOutput("scat"), # width = "600px"
                                         plotOutput("scatProduct") #, width = "600px"
                                         
                                  ),
                                  column(4, 
                                         plotOutput("correlation", width = "450px"), # width = "80%"
                                         plotOutput("correlationProduct", width = "450px") #, width = "80%"
                                  )
                                )
                              )
                            )
                   ),
                   tabPanel("Diff. in Cor.", 
                            sidebarLayout(
                              sidebarPanel(
                                p("Click to choose the columns and then display correlations."), 
                                a(href="http://shiny.rstudio.com", "http://shiny.rstudio.com"), 
                                a(href="https://github.com/dmpe/SemesterProject", "https://github.com/dmpe/SemesterProject"),
                                width = 2
                              ),
                              mainPanel(
                                plotOutput("onlyCorrelation", width = "1300px"),
                                # plotOutput("onlyCorrelation2"),
                                verbatimTextOutput("vsechno")
                              )
                            )
                   ), 
                   tabPanel("Faceting, e.g. Gender etc.", 
                            sidebarLayout(
                              sidebarPanel(
                                selectInput("selection5", "Choose first dataset to consider - 5:", choices = colnames(joinedDataSets.without)),
                                selectInput("selection6", "Choose second dataset to consider - 6:", choices = colnames(joinedDataSets.without)),
                                
                                #                                 selectInput("selection7", "Facet Grid - Var 7:", choices = colnames(joinedDataSets.without)),
                                #                                 selectInput("selection8", "Facet Grid - Var 8:", choices = colnames(joinedDataSets.without)),
                                #                                 
                                p("Click to choose the columns and then display correlations (with regression)."), 
                                a(href="http://shiny.rstudio.com", "http://shiny.rstudio.com"), 
                                a(href="https://github.com/dmpe/SemesterProject", "https://github.com/dmpe/SemesterProject"),
                                width = 3
                              ),
                              mainPanel(
                                plotOutput("Facet")
                              )
                            )
                   )
))

