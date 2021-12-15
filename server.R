#install all required modules 
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
                             "randomForest",
                             "caret",
                             "caTools", 
                             "yaml"
))


server <- function(input, output, session) {
    
    
    #Load the data 
    house_prices <- read.csv("kc_house_data.csv")
    
    #Data preparation 
    # bedrooms DS mit Null-Werten rauswerfen und DS ändern 33 zu 3 Schlafzimmer
    house_prices2 <- house_prices
    house_prices2[house_prices2$id==2402100895, "bedrooms"] <- 3
    house_prices3<-house_prices2[!(house_prices2$bedrooms==0 | house_prices2$bathrooms==0),]
    
    #Spalten As Factor
    house_prices3$floors <- as.factor(house_prices3$floors)
    house_prices3$waterfront <- as.factor(house_prices3$waterfront)
    house_prices3$grade <- as.factor(house_prices3$grade)
    house_prices3$condition <- as.factor(house_prices3$condition)
    #house_prices3$zipcode <- as.factor(house_prices3$zipcode)
    
    #Hinzufügen von zwei Spalten (boolean) (basement und renovated)
    house_prices3$basement <- as.factor(ifelse(house_prices3$sqft_basement>0,1,0))
    house_prices3$renovated <- as.factor(ifelse(house_prices3$yr_renovated>0,1,0))
    
    # Ausreisser entfernen 
    house_prices4 = subset(house_prices3,!(house_prices3$price > 6000000))
    house_prices4 = subset(house_prices4,!(house_prices4$sqft_living > 10000))
    
    #sqft --> sqm
    qm <- 0.092903
    house_prices4$sqm_living <- round(house_prices4$sqft_living *qm)
    
    house_prices4$sqm_lot <- round(house_prices4$sqft_lot *qm)
    
    house_prices4$sqm_lot15 <- round(house_prices4$sqft_lot15 *qm)
    
    house_prices4$sqm_living15 <- round(house_prices4$sqft_living15 *qm)
    
    house_prices4$sqm_above <- round(house_prices4$sqft_above *qm)
    
    house_prices4$sqm_basement <- round(house_prices4$sqft_basement *qm)
    
    #drop sqft columns
    house_prices4[,c("sqft_living","sqft_lot","sqft_above","sqft_basement","sqft_lot15","sqft_living15")] <- list(NULL)
    
    #Feature tuning 
    house_prices4$yearb<-cut(house_prices4$yr_built,c(1900,1950,2000,2020))
    house_prices4$yearb<-factor(house_prices4$yearb,levels = c("(1.9e+03,1.95e+03]","(1.95e+03,2e+03]","(2e+03,2.02e+03]"),labels = c("1900-1950","1950-2000","2000-2020"))
    house_prices4<-house_prices4 %>% filter(!is.na(yearb))
    
    #End of data preparation--------------------------------------------------------------------------------
    
    #Start of modeling 
    
    #Choosing features
    house_prices5=house_prices4[,c("price","bedrooms","bathrooms","waterfront","condition","grade", "sqm_living", "basement","renovated", "zipcode", "yearb", "floors")]
    
    #Data split in train and test set 
    set.seed(5) 
    sample <- sample.split(house_prices4, SplitRatio = .80)
    train <- subset(house_prices5, sample == TRUE)
    test  <- subset(house_prices5, sample == FALSE)
    
    #Train the model 
    
    #model=randomForest(price~.,train)
    #write_yaml(model, "my_model.yml")
    #model
    
    #-> Hier müssen dann die input values von den User hinzugefügt werden
    #predict(model, data.frame(train_x = c(1, 2, 3)))
    
    #input_user <- c(input$bedrooms,input$yearb, input$zipCodePre, input$bathrooms, input$grade, input$sqm_liv, input$zip, input$renovated, input$basement, input$waterfront)
    #print(input_user)
    
    #predict=predict(model,test[,-1])
    #postResample(test$price,predict)
    
    #importance(model)
    #varImpPlot(model,type=2)
    
    #End of modeling-----------------------------------------------------------------------------------------
    
    #Checking if the data is correct and displayed!
    #View(house_prices5)
    
  
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
    
    #Dashboard page value boxes--------------------------------------------------------
    
    output$vbox1 <- renderValueBox({
      valueBox(
        "Lowest Price",
        min(house_prices5$price),
        icon = icon("dollar-sign")
      )
    })
    
    output$vbox2 <- renderValueBox({
      valueBox(
        "Mean Price",
        round(mean(house_prices5$price)),
        icon = icon("dollar-sign")
      )
    })
    
    output$vbox3 <- renderValueBox({
      valueBox(
        "Highest Price",
        max(house_prices5$price),
        icon = icon("dollar-sign")
      )
    })
    
    output$vbox4 <- renderValueBox({
      valueBox(
        "Amount of Houses",
        count(house_prices5),
        icon = icon("file-csv")
      )
    })
    
    output$vbox5 <- renderValueBox({
      valueBox(
        "Mean QM",
        round(mean(house_prices5$sqm_living)),
        icon = icon("square")
      )
    })
    
    sum_prices <- sum(house_prices5$price)
    sum_qm <- sum(house_prices5$sqm_living)
    
    price_qm <- (sum_prices/sum_qm)
    
    output$vbox5 <- renderValueBox({
      valueBox(
        "$/QM",
        round(price_qm),
        icon = icon("dollar-sign")
      )
    })
    
    #Plot for dashboard
    
    output$plot1 <- renderPlot({
      plot(house_prices3$yr_built, house_prices3$price, xlab="Year", ylab="Price", main="Price Development")
    })
    
    
    
    #Prediciton page info boxes---------------------------------------------------------
    output$ibox0 <- renderInfoBox({
      infoBox(
        "Sqm living",
        input$sqm_liv,
        icon = icon("credit-card")
      )
    })
    
    output$ibox1 <- renderInfoBox({
      infoBox(
        "Grade",
        input$grade,
        icon = icon("credit-card")
      )
    })
    
    output$ibox2 <- renderInfoBox({
      infoBox(
        "Bathrooms",
        input$bathrooms,
        icon = icon("credit-card")
      )
    })
    
    output$ibox3 <- renderInfoBox({
      infoBox(
        "Zip Code",
        input$zipCodePre,
        icon = icon("credit-card")
      )
    })
    
    output$ibox4 <- renderInfoBox({
      infoBox(
        "Year Built",
        input$yearb,
        icon = icon("credit-card")
      )
    })
    
    output$ibox5 <- renderInfoBox({
      infoBox(
        "Bedrooms",
        input$bedrooms,
        icon = icon("credit-card")
      )
    })
    
    output$ibox6 <- renderInfoBox({
      infoBox(
        "Floors",
        input$floors,
        icon = icon("credit-card")
      )
    })
    
    output$ibox7 <- renderInfoBox({
      infoBox(
        "Condition",
        input$condition,
        icon = icon("credit-card")
      )
    })
    
    output$ibox8 <- renderInfoBox({
      infoBox(
        "Waterfront",
        input$waterfront,
        icon = icon("credit-card")
      )
    })
    
    output$ibox9 <- renderInfoBox({
      infoBox(
        "Basement",
        input$basement, 
        icon = icon("credit-card")
      )
    })
    output$ibox10 <- renderInfoBox({
      infoBox(
        "Renovated",
        input$renovated,
        icon = icon("credit-card")
      )
    })
    
    #End of infoboxes-----------------------------------
    #View(house_prices3)
  

    
  
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
