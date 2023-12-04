library(shiny)
library(shinythemes)
library(shinyWidgets)
library(shinydashboard)
library(ggplot2)
library(d3heatmap)
library(leaflet)

#Reading the Data
conf_stats <- read.csv("conference_stats.csv")
conf_avg <- read.csv("conference_statsAVG.csv")
heatmap_stats <- read.csv("heatmap_data.csv")

ui <- fluidPage(
  theme = shinytheme("yeti"),
  titlePanel("A Decade of NCAA Basketball Growth"),
  setBackgroundColor(color = "CornflowerBlue", shinydashboard = TRUE),
  
  #Firsttab - Home/About
  
  navbarPage(
    "Tabs",
    tabPanel("About",
             fluidPage(
               box(
                 status = "info",
                 solidHeader = TRUE,
                 width = 12,
                 tags$img(src = "header_img.png", 
                          align = "center", 
                          width = "100%",
                          alt = "NCAA Basketball Teams")),
               box(status = "info",
                   solidHeader = TRUE,
                   width = 12,
                   tags$figure(
                   class = "centerFigure",
                   img(
                     src = "logo_img.png",
                     width = 600,
                     alt = "NCAA Basketball Teams"))),
               tags$h1("Welcome to our NCAA Basketball App"),
               tags$p( "Welcome to our cutting-edge dashboard, where we look at a decades worth of statistical data on NCAA Division 1 basketball teams. The postseason
                      period of college basketball, coined March Madness, is one of the most revered sporting events of all time. Statistical data covers both in-season and post-season 
                      information, including importatn points such as power ranking, win percentage, and free throw success. This data illustrates a unique narrative about each season 
                      and how the game of basektball has evolved over the last decade. Data can be used to understand conference performance, recruitment patterns, the impact of rule changes and adaptations, 
                      and team trends over time. This app provides a comprehensive understanding of the sport's development over time by identifying patterns and 
                      trends useful for anyone who appreciates the sport. Important to note, however, is the COVID-19 pandemic that occurred; there is not data from the year 2020, 
                       because postseason college basketball games were not held."),
               tags$h2("Data Sourcing and Extraction"),
               tags$p("Data was pulled from a dataset on Kaggle called 'College Basketball Dataset', created by Andrew Sundberg. Additionally, geographical data was downloaded from _."),
               tags$h3("Dashboard Features"),
               tags$p("This dashboard features data covering ten seasons of NCAA DI Men's basketball, illustrated in graphs by conference, and state maps.")
               )
               
             ),
    
    #Tab 2: Conference Stats
    tabPanel("Conference Statistics",
             fluidPage(
               tags$h3("Below is a graph of data, by conference, that is the average of 10 years of data for that conference."),
               tags$p("Using the dropdown box, select which statistic you would like to see, and how each conference matches up."),
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
               plotOutput("plot"),
               box(
                 width = 5,
                 status = "info",
                 textOutput("yVar"))
               )
             ),

  #State maps page
  tabPanel("Maps of Stats by State",
           fluidPage(
             tags$h2("How do teams compare across states?"),
             selectInput(  "map_stat",
                           label = "Choose a Statistic",
                           choices = c("Average Power Ranking" = "avgPR",
                                       "Average Free Throw Percentage" = "avgFT",
                                       "Average Effective Field Goal Percentage" = "avgFG",
                                       "Average Turnover Percentage" = "avgTOR",
                                       "Average Steal Percentage" = "avgTORD",
                                       "Average Offensive Rebound Percentage" = "avgORB",
                                       "Average Free Throw Rate" = "avgFTR",
                                       "Average Tempo" = "avgTEMPO"),
                           selected = "avgPR"),
             leafletOutput("geo")
           )),

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