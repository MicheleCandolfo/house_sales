library(shiny)
library(shinythemes)
library(leaflet)
library(corrplot)
library(ggplot2)
library(dplyr)

house_prices <- read.csv("kc_house_data.csv")
# Define UI for application that draws a histogram
ui <- fluidPage(theme = shinytheme("cyborg"),
                navbarPage(
                    "House Price Predicition",
                    tabPanel("Home", 
                             mainPanel(
                                 img(src = "/house.jpg", height = 900, width = 1350),
                                 
                             ) # mainPanel
                             
                    ),
                    # Navbar 1, tabPanel
                    tabPanel("Predicition", 
                             mainPanel(
                                 h1("Header 1"),
                                 
                                 h4("Output 1"),
                                 verbatimTextOutput("txtout")
                             ) # mainPanel
                             
                    ),
                    tabPanel("Map", 
                             sidebarLayout(
                                 sidebarPanel(
                                     selectizeInput("zip","Zipcode", 
                                                    choices= c("98178", "98125","98028", "98136", "98074", "98053", "98003", "98198", "98146" ), 
                                     )
                                 ),
                                 mainPanel(
                                     leafletOutput("int_map")
                                 )
                                 
                             )
                             
                    )
                )
)
            



# Define server logic required to draw a histogram
server <- function(input, output) {

    output$int_map <- renderLeaflet({
        data <- dplyr::select(house_prices, price, lat, long, zipcode)
        coordinates_data <- subset(data, data$zipcode == input$zip)
        pal = colorNumeric("YlOrRd", domain = coordinates_data$price)
        coordinates_data %>%
            leaflet()%>%
            addProviderTiles(providers$OpenStreetMap.Mapnik)%>%
            addCircleMarkers(col = ~pal(price), opacity = 1.1, radius = 0.3) %>% 
            addLegend(pal = pal, values = ~price)
    })

}

# Run the application 
shinyApp(ui = ui, server = server)
