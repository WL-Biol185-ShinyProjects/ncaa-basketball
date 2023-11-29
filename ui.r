library(shiny)
library(shinydashboard)
library(ggplot2)
library(d3heatmap)
conf_stats <- read.csv("conference_stats.csv")

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
      
      tabItem(tabName = "page2", 
              tabPanel("Conference Statistics",
  # Bar Graph for Conference           
              fluidRow(
                box(
                  title = "Conference Data",
                  status = "primary",
                  width = 6,
                  selectInput(
                    "y_var",
                    label = "Conference Data",
                    choices = colnames(conf_stats),
                    selected = "Conference")
                ),
                plotOutput("plot")
              ),
      
      tabItem(tabName = "page3", p("Maps"),
              
              ),
      
      tabItem(tabName = "page4", p("Heat Map"),
              
              )
              ),
  
  # Heat Map for Conference
            fluidRow(
             box(
               title = "Conference Heatmap",
               status = "primary",
               solidHeader = TRUE,
               width = 6,
              d3heatmapOutput("heatmap")
    )
  )
  
  
  
  
      )
    )
  )
)