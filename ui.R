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
                                   includeCSS("www/style.css"),
                      # Add pages
                      #-----------------------------------------------------------------
                      tabItems(
                        # First tab content
                        #-----------------------------------------------------------------
                        tabItem(tabName = "Home", style = "border: none",
                              
                        img(src = "/images/house.jpg", 
                            style = "height: auto; width: 100%; border: none; border-radius: 5px", 
                        ),
                        
                        div( h3("Do you want to know how much your King County real estate is worth based on AI?"), 
                             h3("You are just one click away!"),
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
                                              width: 500px;
                                              height: 205px;
                                              text-align: center;",
                           actionButton('switchtab', 'Prediction',
                                        style = "position: relative;
                                              background-color: rgba(0, 191, 255,0.7);
                                              color: white;
                                              font-size: 20px;
                                              padding: 12px 24px;
                                              border: none;
                                              cursor: pointer;
                                              border-radius: 5px;"
                              )
                           ),
                      ),
                                
                        # Second tab content
                        #-----------------------------------------------------------------
                        tabItem(tabName = "Dashboard",
                                
                               box(width = 12, 
                                   title= p("Facts - click me!", style = "font-size:30px;"),
                                
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
                                         p("Lowest price in $")
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
                               box(title = p("Overview", style = "font-size:30px;"), 
                                   width = 12, 
                                   selectInput("plotDashboard", label = h3("Please check a variable for the plot:"), 
                                               choices = list("Waterfront" = "waterfront", "Renovated" = "renovated", "Year built" = "yearb"), 
                                   ),
                                   plotOutput("plot1", click = "plot_click")
                                 
                               ),
                               
                        ),
                        
                        # Third tab content
                        #-----------------------------------------------------------------
                        tabItem(tabName = "Prediction",

                                box(width = 3, title =p("Enter values", style = "font-size:30px;"),
                                  numericInput("sqm_liv", label = h3("Living space (in sqm)"), value = 0, min= 1), #sqm_live will be sent to the server
                                  selectizeInput("grade", label = h3("Building grade"), 
                                              choices = list("1","2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13"), #grade will be sent to the server
                                              ),
                                  tippy("Information about grade", tooltip = "Index from 1 to 13, with 1-3 representing poor construction and design, 7 representing average construction and design, and 11-13 representing high quality construction and design; You can find more information on the information page"),
                                  numericInput("bathrooms", label = h3("Bathrooms"), value = 0.5, min= 0,5), #bathrooms will be sent to the server
                                  selectizeInput("zipCodePre",label = h3("ZIP Code"), #zipCodePre will be sent to the server
                                                 choices= c("98178", "98125","98028", "98136", "98074", "98053", "98003", "98198", "98146", "98038", "98007", "98115", "98126", "98019", "98103", "98002", "98133", "98040", "98092",
                                                            "98030", "98119", "98112", "98052", "98027", "98117", "98058", "98107", "98001", "98056", "98166", "98023", "98070", "98148", "98105", "98042", "98008", "98059", "98122",
                                                            "98144", "98004", "98005", "98034", "98075", "98116","98010", "98118", "98199", "98032", "98045", "98102", "98077", "98108", "98168", "98177", "98065", "98029", "98006",
                                                            "98109", "98022", "98033", "98155", "98024", "98011", "98031", "98106", "98072", "98188", "98014", "98055", "98039" )),
                                 
                                  selectizeInput("yearb", label = h3("Year built"), #yearb will be sent to the server
                                              choices = c("1900-1950","1950-2000", "2000-2021")), 
                                  sliderInput("bedrooms", label = h3("Bedrooms"), min = 0, #bedrooms will be sent to the server
                                              max = 10, value = 4),
                                  sliderInput("floors", label = h3("Floors"), min = 0, #floors will be sent to the server
                                              max = 4, value = 2),
                                  selectizeInput("condition", label = h3("Building condition"),#condition will be sent to the server
                                                 choices = c("1","2", "3", "4", "5")),
                                  tippy("Information about condition", tooltip = "1: Poor, 2: Fair, 3: Average, 4: Good, 5: Very good;
                                        You can find more information on the information page"),
                                  
                                  selectInput("waterfront", label = h3("Waterfront"), 
                                              choices = list("Yes" = 1, "No" = 0), #Waterfront will be sent to the server
                                  ),
                                  selectInput("basement", label = h3("Basement"),
                                              choices = list("Yes" = 1, "No" = 0), #Basement will be sent to the server
                                  ),
                                  selectInput("renovated", label = h3("Renovated"), 
                                              choices = list("Yes" = 1, "No" = 0), #Renovated will be sent to the server
                                  )
                                
                                ),
                                
                                box(width = 9, title =p("Prediction", style = "font-size:30px;"),
                                  h3("Check your inputs:"),
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
                                  infoBox(title = "Information",subtitle = "Please click the clear button before making a new prediction!" ),
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
                                
                                box(width = 9, title = p("Result of the predicition in $", style = "font-size:30px;"),
                                    h3(textOutput("text"))
                                )
                        ),
                        # Fourth tab content
                        #-----------------------------------------------------------------
                        tabItem(tabName = "Map",
                                box(width = 12, title =p("Enter values", style = "font-size:30px;"), 
                                    actionButton("all", "All"),
                                    actionButton("zipcodeMap", "ZIP Code"),
                                    selectizeInput("zip", label = h3("ZIP Code"), 
                                                   choices= c("98178", "98125","98028", "98136", "98074", "98053", "98003", "98198", "98146", "98038", "98007", "98115", "98126", "98019", "98103", "98002", "98133", "98040", "98092",
                                                              "98030", "98119", "98112", "98052", "98027", "98117", "98058", "98107", "98001", "98056", "98166", "98023", "98070", "98148", "98105", "98042", "98008", "98059", "98122",
                                                              "98144", "98004", "98005", "98034", "98075", "98116","98010", "98118", "98199", "98032", "98045", "98102", "98077", "98108", "98168", "98177", "98065", "98029", "98006",
                                                              "98109", "98022", "98033", "98155", "98024", "98011", "98031", "98106", "98072", "98188", "98014", "98055", "98039" ), 
                                                   multiple = TRUE
                                                   
                                    ), 
                                    p("Please choose a ZIP Code. It is possible to select multiple ZIP Codes.")
          
                                ),
                                
                                box(width = 12, title = p("Welcome to the map", style = "font-size:30px;"), 
                                
                                div(id= "marker-cluster",
                                    leafletOutput("int_map")
                                  )
                                )
                        ),
                        # Fifth tab content
                        #-----------------------------------------------------------------
                        tabItem(tabName = "About",
                                box(title = "About the project", width = 12, collapsible = TRUE, collapsed = TRUE,
                                    p("This project involves building a Shiny Web application in RStudio as part of a project work in the Master's programme at Aalen University."),
                                    p("The Shiny Web Application is basically about house price estimation/prediction based on house sales in King County, USA."),
                                    p("We will use the programming language R and a specific data set from Kaggle.com."),
                                    p("We also will use a machine learning algorithm (Random Forest) for the predicition.")),
                                box(title = "About the data set", width = 12, collapsible = TRUE, collapsed = TRUE,
                                    p("The dataset consists of house prices from King County an area in the US State of Washington, this data also covers Seattle."),
                                    p("It includes homes that sold between May 2014 and May 2015."), 
                                    p("There are a total of 21 columns in the selected dataset with 21613."),
                                    p("There are no missing data."),
                                    br(),
                                    p("The dataset was obtained from Kaggle:"),
                                    p(a("https://www.kaggle.com/harlfoxem/housesalesprediction",href="https://www.kaggle.com/harlfoxem/housesalesprediction")),
                                    p("This data was published and released under CC0: Public Domain."),
                                    p("Unfortunately, the user did not indicate the source of the data."),
                                    br(),
                                    p("Based on the 'Grade' variable, which is based on a grading system specific to King County, it is likely that the data came from an official source."),
                                    p("On the other hand, the 'View' variable refers to the number of viewings the property received. "),
                                    p("This suggests that the data came from a real estate agent/property firm."),
                                    br(),
                                    p("In any case, there is no reason to question the overall accuracy of the data, as values such as prices, area, etc. do not appear random."),
                                    p("Nevertheless, some caution is warranted before applying models trained on this data to more general cases.")),
                                box(title = "Column description", width = 12, collapsible = TRUE, collapsed = TRUE,
                                    p("Columns of the data set"),
                                    p("id - Unique ID for each home sold"),
                                    p("date - Date of the home sale"),
                                    p("price - Price of each home sold"),
                                    p("bedrooms - Number of bedrooms"),
                                    p("bathrooms - Number of bathrooms, where .5 accounts for a room with a toilet but no shower"),
                                    p("sqft_living - Square footage of the apartments interior living space"),
                                    p("sqft_lot - Square footage of the land space"),
                                    p("floors - Number of floors"),
                                    p("waterfront - A dummy variable for whether the apartment was overlooking the waterfront or not"),
                                    p("view - An index from 0 to 4, which indicates how often the property was visited"),
                                    p("condition - An index from 1 to 5 on the condition of the apartment"),
                                    p("grade - An index from 1 to 13, where 1-3 falls short of building construction and design, 7 has an average level of construction and design, and 11-13 have a high quality level of construction and design"),
                                    p("sqft_above - The square footage of the interior housing space that is above ground level"),
                                    p("sqft_basement - The square footage of the interior housing space that is below ground level"),
                                    p("yr_built - The year the house was initially built"),
                                    p("yr_renovated - The year of the house's last renovation"),
                                    p("ZIP Code - What ZIP Code area the house is in"),
                                    p("lat - Lattitude"),
                                    p("long - Longitude"),
                                    p("sqft_living15 - The square footage of interior housing living space for the nearest 15 neighbors"),
                                    p("sqft_lot15 - The square footage of the land lots of the nearest 15 neighbors"),
                                    hr(), 
                                    p("Added columns"),
                                    p("basement - Boolean Yes or No"),
                                    p("renovated - Boolean Yes or No"),
                                    p("yearb - Time period the house was built, levels: 1900-1950, 1950-2000, 2000-2021")),
                              
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
                                    p("For the price prediction we used the Random Forest machine learning method."),
                                    p("The Random Forest is a classification algorithm that consists of many decision trees."),
                                    p("It uses bagging and random features in the creation of each tree to create an uncorrelated forest of trees whose prediction by committee is more accurate than that of a single tree."),
                                    br(),
                                    p("To implement the random forest method in our project, we used the package 'ranger'."), 
                                    p("This package provides a fast implementation of random forests that is particularly suitable for high-dimensional data"), 
                                    p("So it is very suitable for our project and the performance is quite good."),
                                    br(),
                                    p("First, we split the dataset into training (80%) and test (20%) data"),
                                    p("With the training data, the model was trained with 500 decision trees."),
                                    p("This uses 10 variables that are randomly selected as candidates at each split."),
                                    p("We then predicted the price of the houses from the test data set and compared the predicted values with the actual values."),
                                    p("This allowed us to check whether our prediction succeeded."),
                                    p("The performance of our prediction is about 83%."),
                                    br(),
                                    p("We evaluated the following variables as relevant to the prediction: price, bedrooms, bathrooms, waterfront, condition, class, square feet of living space, basement, renovated, zip code, yearb and floors.")),
                                    
                                box(title = "About data preparation", width = 12, collapsible = TRUE, collapsed = TRUE,
                                    p("During data preparation, all data records which had a zero value for the Bedrooms column were removed."),
                                    p("Additionally, in one data set, the number of bedrooms was corrected from 33 to 3, as we assume this was a mistyping."),
                                    p("The next step was to convert the following columns into factors: floors, waterfront, grade and condition."),
                                    br(),
                                    p("We then added two additional columns containing Boolean values (renovated and basement)."),
                                    p("After that, we added another column with the period when the house was built as a factor (yearb)."),
                                    p("The outliers were removed from our data set."),
                                    p("Therefore, all records were eliminated where the price is higher than 6 million dollars or the sqf_living is higher than 10000."),
                                    br(),
                                    p("Our data is in square feet."),
                                    p("We converted them to square meters by a factor of 0.092903 and rounded, as this number is more useful to us."),
                                    p("The sqft columns are replaced accordingly with the sqm columns.")                                    ),
                                
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
                                        p("Works for Mercedes-Benz AG as a product owner for digital services. Has been studying for a Master's degree in Data Science & Business Analytics at Aalen University since September 2021."))
                                   
                                    
                                    ),
                      
                                
                            )
                    )
))
