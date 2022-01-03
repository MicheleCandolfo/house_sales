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
                             "yaml", 
                             "ranger", 
                             "lubridate", 
                             "ggdark"
                             
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

    house_prices4<-house_prices4 %>% 
      mutate(id=as.factor(id)) %>% 
      mutate(Date=str_replace_all(house_prices4$date,"T0{1,}","")) %>% 
      select(Date,everything(),-date,-id)
    house_prices4<-house_prices4 %>% 
      mutate(Date=ymd(Date)) %>% 
      separate(Date,c("Year","Month","Day"))
    
    
    #End of data preparation--------------------------------------------------------------------------------
    
    #Start of modeling 
    
    
    #Choosing features
    house_prices5=house_prices4[,c("price","bedrooms","bathrooms","waterfront","condition","grade", "sqm_living", "basement","renovated", "zipcode", "yearb", "floors")]
    
    #Data split in train and test set 
    set.seed(5) 
    sample <- sample.split(house_prices4, SplitRatio = .80)
    train <- subset(house_prices5, sample == TRUE)
    test  <- subset(house_prices5, sample == FALSE)
    
    model <- ranger(
      formula         = price ~ ., 
      data            = train, 
      num.trees       = 500,
      mtry            = 10
    )
    testTest <- predict(
      model,
      data = test,
      predict.all = FALSE,
      num.trees = model$num.trees,
      type = "response",
      se.method = "infjack",
      verbose = TRUE,
    )
    
    #modelOutput<- data.frame(obs = test$price, pred = testTest$predictions)
   #print(modelOutput )
    #Train the model 
    
    #model=randomForest(price~.,train)
    #write_yaml(model, "my_model.yml")
    #model
    
    #-> Hier müssen dann die input values von den User hinzugefügt werden
    #predict(model, data.frame(train_x = c(1, 2, 3)))
    
   
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
        ""
      )
    })
    
    output$vbox2 <- renderValueBox({
      valueBox(
        "Mean Price",
        ""
      )
    })
    
    output$vbox3 <- renderValueBox({
      valueBox(
        "Highest Price",
        ""
      )
    })
    
    output$vbox4 <- renderValueBox({
      valueBox(
        "Total of houses",
        ""
      )
    })
    
    output$vbox5 <- renderValueBox({
      valueBox(
        "Mean sqm",
        ""
      )
    })
    
    sum_prices <- sum(house_prices5$price)
    sum_qm <- sum(house_prices5$sqm_living)
    
    price_qm <- (sum_prices/sum_qm)
    
    output$vbox6 <- renderValueBox({
      valueBox(
        "$/sqm",
        ""
      )
    })
    
    #Plot for dashboard
    waterfrontValues <- list(
      '0'="No Waterfront",
      '1'="Waterfront"
    )
    
      
      waterfront_labeller <- function(variable,value){
        return(waterfrontValues[value])
      }
      renovatedValues <- list(
        '0'="Not renovated",
        '1'="Renovated"
      )
      
      
      renovated_labeller <- function(variable,value){
        return(renovatedValues[value])
      }

  
    output$plot1 <- renderPlot({
      if (input$plotDashboard == "waterfront") {
        house_prices4 %>%
          ggplot( aes(x=sqm_living, y=price, group=waterfront, color=waterfront)) +
          geom_point()+
          facet_wrap( ~ waterfront, labeller = waterfront_labeller)+
          scale_y_continuous(labels = scales::dollar)+
          xlab("Living space in square meter")+
          ylab("Price")+
          # theme_classic()+
          dark_theme_gray(base_size = 18)+
          theme(legend.position="none", strip.text.x = element_text(size = 16))
      } else if (input$plotDashboard == "renovated") {
        house_prices4 %>%
          ggplot( aes(x=sqm_living, y=price, group=renovated, color=renovated)) +
          geom_point()+
          facet_wrap( ~ renovated, labeller = renovated_labeller)+
          scale_y_continuous(labels = scales::dollar)+
          xlab("Living space in square meter")+
          ylab("Price")+
          dark_theme_gray(base_size = 18)+
          theme(legend.position="none", strip.text.x = element_text(size = 16))
      } else {
        house_prices4 %>%
          ggplot( aes(x=sqm_living, y=price, group=yearb, color=yearb)) +
          geom_point()+
          facet_wrap( ~ yearb)+
          scale_y_continuous(labels = scales::dollar)+
          xlab("Living space in square meter")+
          ylab("Price")+
          dark_theme_gray(base_size = 18)+
          theme(legend.position="none", strip.text.x = element_text(size = 16))
      }
      })
    
    #Button landingpage-----------------------
    observeEvent(input$switchtab, {
      newtab <- switch(input$tabs,
                       "Home" = "Prediction",
                       "Prediction" = "Home"
      )
      updateTabItems(session, "tabs", newtab)
    })
    
    #End button landingpage-------------------
      
     
    
  
    
  #Prediciton page info boxes---------------------------------------------------------
    start_prediction <- observeEvent(input$action_predictions,{
      
      
    })
    observeEvent(input$action_prediction,{
    output$value <- renderUI({ 
      bedrooms <- input$bedrooms
      bathrooms <- input$bathrooms
      waterfront <- input$waterfront
      condition <- input$condition
      grade <- input$grade
      sqm_living <- input$sqm_liv
      basement <- input$basement
      renovated <- input$renovated
      zipcode<- input$zipCodePre
      yearb <-input$yearb
      floors <-input$floors
      input_user <- data.frame(bedrooms, bathrooms, waterfront, condition, grade, sqm_living, basement, renovated, zipcode, yearb, floors )
      userPrediction <- predict(
      model,
      data = input_user,
      predict.all = FALSE,
      num.trees = model$num.trees,
      type = "response",
      se.method = "infjack",
      verbose = TRUE,
    )
    round(userPrediction$predictions)
    })
    })
    observeEvent(input$clear_prediction,{
      output$value <- renderUI({ 
      
        0
      })
    })
    
    output$ibox0 <- renderInfoBox({
      infoBox(
        "Living space",
        input$sqm_liv,
        icon = icon("home")
      )
    })
    
    output$ibox1 <- renderInfoBox({
      infoBox(
        "Grade",
        input$grade,
        icon = icon("check-circle")
      )
    })
    
    output$ibox2 <- renderInfoBox({
      infoBox(
        "Bathrooms",
        input$bathrooms,
        icon = icon("toilet")
      )
    })
    
    output$ibox3 <- renderInfoBox({
      infoBox(
        "Zip Code",
        input$zipCodePre,
        icon = icon("map")
      )
    })
    
    output$ibox4 <- renderInfoBox({
      infoBox(
        "Year Built",
        input$yearb,
        icon = icon("building")
      )
    })
    
    output$ibox5 <- renderInfoBox({
      infoBox(
        "Bedrooms",
        input$bedrooms,
        icon = icon("bed")
      )
    })
    
    output$ibox6 <- renderInfoBox({
      infoBox(
        "Floors",
        input$floors,
        icon = icon("arrow-alt-circle-up")
      )
    })
    
    output$ibox7 <- renderInfoBox({
      infoBox(
        "Condition",
        input$condition,
        icon = icon("balance-scale")
      )
    })
    
    output$ibox8 <- renderInfoBox({
      infoBox(
        "Waterfront",
        input$waterfront,
        icon = icon("water")
      )
    })
    
    output$ibox9 <- renderInfoBox({
      infoBox(
        "Basement",
        input$basement, 
        icon = icon("arrow-alt-circle-down")
      )
    })
    output$ibox10 <- renderInfoBox({
      infoBox(
        "Renovated",
        input$renovated,
        icon = icon("hammer")
      )
    })
    
    #End of infoboxes-----------------------------------
    #View(house_prices3)
  

    
  
    output$int_map <- renderLeaflet({
      data <- dplyr::select(house_prices4, price, lat, long, zipcode)
      coordinates_data <- subset(data, data$zipcode == input$zip)
      #data <- dplyr::select(house_prices, price, lat, long, zipcode, waterfront)
      #coordinates_data <- subset(data, data$zipcode == input$zip |  data$waterfront == input$waterfront)
      #coordinates_data1 <- subset(coordinates_data, coordinates_data$zipcode |  coordinates_data$waterfront == input$waterfront)
      pal = colorNumeric("Spectral", domain = coordinates_data$price)
      coordinates_data %>%
            leaflet()%>%
            addProviderTiles(providers$OpenStreetMap.Mapnik)%>%
            addCircleMarkers(col = ~pal(price), opacity = 1.1, radius = 0.5) %>% 
            addLegend(pal = pal, values = ~price)
    })
}
