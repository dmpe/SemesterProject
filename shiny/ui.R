library(shiny)
# https://github.com/rstudio/shiny-examples/blob/master/063-superzip-example/ui.R
# http://shiny.rstudio.com/articles/layout-guide.html

shinyUI(navbarPage("Shiny Web", id="nav",
                   tabPanel("Histogramme",
                            sidebarLayout(
                              sidebarPanel(
                                #                                 p("Click to choose the column and then display histogram and density."), 
                                strong("Gemeinsamen Datensatz"), 
                                br(""),
                                
                                selectInput("selection", "Choose a variable:", selected = names(joinedDataSets.withoutMany)[2], choices = colnames(joinedDataSets.withoutMany)),
                                sliderInput("lambda", "Lambda:", min = 0.1, max = 1, value = 1), 
                                
                                a(href="http://shiny.rstudio.com", "http://shiny.rstudio.com"), 
                                a(href="https://github.com/dmpe/SemesterProject", "https://github.com/dmpe/SemesterProject"),
                                width = 2
                              ),
                              mainPanel(
                                plotOutput("distPlot"),       
                                plotOutput("distPlot2")
                              )
                            )
                   ), 
                   tabPanel("Cor./Scat.",
                            sidebarLayout(
                              sidebarPanel(
                                #                                 p("Click to choose the columns and then display correlations (with regression)."), 
                                
                                selectInput("selection1", "Choose a variable x-1:", choices = colnames(datasetM.withoutFour)),
                                selectInput("selection2", "Choose a variable y-2:", choices = colnames(datasetM.withoutFour), selected = names(datasetM.withoutFour)[2]),
                                selectInput("selection3", "Choose a variable x-3:", choices = colnames(dataset.product.withoutFour)),
                                selectInput("selection4", "Choose a variable y-4:", choices = colnames(dataset.product.withoutFour), selected = names(dataset.product.withoutFour)[2]),
                                
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
                   tabPanel("QQ-Plots",
                            sidebarLayout(
                              sidebarPanel(
                                #                                 p("Click to choose the column and then display qq-plots."), 
                                strong("Gemeinsamen Datensatz"), 
                                br(""),
                                
                                selectInput("selection15", "Choose a variable:", choices = colnames(joinedDataSets.withoutMany)),
                                sliderInput("lambdaQQPlots", "Lambda:", min = 0.1, max = 1, value = 1), 
                                
                                a(href="http://shiny.rstudio.com", "http://shiny.rstudio.com"), 
                                a(href="https://github.com/dmpe/SemesterProject", "https://github.com/dmpe/SemesterProject"),
                                width = 3
                              ),
                              mainPanel(
                                plotOutput("renderqqPlot2"),  
                                plotOutput("renderqqPlot")
                              )
                            )
                   ), 
                   #                    tabPanel("Faceting, e.g. Gender", 
                   #                             sidebarLayout(
                   #                               sidebarPanel(
                   #                                 selectInput("selection5", "Choose first dataset to consider - 5:", choices = colnames(joinedDataSets.without)),
                   #                                 selectInput("selection6", "Choose second dataset to consider - 6:", choices = colnames(joinedDataSets.without)),
                   #                                 
                   #                                 p("Click to choose the columns and then display correlations (with regression)."), 
                   #                                 a(href="http://shiny.rstudio.com", "http://shiny.rstudio.com"), 
                   #                                 a(href="https://github.com/dmpe/SemesterProject", "https://github.com/dmpe/SemesterProject"),
                   #                                 width = 3
                   #                               ),
                   #                               mainPanel(
                   #                                 plotOutput("Facet")
                   #                               )
                   #                             )
                   #                    ), 
                   tabPanel("Konfidenz Ellipse",
                            sidebarLayout(
                              sidebarPanel(
                                p("Change ellipse's confidence level."), 
                                
                                numericInput('levels2', 'Confidence level', value = 0.10, min = 0.10, max = 0.99),
                                
                                a(href="http://shiny.rstudio.com", "http://shiny.rstudio.com"), 
                                a(href="https://github.com/dmpe/SemesterProject", "https://github.com/dmpe/SemesterProject"),
                                width = 2
                              ),
                              mainPanel(
                                plotOutput("renderProductEllipse"), 
                                plotOutput("renderServiceEllipse"), 
                                plotOutput("renderJoinedEllipse")
                              )
                            )
                   )
                   #                    tabPanel("Diff. in Cor.", 
                   #                             sidebarLayout(
                   #                               sidebarPanel(
                   #                                 p("Click to choose the columns and then display correlations."), 
                   #                                 a(href="http://shiny.rstudio.com", "http://shiny.rstudio.com"), 
                   #                                 a(href="https://github.com/dmpe/SemesterProject", "https://github.com/dmpe/SemesterProject"),
                   #                                 width = 2
                   #                               ),
                   #                               mainPanel(
                   #                                 plotOutput("onlyCorrelation", width = "1300px"),
                   #                                 verbatimTextOutput("vsechno"),
                   #                                 plotOutput("onlyCorrelation2")
                   #                               )
                   #                             )
                   #                    ), 
                   #                    tabPanel("Dataset - Table",
                   #                             #                             sidebarLayout(
                   #                             #                               sidebarPanel(
                   #                             #                                 a(href="http://shiny.rstudio.com", "http://shiny.rstudio.com"), 
                   #                             #                                 a(href="https://github.com/dmpe/SemesterProject", "https://github.com/dmpe/SemesterProject"),
                   #                             #                                 width = 2
                   #                             #                               ), 
                   #                             mainPanel(
                   #                               DT::dataTableOutput('datAtable')
                   #                             )
                   #                    )
                   #                    )
))

