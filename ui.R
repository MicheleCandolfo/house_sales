install.load::install_load(c("shiny",
                             "tidyverse",
                             "shinythemes",
                             "leaflet",
                             "corrplot",
                             "ggplot2",
                             "dplyr",
                             "shinydashboard"))

house_prices <- read.csv("kc_house_data.csv")

ui <- dashboardPage(skin = "blue",
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
                                h2("Widgets tab content")
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
