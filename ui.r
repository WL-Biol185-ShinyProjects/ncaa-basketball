
library(shiny)
library(shinydashboard)
library(ggplot2)
library(leaflet)
conf_stats <- read.csv("conference_stats.csv")

dashboardPage(
  skin = "purple",
  dashboardHeader(title = "NCAA Basketball"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Home", tabName = "page1"),
      menuItem("Conference Statistics", tabName = "page2"),
      menuItem("Maps", tabName = "page3")
    )
  )),
  dashboardBody(
    tabItems(
      tabItem(tabName = "page1", p("Home"),
        h2("Welcome!"),
        box(background = "purple", p("Introduction!"))
      ),
      
      tabItem(tabName = "page2", p("Conference Statistics"),
      selectInput(
        "y_var",
        label= "Conference Data",
        choices = colnames(conf_stats),
        selected = "Conference"),
        plotOutput("plot")
      ),
      
      tabItem(tabName = "page3", p("Maps"),
<<<<<<< HEAD
              leafletOutput("map"
                
              ),
=======

              leafletOutput("map"
                
              ),

>>>>>>> 40b0a918fa638397418dd57f941fbc9a0878712e
              fluidPage(
                leafletOutput("map"),
                plotOutput("plot")
              )
          
<<<<<<< HEAD
=======

>>>>>>> 40b0a918fa638397418dd57f941fbc9a0878712e
     
      
      )
    )
  
  )
)
