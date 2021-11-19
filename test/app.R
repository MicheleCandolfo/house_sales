library(shiny)
library(shinydashboard)
library(shinydashboardPlus)
shinyApp(
    ui = dashboardPage(
        skin = "midnight",
        header = dashboardHeader(),
        sidebar = dashboardSidebar(),
        body = dashboardBody(),
        controlbar = dashboardControlbar(),
        footer = dashboardFooter(),
        title = "Midnight Skin"
    ),
    server = function(input, output) { }
)