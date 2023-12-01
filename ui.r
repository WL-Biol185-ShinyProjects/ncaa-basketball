library(shiny)
library(shinydashboard)
library(ggplot2)
library(d3heatmap)

#Reading the Data
conf_stats <- read.csv("conference_stats.csv")
conf_avg <- read.csv("conference_statsAVG.csv")
heatmap_stats <- read.csv("heatmap_data.csv")

ui <- fluidPage(
  theme = shinytheme("")
  titlePanel("A Decade of NCAA Basketball Growth"),
  setBackgroundColor(CornflowerBlue)
  
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
               tags$p("Welcome to a comprehensive analysis of a decade of data on Division 1 Men's Basketball."),
               tags$h2("Data Sourcing and Extraction"),
               tags$p("Data was pulled from a dataset on Kaggle called 'College Basketball Dataset', created by Andrew Sundberg. Additionally, geographical data was downloaded from _."),
               box(
                 title = "Dashboard Features",
                 status = "info",
                 solidHeader = TRUE,
                 width = 12,
                 "This dashboard features data covering ten seasons of NCAA DI Men's basketball, illustrated in graphs by conference, and state maps."
               ),
               
             ))),
    
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
               
              
             ))
  
  


confstats <- fluidPage(
  titlePanel("Statistics by Conference"),
  fluidRow(
    column(
      width = 12,
      box(
        status = "info",
        solidHeader = TRUE,
        width = 12,
        tags$figure(
          class = "centerFigure",
          img(
            src = "underwater.JPEG",
            width = 600,
            alt = "Picture of Pari, Estelle, and Abby"
          )
        )
      )
    )
  ),
  
  fluidRow(
    column(
      width = 12,
      box(
        title = "References",
        status = "primary",
        solidHeader = TRUE,
        width = 12,
        p("Works Cited... I would like to put an option to download the data file here")
      )
    )
  )
)

textbox <- fluidPage(
  titlePanel("A Decade of NCAA Basketball Growth"),
  fluidRow(
    column(
      width = 12,
      box(
        status = "info",
        solidHeader = TRUE,
        width = 12,
        tags$img(src = "header_img.png", 
                 align = "center", 
                 width = "100%",
                 alt = "NCAA Basketball Teams")
      )
    )
  ),
  
  fluidRow(
    column(
      width = 12,
      box(
        title = "Introduction",
        status = "primary",
        solidHeader = TRUE,
        width = 12,
        p("")
      )
    )
  ),


body <- dashboardBody(
  tabItems(
    tabItem(tabName = "Home", homePage),
    tabItem(tabName = "ConferenceStatistics", confstats),
    tabItem(tabName = "StatisticsbyStateMaps")
    
  )
)

dashboardPage(skin = "blue",
              dashboardHeader(title = "NCAA Men's Basketball Dashboard",
                              titleWidth = 200),
              dashboardSidebar(
                sidebarMenu(style = "white-space: normal;",
                            "Contents",
                            menuItem("Home", tabName = "Home", icon = icon("basketball-hoop")),
                            menuItem("Conference Statistics", tabName = "ConferenceStatistics", icon = icon("medal")),    
                            menuItem("Statistics-by-State Maps", tabName = "StatisticsbyStateMaps", icon = icon("ranking-star"))
                            
                )
              ),
              body
)

