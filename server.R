
server <- function(input, output, session) {
    
    
    #Load the data 
    house_prices <- read.csv("kc_house_data.csv")
    
    #Action button on the landing page 
    #observeEvent(input$keks, {
     # open(tabItem="Prediction")
    #})

  
    #output$value <- renderPrint({ input$num }) sqm_living
    #output$value <- renderPrint({ input$select }) grade
    #output$value <- renderPrint({ input$bathrooms }) bathrooms
    #output$value <- renderPrint({ input$select }) zipcode
    #output$value <- renderPrint({ input$select }) yearb
    #output$value <- renderPrint({ input$slider1 }) bedrooms
    #output$value <- renderPrint({ input$slider1 }) floors

    
  
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
