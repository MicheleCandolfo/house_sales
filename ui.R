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
                      img(src = "/images/house_icon.png",
                          style = "height: auto; width: 180%"))),
                      dashboardSidebar(collapsed = TRUE,
                                     sidebarMenu(id = "tabs",
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
                       
                        
                        #actionButton('prediction', 'Prediction', onclick="location.href='Prediction';",
                                     #style = "position: absolute;
                                              #top: 48%;
                                              #left: 50%;
                                              #transform: translate(-50%, -50%);
                                              #-ms-transform: translate(-50%, -50%);
                                              #background-color: rgba(0, 191, 255,0.5);
                                              #color: white;
                                              #font-size: 16px;
                                              #padding: 12px 24px;
                                              #border: none;
                                              #cursor: pointer;
                                              #border-radius: 5px;"),
                        
                        div( h3("You like to know how much your real estate in King County is worth?"), 
                             h3("You are just one click away from a precise prediction based on AI!"),
                             h3(" "),
                           style = "position: absolute;
                                              top: 18%;
                                              left: 50%;
                                              transform: translate(-50%, -50%);
                                              -ms-transform: translate(-50%, -50%);
                                              background-color: rgba(255, 255, 255,0.45);
                                              color: black;
                                              font-size: 16px;
                                              padding: 10px 10px;
                                              border: none;
                                              cursor: pointer;
                                              border-radius: 5px;
                                              width: 750px;
                                              height: 200;",
                           actionButton('switchtab', 'Prediction',
                                        style = "position: relative;
                                              top: 29%;
                                              left: 45%;
                                              #transform: translate(-50%, -50%);
                                              #-ms-transform: translate(-50%, -50%);
                                              background-color: rgba(0, 191, 255,0.7);
                                              color: white;
                                              font-size: 20px;
                                              padding: 12px 24px;
                                              border: none;
                                              cursor: pointer;
                                              border-radius: 5px;"
                                        
                           )
                           
                           
                           
                           ),
                        #img(src = "/images/giphy.gif",
                          #  style = "position: absolute;
                                              #top: 16.5%;
                                              #left: 10%;
                                              #transform: translate(-50%, -50%);
                                              #-ms-transform: translate(-50%, -50%);
                                              #background-color: rgba(255, 255, 255,0.45);
                                              #color: black;
                                              #font-size: 16px;
                                              #padding: 12px 24px;
                                              #border: none;
                                              #cursor: pointer;
                                              #border-radius: 5px;
                                              #height: 200px;
                                              #width: 300px;                  "),
                        
                        
                      ),
                                
                                
                        # Second tab content
                        #-----------------------------------------------------------------
                        tabItem(tabName = "Dashboard",
                                h2("Welcome to the dashboard"),
                                
                               box(width = 12, 
                                   title= "Facts - Click Me!",
                                
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
                                       p("Total of houses"),
                                     )
                                     
                                   ),
                                   flipBox(
                                     id = "myflipbox5",
                                     width = 4,
                                     
                                     front = div(
                                       class = "text-center",
                                       width = 4,
                                       valueBoxOutput("vbox5", width = 12),
                                       
                                     ),
                                     back = div(
                                       class = "text-center",
                                       width= 4,
                                       h3(round(mean(house_prices5$sqm_living))),
                                       p("Mean square meter (sqm)"),
                                     )
                                     
                                   ), 
                                 
                                   flipBox(
                                     id = "myflipbox6",
                                     width = 4,
                                     
                                     front = div(
                                       class = "text-center",
                                       width = 4,
                                       valueBoxOutput("vbox6", width = 12),
                                       
                                     ),
                                     back = div(
                                       class = "text-center",
                                       width= 4,
                                       h3(round(sum(house_prices5$price)/sum(house_prices5$sqm_living))),
                                       p("$/sqm"),
                                     )
                                     
                                   )
                                ),
                               box(title = "Overview ", 
                                   width = 12, 
                                   selectInput("plotDashboard", label = h3("Please check a variable for the plot"), 
                                               choices = list("Waterfront" = "waterfront", "Renovated" = "renovated", "Year built" = "yearb"), 
                                   ),
                                   plotOutput("plot1", click = "plot_click")
                                 
                               ),
                               
                               
                        ),
                        
                        # Third tab content
                        #-----------------------------------------------------------------
                        tabItem(tabName = "Prediction",

                                box(width = 3, title = h2("Enter values"),
                                  numericInput("sqm_liv", label = h3("Living space (in sqm)"), value = 0, min= 1), #sqm_live will be sent to the server
                                  selectizeInput("grade", label = h3("Building Grade"), 
                                              choices = list("1","2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13"), #grade will be sent to the server
                                              ),
                                  tippy("Information about grade", tooltip = "Index from 1 to 13, with 1-3 representing poor construction and design, 7 representing average construction and design, and 11-13 representing high quality construction and design; You can find more information on the information page"),
                                  numericInput("bathrooms", label = h3("Bathrooms"), value = 0.5, min= 0,5), #bathrooms will be sent to the server
                                  selectizeInput("zipCodePre",label = h3("Zipcode"), #zipCodePre will be sent to the server
                                                 choices= c("98178", "98125","98028", "98136", "98074", "98053", "98003", "98198", "98146", "98038", "98007", "98115", "98126", "98019", "98103", "98002", "98133", "98040", "98092",
                                                            "98030", "98119", "98112", "98052", "98027", "98117", "98058", "98107", "98001", "98056", "98166", "98023", "98070", "98148", "98105", "98042", "98008", "98059", "98122",
                                                            "98144", "98004", "98005", "98034", "98075", "98116","98010", "98118", "98199", "98032", "98045", "98102", "98077", "98108", "98168", "98177", "98065", "98029", "98006",
                                                            "98109", "98022", "98033", "98155", "98024", "98011", "98031", "98106", "98072", "98188", "98014", "98055", "98039" )),
                                 
                                  selectizeInput("yearb", label = h3("Year built"), #yearb will be sent to the server
                                              choices = c("1900-1950","1950-2000", "2000-2021")), 
                                  sliderInput("bedrooms", label = h3("Bedrooms"), min = 0, #bedrooms will be sent to the server
                                              max = 20, value = 4),
                                  sliderInput("floors", label = h3("Floors"), min = 0, #floors will be sent to the server
                                              max = 5, value = 2),
                                  selectizeInput("condition", label = h3("Building Condition"),#condition will be sent to the server
                                                 choices = c("1","2", "3", "4", "5")),
                                  tippy("Information about condition", tooltip = "1: Poor, 2: Fair, 3: Average, 4: Good, 5: Very good;
                                        You can find more information on the information page"),
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
                                
                                box(width = 9, title = h2("Prediction"),
                                  h3("Check your inputs:"),
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
                                  infoBox(title = "Information",subtitle = "Please click the clear button!" ),
                                  actionButton("action_prediction", label = "Predict",
                                                 style = "position: relative;
                                              top: 92%;
                                              left: 88.5%;
                                              #transform: translate(-50%, -50%);
                                              #-ms-transform: translate(-50%, -50%);
                                              background-color: rgba(0, 191, 255);
                                              color: white;
                                              font-size: 16px;
                                              padding: 12px 24px;
                                              border: none;
                                              cursor: pointer;
                                              border-radius: 5px;"
                                                 
                                    ), 
                                  actionButton("clear_prediction", label = "Clear",
                                               style = "position: relative;
                                              top: 92%;
                                              left: 57.5%;
                                              #transform: translate(-50%, -50%);
                                              #-ms-transform: translate(-50%, -50%);
                                              background-color: rgba(0, 191, 255);
                                              color: white;
                                              font-size: 16px;
                                              padding: 12px 24px;
                                              border: none;
                                              cursor: pointer;
                                              border-radius: 5px;"
                                               
                                  )
                                  

                                ),
                                
                                box(width = 9, title = h2("Result of the predicition in $"),
                                    h3(uiOutput("value"))
                                
                                    
                                )
                        ),
                        #End of prediciton------------------------------------------------
                        # Fourth tab content
                        #-----------------------------------------------------------------
                        tabItem(tabName = "Map",
                                

                                box(width = 3, title = h2("Enter values"), 
                                    selectizeInput("grademap", label = h3("Building Grade"), 
                                                  choices = list("1","2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13"), #grade will be sent to the server
                                                  multiple = TRUE,
                                                  selected = list("1","2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13"),
                                                   ),
                                    tippy("Information about grade", tooltip = "Index from 1 to 13, with 1-3 representing poor construction and design, 7 representing average construction and design, and 11-13 representing high quality construction and design; You can find more information on the information page"),
                                    hr(),
                                    selectizeInput("zip", label = h3("Zipcode"), 
                                                 choices= c("98178", "98125","98028", "98136", "98074", "98053", "98003", "98198", "98146", "98038", "98007", "98115", "98126", "98019", "98103", "98002", "98133", "98040", "98092",
                                                            "98030", "98119", "98112", "98052", "98027", "98117", "98058", "98107", "98001", "98056", "98166", "98023", "98070", "98148", "98105", "98042", "98008", "98059", "98122",
                                                            "98144", "98004", "98005", "98034", "98075", "98116","98010", "98118", "98199", "98032", "98045", "98102", "98077", "98108", "98168", "98177", "98065", "98029", "98006",
                                                            "98109", "98022", "98033", "98155", "98024", "98011", "98031", "98106", "98072", "98188", "98014", "98055", "98039" ), 
                                                multiple = TRUE,
                                                selected = c("98178", "98125","98028", "98136", "98074", "98053", "98003", "98198", "98146", "98038", "98007", "98115", "98126", "98019", "98103", "98002", "98133", "98040", "98092",
                                                             "98030", "98119", "98112", "98052", "98027", "98117", "98058", "98107", "98001", "98056", "98166", "98023", "98070", "98148", "98105", "98042", "98008", "98059", "98122",
                                                             "98144", "98004", "98005", "98034", "98075", "98116","98010", "98118", "98199", "98032", "98045", "98102", "98077", "98108", "98168", "98177", "98065", "98029", "98006",
                                                             "98109", "98022", "98033", "98155", "98024", "98011", "98031", "98106", "98072", "98188", "98014", "98055", "98039" ),
                                                 ),
                                  selectizeInput("yearbmap", label = h3("Year built"), #yearb will be sent to the server
                                                choices = c("1900-1950","1950-2000", "2000-2021"), 
                                                multiple = TRUE,
                                                selected = c("1900-1950","1950-2000", "2000-2021")
                                                ),
                                  selectizeInput("conditionmap", label = h3("Building Condition"),#condition will be sent to the server
                                                choices = c("1","2", "3", "4", "5"),
                                                multiple = TRUE,
                                                selected = c("1","2", "3", "4", "5"),
                                                ),
                                  tippy("Information about condition", tooltip = "1: Poor, 2: Fair, 3: Average, 4: Good, 5: Very good;
                                        You can find more information on the information page"),
                                  hr(),
                                  selectInput("waterfrontmap", label = h3("Waterfront"), 
                                              choices = list("Yes" = 1, "No" = 0), #Waterfront will be sent to the server
                                              multiple = TRUE,
                                              selected = list("Yes" = 1, "No" = 0)
                                  ),
                                  selectInput("basementmap", label = h3("Basement"),
                                              choices = list("Yes" = 1, "No" = 0), #Basement will be sent to the server
                                              multiple = TRUE,
                                              selected = list("Yes" = 1, "No" = 0)
                                              ),
                                  selectInput("renovatedmap", label = h3("Renovated"), 
                                              choices = list("Yes" = 1, "No" = 0), #Renovated will be sent to the server
                                              multiple = TRUE,
                                              selected = list("Yes" = 1, "No" = 0)
                                              ),
                                  hr()
                                ),
                                
                                
                                box(width = 9, title = h2("Welcome to the map"), 
                                  leafletOutput("int_map")
                                  
                                )
                        ),
                        # Fifth tab content
                        #-----------------------------------------------------------------
                        tabItem(tabName = "About",
                                box(title = "About the project", width = 12, collapsible = TRUE, collapsed = TRUE,
                                    p("This project involves building a Shiny Web application in RStudio as part of a project work in the Master's programme at Aalen University."),
                                    p("The Shiny Web Application is basically about house price estimation/prediction based on house sales in King County, USA. We will use the programming language R and a specific data set from Kaggle.com. We also will use a machine learning algorithm (Random Forest) for the predicition.")),
                                box(title = "About the data set", width = 12, collapsible = TRUE, collapsed = TRUE,
                                    p("The dataset consists of house prices from King County an area in the US State of Washington, this data also covers Seattle. The dataset was obtained from Kaggle. This data was published/released under CC0: Public Domain. Unfortunately, the user has not indicated the source of the data."),
                                    p("The dataset consisted of 21 variables and 21613 observations."), 
                                    p("Due to the “Grade” variable which is based on a grading system specific to King County, it seems likely that the data originated from an official source. On the other hand, the existence of the “View” variable relates to the number of viewings the property received. This suggests that the data originated from a real estate agent/company."),
                                    p("In either case, there is no reason to call into question the general accuracy of the data because values such as prices, area etc. do not appear random. Nevertheless, some caution is appropriate before applying models trained on this data to more general cases."),
                                    p("The dataset consisted of historic data of houses sold between May 2014 to May 2015.")),
                                box(title = "Column description", width = 12, collapsible = TRUE, collapsed = TRUE,
                                    p("id - Unique ID for each home sold"),
                                    p("date - Date of the home sale"),
                                    p("price - Price of each home sold"),
                                    p("bedrooms - Number of bedrooms"),
                                    p("bathrooms - Number of bathrooms, where .5 accounts for a room with a toilet but no shower"),
                                    p("sqft_living - Square footage of the apartments interior living space"),
                                    p("sqft_lot - Square footage of the land space"),
                                    p("floors - Number of floors"),
                                    p("waterfront - A dummy variable for whether the apartment was overlooking the waterfront or not"),
                                    p("view - An index from 0 to 4 of how good the view of the property was"),
                                    p("condition - An index from 1 to 5 on the condition of the apartment,"),
                                    p("grade - An index from 1 to 13, where 1-3 falls short of building construction and design, 7 has an average level of construction and design, and 11-13 have a high quality level of construction and design"),
                                    p("sqft_above - The square footage of the interior housing space that is above ground level"),
                                    p("sqft_basement - The square footage of the interior housing space that is below ground level"),
                                    p("yr_built - The year the house was initially built"),
                                    p("yr_renovated - The year of the house's last renovation"),
                                    p("zipcode - What zipcode area the house is in"),
                                    p("lat - Lattitude"),
                                    p("long - Longitude"),
                                    p("sqft_living15 - The square footage of interior housing living space for the nearest 15 neighbors"),
                                    p("sqft_lot15 - The square footage of the land lots of the nearest 15 neighbors")),
                                
                                box(title = "Details about building grade and building condition", width = 12, collapsible = TRUE, collapsed = TRUE,
                                    p("Building grade"),
                                    p("1-3: Falls short of minimum building standards. Normally cabin or inferior structure. "),
                                    p("4: Generally older, low quality construction. Does not meet code."),
                                    p("5: Low construction costs and workmanship. Small, simple design."),
                                    p("6: Lowest grade currently meeting building code. Low quality materials and simple designs."),
                                    p("7: Average grade of construction and design. Commonly seen in plats and older sub-divisions."),
                                    p("8: Just above average in construction and design. Usually better materials in both the exterior and interior finish work."),
                                    p("9: Better architectural design with extra interior and exterior design and quality."),
                                    p("10: Homes of this quality generally have high quality features. Finish work is better and more design quality is seen in the floor plans. Generally have a larger square footage."),
                                    p("11: Custom design and higher quality finish work with added amenities of solid woods, bathroom fixtures and more luxurious options. "),
                                    p("12: Custom design and excellent builders. All materials are of the highest quality and all conveniences are present "),
                                    p("13: Generally custom designed and built. Mansion level. Large amount of highest quality cabinet work, wood trim, marble, entry ways etc. "),
                                    hr(),
                                    p("Building condition"), 
                                    p("1: Poor- Worn out. Repair and overhaul needed on painted surfaces, roofing, plumbing, heating and numerous functional inadequacies. Excessive deferred maintenance and abuse, limited value-in-use, approaching abandonment or major reconstruction; reuse or change in occupancy is imminent. Effective age is near the end of the scale regardless of the actual chronological age. "),
                                    p("2: Fair- Badly worn. Much repair needed. Many items need refinishing or overhauling, deferred maintenance obvious, inadequate building utility and systems all shortening the life expectancy and increasing the effective age."),
                                    p("3: Average- Some evidence of deferred maintenance and normal obsolescence with age in that a few minor repairs are needed, along with some refinishing. All major components still functional and contributing toward an extended life expectancy. Effective age and utility is standard for like properties of its class and usage."),
                                    p("4: Good- No obvious maintenance required but neither is everything new. Appearance and utility are above the standard and the overall effective age will be lower than the typical property."),
                                    p("5: Very Good- All items well maintained, many having been overhauled and repaired as they have shown signs of wear, increasing the life expectancy and lowering the effective age with little deterioration or obsolescence evident with a high degree of utility. ")
                              
                                    ),
                                
                                box(title = "General information", width = 12, collapsible = TRUE, collapsed = TRUE,
                                    p("On the dashboard page you will find key facts about the data set as well as a visualised overview of the sales prices based on the most relevant parameters."),
                                    p("In the Prediction section, you will receive a prediction of how much your real estate is worth in King County based on your input. To do this, enter all the relevant information about your real estate and let the system calculate the value for you."),
                                    p("Do you want to find out at a glance what the house prices are like in individual regions in King County? Then our Map is the right place for you!"),
                                    p("Our About page describes our project, the data used and introduces our project team.")),
                                box(title = "About the algorithm", width = 12, collapsible = TRUE, collapsed = TRUE,
                                    p("For the price prediction we used the machine learning method Random Forest. We used training and test data for this. The performance of our prediction is around 83%. We evaluated the following variables as relevant for the prediction:")),
                                box(title = "About data preparation", width = 12, collapsible = TRUE, collapsed = TRUE,
                                    p("Bedrooms records with zero values are removed. Record with the number of 33 bedrooms is adjusted to 3 bedrooms as we assume this is a typo."),
                                    p("Columns as factor"),
                                    p("Add two columns (basement & renovated)"),
                                    p("Outliers are removed.  --> price > 6 mio; --> sqft_living > 10,000"),
                                    p("Convert SQFT to SQM with factor * 0.092903, as this number is more meaningful for us. The SQFT columns are replaced by the SQM columns accordingly."),
                                    p("Feature tuning.")),
                                box(title = "About the team - Who we are?", width = 12, collapsible = TRUE, collapsed = FALSE,
                                    p("Our great team consists of 3 people."),
                                    p("We are all students at Aalen University in the first semester of the part-time Master of Science. We have all completed our Bachelor of Science at the Cooperative State University Baden-Württemberg in Business Informatics."),
                                    box(title = h3("Leandra Sommer", align="center"), align="center", width = 4, img(class="img-circle", src="/images/lele.jpg", alt="", width = 200),
                                        br(""),
                                        p("Works for CDA IT Systems as a test manager and project manager in the area of postal logistics. Has been studying for a master's degree in business informatics at Aalen University since September 2021.")),
                                    box(title = h3("Michele Candolfo", align="center"), align="center", width = 4, img(class="img-circle", src="/images/michele.JPG", alt="", width = 200),
                                        br(""),
                                        p("Works for TestGilde GmbH as a technical lead for test automation. Has been studying for a master's degree in business informatics at Aalen University since September 2021. ")),
                                    box(title = h3("Patrick Kurz", align="center"), align="center",  width = 4, img(class="img-circle", src="/images/patrick.png", alt="", width = 200), 
                                        br(""),
                                        p("The team's project manager with a professional background in the banking industry. Mainly works for Mercedes-Benz AG as a product owner for digital services. Has been studying for a Master's degree in Data Science & Business Analytics at Aalen University since September 2021."))
                                   
                                    


                                    ),
                      
                                
                      )
                    )
))
