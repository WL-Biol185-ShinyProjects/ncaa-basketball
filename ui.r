library(shiny)
library(shinydashboard)
library(ggplot2)
library(d3heatmap)

conf_stats <- read.csv("conference_stats.csv")
conf_avg <- read.csv("conference_statsAVG.csv")
heatmap_stats <- read.csv("heatmap_data.csv")

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
                textOutput("confExp")),
                
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
                    choices = colnames(conf_avg),
                    selected = "Conference")
                ),
                plotOutput("plot")
              ),
  
  # Heat Map for Conference
              fluidRow(
            box(
              title = "Choose Conference",
              status = "primary",
              width = 6,
              selectInput( "selectededyear", "Select Year", unique(heatmap_stats$YEAR),
                           selected = max(heatmap_stats$YEAR, multiple =FALSE)),
  # This is the actual heatmap
              fluidRow(
                box(
                  d3heatmapOutput("heatmapPlot")
                )
              )
    )
    
    )
  )
    )
  )
      )
    )
)

  

