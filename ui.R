install.load::install_load(c("shiny",
                             "tidyverse",
                             "shinythemes",
                             "leaflet",
                             "corrplot",
                             "ggplot2",
                             "dplyr",
                             "shinydashboard",
                             "shinydashboardPlus"))



ui <- dashboardPage(skin = "midnight",
                    dashboardHeader(title = tagList(
                      span(class = "logo-lg", "KC House Prices"), 
                      img(src = "/logo.png",
                          style = "height: auto; width: 180%"))),
                      dashboardSidebar(collapsed = TRUE,
                                     sidebarMenu(
                                       menuItem("Home", tabName = "Home", icon = icon("home")),
                                       menuItem("Dashboard", tabName = "Dashboard", icon = icon("tachometer-alt")),
                                       menuItem("Prediction", tabName = "Prediction", icon = icon("chart-line")),
                                       menuItem("Map", tabName = "Map", icon = icon("globe-americas")),
                                       menuItem("Information", tabName = "Information", icon = icon("info-circle"))
                                     )
                                     
                                     
                    ),
                    dashboardBody(tags$head(
                      # Include the custom styling
                      tags$link(rel = "stylesheet", type = "text/css", href = "style.css")
                      ),
                      # Add the pages
                      tabItems(
                        # First tab content
                        tabItem(tabName = "Home", style = "border: none",
                                
                                img(src = "/house.jpg", 
                                    style = "height: auto; width: 100%; border: none; border-radius: 5px", 
                                      ),
                                
                                actionButton("do", "Get your predicition",
                                    style = "position: absolute;
                                              top: 50%;
                                              left: 50%;
                                              transform: translate(-50%, -50%);
                                              -ms-transform: translate(-50%, -50%);
                                              background-color: #000080;
                                              color: white;
                                              font-size: 16px;
                                              padding: 12px 24px;
                                              border: none;
                                              cursor: pointer;
                                              border-radius: 5px;"),
                        ),
                        # Second tab content
                        tabItem(tabName = "Dashboard",
                                h2("Welcome to the dashboard"),
                                
                                valueBox("Anzahl IDs", "House count", icon = icon("file-csv"), color = "green", width = 3),
                                valueBox("$/QM", "$/QM", icon = icon("dollar-sign"), color = "green", width = 3),
                                valueBox("MDP", "Med Price Dev", icon = icon("dollar-sign"), color = "green", width = 3),
                                valueBox("MHP", "Med House Price", icon = icon("dollar-sign"), color = "green", width = 3),
                                valueBox("MQM", "Med QM", icon = icon("square"), color = "green", width = 3),
                                
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
                                h2("Widgets tab content"),
                                
                                box(
                                  numericInput("bed", label = h3("Bedrooms"), value = 0),
                                  numericInput("bath", label = h3("Bathrooms"), value = 0),
                                  numericInput("floors", label = h3("Floors"), value = 0),
                                  numericInput("view", label = h3("View"), value = 0),
                                  numericInput("grade", label = h3("Grade"), value = 0),
                                  numericInput("con", label = h3("Condition"), value = 0),
                                  numericInput("yr_b", label = h3("Year built"), value = 0),
                                  numericInput("sqm_liv", label = h3("sqm_living"), value = 0),
                                  numericInput("sqm_ab", label = h3("sqm_above"), value = 0),
                                  checkboxGroupInput("sonstiges", label = h3("Sonstiges"), 
                                                     choices = list("Waterfront" = 1, "basement" = 2))
                                                     
                        
                                )
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
