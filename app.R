# Load R packages
library(shiny)
library(shinythemes)


  # Define UI
  ui <- fluidPage(theme = shinytheme("cyborg"),
    navbarPage(
      # theme = "cerulean",  # <--- To use a theme, uncomment this
      "House Price Predicition",
      tabPanel("Home", 
               mainPanel(
                 img(src = "/house.jpg", height = 900, width = 1350),
                 
               ) # mainPanel
               
      ), # Navbar 1, tabPanel
      tabPanel("Predicition", 
               mainPanel(
                            h1("Header 1"),
                            
                            h4("Output 1"),
                            verbatimTextOutput("txtout")
              ) # mainPanel
               
      ),
      tabPanel("Map", 
               mainPanel(
                            h1("Header 1"),
                            
                            h4("Output 1"),
                            verbatimTextOutput("txtout")
              ) # mainPanel
      
               
      ),
      tabPanel("Information",
               mainPanel(
                             h1("Header 1"),
                             
                             h4("Output 1"),
                             verbatimTextOutput("txtout")
               ) # mainPanel
      )
      
  
    ) # navbarPage
  ) # fluidPage

  
  # Define server function  
  server <- function(input, output) {
    
    output$txtout <- renderText({
      paste( input$txt1, input$txt2, sep = " " )
    })
  } # server
  

  # Create Shiny object
  shinyApp(ui = ui, server = server)
