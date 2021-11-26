install.load::install_load(c("shiny",
                             "tidyverse",
                             "shinythemes",
                             "leaflet",
                             "corrplot",
                             "ggplot2",
                             "dplyr",
                             "shinydashboard",
                             "shinydashboardPlus"))

house_prices <- read.csv("kc_house_data.csv")

ui <- dashboardPage(skin = "midnight",
                    dashboardHeader(title = "House Price Predicition"),
                    dashboardSidebar(collapsed = TRUE,
                                     sidebarMenu(
                                       menuItem("Home", tabName = "Home", icon = icon("home")),
                                       menuItem("Dashboard", tabName = "Dashboard", icon = icon("tachometer-alt")),
                                       menuItem("Prediction", tabName = "Predicition", icon = icon("chart-line")),
                                       menuItem("Map", tabName = "Map", icon = icon("globe-americas")),
                                       menuItem("Information", tabName = "Information", icon = icon("info-circle"))
                                     )
                                     
                                     
                    ),
                    dashboardBody(
                      tabItems(
                        # First tab content
                        tabItem(tabName = "Home",
                                div(
                                  id = 'myDiv', class = 'simpleDiv',
                                  img(src = "/house.jpg", height = "100%", width = "100%"
                                      
                                  )
                                )
                                
                                
                        ),
                        # Second tab content
                        tabItem(tabName = "Dashboard",
                                h2("Welcome to the dashboard"),
                                
                                valueBox(10 * 2, "Example", icon = icon("credit-card"), color = "green"),
                                valueBox(10 * 4, "Example", icon = icon("list"), color = "purple"),
                                valueBox(10 * 6, "Example", icon = icon("thumbs-up"), color = "red"),
                                
                                box(
                                  title = "Histogram", status = "primary", solidHeader = TRUE,
                                  collapsible = TRUE,
                                  plotOutput("plot3", height = 250)
                                ),
                                
                                box(
                                  title = "Inputs", status = "warning", solidHeader = TRUE,
                                  "Box content here", br(), "More box content",
                                  sliderInput("slider", "Slider input:", 1, 100, 50),
                                  textInput("text", "Text input:")
                                )
                                
                        ),
                        
                        # Third tab content
                        tabItem(tabName = "Predicition",
                                h2("Widgets tab content")
                        ),
                        # Fourth tab content
                        tabItem(tabName = "Map",
                                box(
                                  selectizeInput("zip","Zipcode", 
                                                 choices= c("98178", "98125","98028", "98136", "98074", "98053", "98003", "98198", "98146" ), 
                                  )
                                  
                                ),
                                
                                box(
                                  leafletOutput("int_map")
                                  
                                )
                                
                                
                        ),
                        # Fifth tab content
                        tabItem(tabName = "Information",
                                h2("Widgets tab content")
                        )
                        
                      )
                      
                      
                      
                    )
)
