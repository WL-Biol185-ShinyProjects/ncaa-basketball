# loading the necessary libraries
library(shiny)
library(tidyverse)
library(leaflet)
library(ggplot2)
library(dplyr)
library(d3heatmap)
library(shinythemes)
library(shinyjs)
library(shinyWidgets)
library(shinydashboard)
library(geojsonio)

#Reading the Data
conf_stats <- read.csv("conference_stats.csv")
conf_avg <- read.csv("conference_statsAVG.csv")
heatmap_stats <- read.csv("heatmap_data.csv")
geodf <- read.csv("geodata.csv")
colnames(geodf)[2] <- "TEAM"
write.csv(geodf, "geodata.csv", row.names=FALSE)
college_geo <- read.csv("geodata.csv")
bb_data <- read.csv("cbb.csv")
merged_data <- left_join(bb_data, college_geo, by = "TEAM")
state_names_data <- read.csv("table-data.csv")
merged_data <- merged_data  %>%
  left_join(state_names_data, by = c("STATE" = "code"))


# using fluidPage to construct site
ui <- fluidPage(
  theme = shinytheme("yeti"),
  titlePanel("A Decade of NCAA Basketball Growth"),
  setBackgroundColor(color = "CornflowerBlue", shinydashboard = TRUE),
  
  #First tab - Home/About
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
               box(
                 title = "Welcome to our NCAA Basketball App",
                 width = 12,
                 solidHeader = TRUE,
                 status = "success",
                 background = "light-blue",
                tags$p("Welcome to our cutting-edge dashboard, where we look at a decades worth of statistical data on NCAA Division 1 basketball teams. The postseason
                      period of college basketball, coined March Madness, is one of the most revered sporting events of all time. Statistical data covers both in-season and post-season information, including importatn points such as power ranking, win percentage,
                      and free throw success. This data illustrates a unique narrative about each season and how the game of basektball has evolved over the 
                      last decade. Data can be used to understand conference performance, recruitment patterns, the impact of rule changes and adaptations, 
                      and team trends over time. This app provides a comprehensive understanding of the sport's development over time by identifying patterns and
    trends useful for anyone who appreciates the sport. Important to note, however, is the COVID-19 pandemic that occurred; there is not data from the year 2020,
    because postseason college basketball games were not held."),
                style = "border: 2px solid #333; border-radius: 5px;"
                ),
               tags$h2("Data Sourcing and Extraction"),
               tags$p("Data was pulled from a dataset on Kaggle called 'College Basketball Dataset', created by Andrew Sundberg. Additionally, geographical data was downloaded from the National Center for Education Statistics (NCES) Integrated Postsecondary Education Data System (IPEDS).
                      https://www.kaggle.com/datasets/andrewsundberg/college-basketball-dataset
                      "),
               box(
                 title = "Dashboard Features",
                 width = 12,
                 solidHeader = TRUE,
                 status = "info",
                 background = "light-blue",
                 tags$p("This dashboard features data covering ten seasons of NCAA DI Men's basketball, illustrated in graphs by conference, and state maps."),
                 style = "border: 2px solid #333; border-radius: 5px;")
               
             )),
    
    #Tab 2: Conference Stats
    tabPanel("Conference Statistics",
             tags$h2("How do conferences compare based on different basketball statitsics?"),
             fluidPage(
               tags$p("Using the dropdown box, select which statistic you would like to see, and how each conference matches up."),
               selectInput(
                 "y_var",
                 label = "Conference Data",
                 choices = colnames(conf_stats)[-which(colnames(conf_stats) == "Conference")],
                
                 selected = "Adjusted Offensive Efficiency"),
               plotOutput("plot"),
               box(
                 width = 18,
                 status = "info",
                 textOutput("confExp"),
                 style = "border: 2px solid #333; border-radius: 5px;"),
               box(
                 width = 5,
                 status = "info",
                 background = "light-blue",
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

  #Tab 3: State maps page
  tabPanel("Maps of Stats by State",
           fluidPage(
             tags$h2("How do teams compare across states?"),
             tags$p("Use the drop-down box to select which statistic you would like to see."),
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
             leafletOutput("geo"),
        
           box(
             title = "Our Main Takeaways",
             width = 12,
             solidHeader = TRUE,
             status = "success",
             background = "light-blue",
              tags$p("As seen in the above US maps, teams vary widely across states. Additionally, teams vary in which facets they excel at. Teams 
                  nationwide are notable for different things. For example, Connecticut is the leading state for free throws, which is in large part
                  due to University of Connecticut, Yale, and Fairfield. Maine has the highest turnover percentage, thanks to University of Maine.
                  Looking at data by state is useful for recruits and may influence their decision on where to apply. Moreover, it is helpful for 
                  understanding the impact of regional differences and factors, and how geographical factors influence performance. This could be useful
                  for players, coaches, recruits, individuals who bet and gamble on games, and tournament-planning. If a state contains multiple teams who
                  excel in many categories, it would be beneficial and profitable to host a tournament in that state, in order to maximize fan engagement and profit."),
             style = "border: 2px solid #333; border-radius: 5px;"
           )
  )),
  
  # # Tab 4: Yearly Success heat map page
   tabPanel("Yearly Success",
            fluidPage(
              tags$h2("How individual teams compare over the years?"),
              tags$p("Use the drop-down box to select which team you want to look at."),
  
  sliderInput("year_selector", "Select Year Range", min = 2013, max = 2023, value = c(2000, 2013)),
  pickerInput("choicePicker","Pick Teams",choices = merged_data$TEAM,
              options =list("actions-box" = TRUE), 
              multiple=FALSE,
              selected="North Carolina"),
  pickerInput("choicePicker","Pick Variable",choices = colnames(bb_data),
              options =list("actions-box" = TRUE), 
              multiple=FALSE,
              selected="ADJOE"),
  plotOutput("trend"),
   )),
  
  #Tab 5: About the creators
  tabPanel("About the Creators",
           fluidPage(



# body <- dashboardBody(
#   tabItems(
#     tabItem(tabName = "Home", homePage),
#     tabItem(tabName = "ConferenceStatistics", confstats),
#     tabItem(tabName = "StatisticsbyStateMaps", maps)
#     
#   )
# )
# 
# dashboardPage(skin = "blue",
#               dashboardHeader(title = "NCAA Men's Basketball Dashboard",
#                               titleWidth = 200),
#               dashboardSidebar(
#                 sidebarMenu(style = "white-space: normal;",
#                             "Contents",
#                             menuItem("Home", tabName = "Home", icon = icon("basketball-hoop")),
#                             menuItem("Conference Statistics", tabName = "ConferenceStatistics", icon = icon("medal")),    
#                             menuItem("Statistics-by-State Maps", tabName = "StatisticsbyStateMaps", icon = icon("ranking-star"))
#                             
#                 )
#               ),
#               body
# )
# 


             tags$h2("Created by Allyssa Utecht, Katelyn Gamble, and Sophia Rollo"),

             tags$h2("Created by Allyssa Utecht, Katelyn Gamble, and Sophia Rollo"),
             box(
               status = "success",
               solidHeader = TRUE,
               width = 12,
               tags$img(src = "www/group_pic.png", 
                        align = "center", 
                        width = "8",
                        alt = "group picture")),

           ))

))
    

