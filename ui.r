library(shiny)
library(shinydashboard)
library(ggplot2)

dashboardPage(
  skin = "purple",
  dashboardHeader(title = "NCAA Basketball"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Home", tabName = "page1"),
      menuItem("Conference Statistics", tabName = "page2")
    )
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "page1", p("Home"),
              h2("Welcome!"),
              box(background = "purple", p("Introduction!"))
      ),
      
      tabItem(tabName = "page2", p("Conference Statistics"),
              selectInput(
                "y_var",
                label = "Conference Data",
                choices = colnames(conf_stats),
                selected = "Conference"),
                plotOutput("plot")
              ),
      
      tabItem(tabName = "page3", p("Maps"),
              
              ),
      
      tabItem(tabName = "page4", p("Heat Map"),
              
              )
      )
    )
  )

