
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
