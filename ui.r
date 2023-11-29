library(shiny)
library(shinydashboard)
library(ggplot2)

dashboardPage(
  skin = "blue",
  dashboardHeader(title = "NCAA Basketball"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Home", tabName = "page1"),
      menuItem("Conference Statistics", tabName = "page2"),
      menuItem("Maps", tabName = "page3")
    )
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "page1", p("Home"),
              h2("Welcome!"),
              imageOutput("home_img"),
              box(background = "blue", p("Welcome to Our Shiny App!")),
              imageOutput("logo_img"),
              box(
                width = 5,
                status = "info",
                textOutput("textBox"))
      ),
      
      tabItem(tabName = "page2", p("Conference Statistics"),
              selectInput(
                "y_var",
                label = "Conference Data",
                choices = colnames(conf_stats),
                selected = "Conference"),
                plotOutput("plot"),
              box(
                width = 5,
                status = "info",
                textOutput("confExp")
              ),
      
      tabItem(tabName = "page3", p("Maps"),
              
              ),
      
      tabItem(tabName = "page4", p("Heat Map"),
              
              )
    )
    
    )
  )

