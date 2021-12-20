install.load::install_load(c("shiny",
                             "tidyverse",
                             "shinythemes",
                             "leaflet",
                             "corrplot",
                             "ggplot2",
                             "dplyr",
                             "shinydashboard",
                             "shinydashboardPlus", 
                             "shinyjs", 
                             "tippy"
                            ))

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
                                   useShinyjs(),
                      
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
                       
                        
                        actionButton('prediction', 'Prediction', onclick="location.href='Prediction';",
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
                                
                               box(width = 12, 
                                
                                     flipBox(
                                       id = "myflipbox1",
                                       width = 4,
                                
                                      front = div(
                                        class = "text-center",
                                        width = 4,
                                        valueBoxOutput("vbox1", width = 12),
                                         
                                       ),
                                       back = div(
                                         class = "text-center",
                                         width= 4,
                                         h3(min(house_prices5$price)),
                                         p("Lowest Price in $")
                                       )
                                     
                                   ),
                                   flipBox(
                                     id = "myflipbox2",
                                     width = 4,
                                     
                                     front = div(
                                       class = "text-center",
                                       width = 4,
                                       valueBoxOutput("vbox2", width = 12),
                                       
                                     ),
                                     back = div(
                                       class = "text-center",
                                       width= 4,
                                       h3(round(mean(house_prices5$price))),
                                       p("Mean price in $")
                                     )
                                     
                                   ),
                                   flipBox(
                                     id = "myflipbox3",
                                     width = 4,
                                     
                                     front = div(
                                       class = "text-center",
                                       width = 4,
                                       valueBoxOutput("vbox3", width = 12),
                                       
                                     ),
                                     back = div(
                                       class = "text-center",
                                       width= 4,
                                       h3(max(house_prices5$price)),
                                       p("Highest price in $")
                                     )
                                     
                                   ),
                                   flipBox(
                                     id = "myflipbox4",
                                     width = 4,
                                     
                                     front = div(
                                       class = "text-center",
                                       width = 4,
                                       valueBoxOutput("vbox4", width = 12),
                                       
                                     ),
                                     back = div(
                                       class = "text-center",
                                       width= 4,
                                       h3(count(house_prices5)),
                                       p("Houses"),
                                     )
                                     
                                   ),
                                 
                                   
                               
                                valueBoxOutput("vbox5")
                                
                                ),
                               box(title = "Hier benötigen wir noch einen guten Plot!",
                                   
                                   plotOutput("plot1", click = "plot_click")
                                   
                                   
                                   
                                   
                                   )
                               
                        
                                
                        ),
                        
                        # Third tab content
                        #-----------------------------------------------------------------
                        tabItem(tabName = "Prediction",
                                h2("Prediction"),
                                
                                box(width = 3,
                                    h1("Enter your values"),
                                    hr(),
                                  numericInput("sqm_liv", label = h3("sqm_living"), value = 0, min= 1), #sqm_live will be sent to the server
                                  selectizeInput("grade", label = h3("Grade"), 
                                              choices = list("1","2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13"), #grade will be sent to the server
                                              ),
                                  numericInput("bathrooms", label = h3("bathrooms"), value = 0.5, min= 0,5), #bathrooms will be sent to the server
                                  selectizeInput("zipCodePre",label = h3("Zipcode"), #zipCodePre will be sent to the server
                                                 choices= c("98178", "98125","98028", "98136", "98074", "98053", "98003", "98198", "98146" )),
                                 
                                  selectizeInput("yearb", label = h3("Year built"), #yearb will be sent to the server
                                              choices = c("1900-1950","1950-2000", "2000-2021")), 
                                  sliderInput("bedrooms", label = h3("Bedrooms"), min = 0, #bedrooms will be sent to the server
                                              max = 20, value = 4),
                                  sliderInput("floors", label = h3("Floors"), min = 0, #floors will be sent to the server
                                              max = 5, value = 2),
                                  selectizeInput("condition", label = h3("Condition"),#condition will be sent to the server
                                                 choices = c("1","2", "3", "4", "5")),
                                  tippy("Information about condition", tooltip = "1-3: schlecht, 4: beseer, 5: noch besser, 6: noch besser, 7: noch besser, 8: noch bessser, 9: noch besser, 10: noch besser, 11: noch besser, 12: noch besser, 13: noch besser "),
                                  hr(),
                                  selectInput("waterfront", label = h3("Waterfront"), 
                                              choices = list("Yes" = TRUE, "No" = FALSE), #Waterfront will be sent to the server
                                  ),
                                  selectInput("basement", label = h3("Basement"),
                                              choices = list("Yes" = TRUE, "No" = FALSE), #Basement will be sent to the server
                                  ),
                                  selectInput("renovated", label = h3("Renovated"), 
                                              choices = list("Yes" = TRUE, "No" = FALSE), #Renovated will be sent to the server
                                  ),
                                  hr()
                                  
                            
                                ),
                                
                                box(width = 9, 
                                  h1("Predicition"),
                                  hr(),
                                  h3("Check you inputs:"),
                                  #Prediciton is generated from the server 
                                  infoBoxOutput("ibox0"),
                                  infoBoxOutput("ibox1"),
                                  infoBoxOutput("ibox2"),
                                  infoBoxOutput("ibox3"),
                                  infoBoxOutput("ibox4"),
                                  infoBoxOutput("ibox5"),
                                  infoBoxOutput("ibox6"),
                                  infoBoxOutput("ibox7"),
                                  infoBoxOutput("ibox8"),
                                  infoBoxOutput("ibox9"),
                                  infoBoxOutput("ibox10"),
          
                                  
                                  
                                  box(width = 4,
                                    h2()
                                    ),
                                  
                                  box(width = 4,
                                    h2(),
                                    actionButton("action_keks", label = "Predict",
                                                 style = "position: absolute;
                                              top: 45%;
                                              left: 50%;
                                              transform: translate(-50%, -50%);
                                              -ms-transform: translate(-50%, -50%);
                                              background-color: rgba(0, 191, 255);
                                              color: white;
                                              font-size: 16px;
                                              padding: 12px 24px;
                                              border: none;
                                              cursor: pointer;
                                              border-radius: 5px;"
                                                 
                                    )),
                                  
                                  box(width = 4,
                                      h2()
                                      
                                      )
                                  
                                  
                                ),
                                
                                box(width = 9, 
                                    h1("Result of the predicition"),
                                    hr(),
                                    verbatimTextOutput("value")
                                    
                                )
                        ),
                        #End of prediciton------------------------------------------------
                        # Fourth tab content
                        #-----------------------------------------------------------------
                        tabItem(tabName = "Map",
                                h2("Welcome to the Map"),
                                box(width = 2,
                                  selectizeInput("zip","Zipcode", 
                                                 choices= c("98178", "98125","98028", "98136", "98074", "98053", "98003", "98198", "98146" ), 
                                  )
                                  
                                ),
                                
                                box(width = 10,
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
