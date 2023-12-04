library(shiny)
library(shinythemes)
library(shinyjs)
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
             tags$p("In each of the graphs shown above, important statistics are displayed for each conference. Each graph shows an average value of the given variable 
                     for each conference for the last ten years. In basketballl, four factors are considered the most important strategies for winning a basketball game: scoring 
                     every possession, picking up rebounds, getting to the foul line, and protecting the ball. While all the variables analyzed are important for analyizng a team's 
                     past, present, and future success, four of these bargraphs are the most notable for determining a team's success. 'Scoring every possession' is analyzed through 
                     effective field goals, 'picking up all rebounds' is analyzed through the turnovers precentage, 'getting to the fou line' is analyzed through the 
                     rebounding percentage, and 'protecting the ball' is analyzed through the free throw rate. Additionally, it is not only important for a team to score points through these
                     factors, but it is important to minimize the points scored by the other team, so the opponent's average data for each of these factors is also shown."),
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
                 textOutput("yVar")),
               textAreaInput(
                 "statsdesc_textbox", 
                 label = "Statistic descriptions",  
                 value = "
                 Adjusted Offensive Efficiency = Points scored per 100 possessions.
                 Adjusted Defensive Efficiency = Points allowed per 100 possessions.
                 Power Rating = Chance of beating an average Division 1 team.
                 Effective Field Goal Percentage Shot = A field goal is either a two or three point shot.
                 Effective Field Goal Percentage Allowed = The rate at which a team allowed the other team to make a two or three point shot.
                 Turnover Percentage = A turnover is when a team loses possession of the ball and the other team gains possession.
                 Steal Rate = The rate at which one team causes a turnover and gets the ball back.
                 Offensive Rebound Rate = The rate at which a team recovers the ball after a failed shot and doesn’t lose possession.
                 Offensive Rebound Rate Allowed = The rate at which a team playing defensive allows the other team’s offensive to recover the ball after a failed shot.
                 Free Throw Rate = A free throw is a one-point shot attempt given to a player who was fouled.
                 Free Throw Rate Allowed = The rate at which a team allows the opposing team to shoot free throws.
                 Two Point Shooting Rate = The rate at which a team shoots two-pointers.
                 Two Point Shooting Rate Allowed = The rate at which a team allows the other team to shoot two-pointers.
                 Three Point Shooting Rate = The rate at which a team shoots three-pointers.
                 Three Point Shooting Rate Allowed = The rate at which a team allows the other team to shoot three-pointers.
                 Adjusted Tempo = The tempo is described as the number of possessions a team has per 40 minutes of playing time.
                 Wins Above Bubble = The bubble is the cut off between qualifying for the tournament and not qualifying for the tournament. So, the wins above bubble refers to the number of won games that a team has that is over the number of games they need to qualify for the tournament.",  
                 width = "1500px", 
                 height = "400px"
               )
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