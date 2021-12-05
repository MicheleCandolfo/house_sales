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
                      img(src = "/images/logo.png",
                          style = "height: auto; width: 180%"))),
                      dashboardSidebar(collapsed = TRUE,
                                     sidebarMenu(
                                       menuItem("Home", tabName = "Home", icon = icon("home")),
                                       menuItem("Dashboard", tabName = "Dashboard", icon = icon("tachometer-alt")),
                                       menuItem("Prediction", tabName = "Prediction", icon = icon("chart-line")),
                                       menuItem("Map", tabName = "Map", icon = icon("globe-americas")),
                                       menuItem("About", tabName = "About", icon = icon("info-circle"))
                                     )
                    ),
                    #-----------------------------------------------------------------
                    dashboardBody( style = "border: none",
                      
                      tags$head(
                      # Include the custom styling
                      tags$link(rel = "stylesheet", type = "text/css", href = "style.css")
                      ),
                      # Add the pages
                      #-----------------------------------------------------------------
                      tabItems(
                        # First tab content
                        #-----------------------------------------------------------------
                        tabItem(tabName = "Home", style = "border: none",
                                
                                img(src = "/images/house.jpg", 
                                    style = "height: auto; width: 100%; border: none; border-radius: 5px", 
                                      ),
                                
                                actionButton('actionButton', 'Get your prediciton',
                                    style = "position: absolute;
                                              top: 48%;
                                              left: 50%;
                                              transform: translate(-50%, -50%);
                                              -ms-transform: translate(-50%, -50%);
                                              background-color: rgba(0, 191, 255,0.5);
                                              color: white;
                                              font-size: 16px;
                                              padding: 12px 24px;
                                              border: none;
                                              cursor: pointer;
                                              border-radius: 5px;"),
                                
                                h2("You like to know how much your real estate in King County is worth?",
                                             style = "position: absolute;
                                              top: 35%;
                                              left: 50%;
                                              transform: translate(-50%, -50%);
                                              -ms-transform: translate(-50%, -50%);
                                              background-color: rgba(255, 255, 255,0.45);
                                              color: black;
                                              font-size: 16px;
                                              padding: 12px 24px;
                                              border: none;
                                              cursor: pointer;
                                              border-radius: 5px;"),
                                h3("Start getting a precise predicition based on AI about your real estate in King Country!",
                                     style = "position: absolute;
                                              top: 40%;
                                              left: 50%;
                                              transform: translate(-50%, -50%);
                                              -ms-transform: translate(-50%, -50%);
                                              background-color: rgba(255, 255, 255,0.45);
                                              color: black;
                                              font-size: 16px;
                                              padding: 12px 24px;
                                              border: none;
                                              cursor: pointer;
                                              border-radius: 5px;"),
                        ),
                        # Second tab content
                        #-----------------------------------------------------------------
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
                        #-----------------------------------------------------------------
                        tabItem(tabName = "Prediction",
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
                        #-----------------------------------------------------------------
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
                        #-----------------------------------------------------------------
                        tabItem(tabName = "About",
                                div(
                                  h1("About the project"),
                                  br(),
                                  h2("About the data set"),
                                  h3("General Information"),
                                  h3("Column description"),
                                  br(),
                                  h2("About the algorithm"),
                                  br(),
                                  h2("About data preparation"),
                                  br(),
                                  h2("About the team")),

                                
                                  div(class ="container", 
                                    div(class ="row",
                                      div(class="col-md-12"),
                                        h1(class="title fit-h1","Who we are?")),
                                    div(class="marketing"),
                                      div(class="row",
                                        div(class="col-md-4",
                                          img(class="img-circle", src="/images/leandra.png", alt="", width = 200),
                                          h2("Leandra Sommer"),
                                          code("Data loving and collaborative leader that enjoys team-based environments dedicated to identifying and implementing business solutions that enable teams to deliver superior products, content and service to clients."),
                                          a(href="https://www.linkedin.com/in/patrick-kurz-85b73813b")),
                                        div(class="col-md-4",
                                          img(class="img-circle", src="/images/michele.png", alt="", width = 200),
                                          h2("Michele Candolfo"),
                                          code("Data loving and collaborative leader that enjoys team-based environments dedicated to identifying and implementing business solutions that enable teams to deliver superior products, content and service to clients."),
                                          a(href="https://www.linkedin.com/in/michele-candolfo-175087152")),
                                        div(class="col-md-4",
                                          img(class="img-circle", src="/images/patrick.png", alt="", width = 200),
                                          h2("Patrick Kurz"),
                                          code("Data loving and collaborative leader that enjoys team-based environments dedicated to identifying and implementing business solutions that enable teams to deliver superior products, content and service to clients."),
                                          a(href="https://www.linkedin.com/in/patrick-kurz-85b73813b")),
                                      ),
                                  #add custom style css
                                  tags$head(
                                  tags$link(rel = "stylesheet", 
                                            type = "text/css", 
                                            href = "/carousel.css"),
                                  #tags$script(src = "/holder.js")
                                  ),
                                  tags$style(type="text/css"
                                  ) 
                        )
                      )
                    )
))
