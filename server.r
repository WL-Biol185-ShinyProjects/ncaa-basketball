# loading the necessary libraries
library(shiny)
library(tidyverse)
library(leaflet)
library(ggplot2)
library(dplyr)
library(d3heatmap)

# reading the data, specifying our conference data used in conference tab
conf_stats <- read.csv("conference_stats.csv")
conf_avg <- read.csv("conference_statsAVG.csv")
heatmap_stats <- read.csv("heatmap_data.csv")


server <- function(input,output) {
  
  output$home_img <- renderImage({
    
    list(src = "www/header_img.png",
         width = "800",
         height = 200)
    
  }, deleteFile = F)
  
  output$logo_img <- renderImage({
    
    list(src = "www/logo_img.png",
         width = "450",
         height = 400)
    
  }, deleteFile = F)
  

  
  output$confExp <- renderText({
    "In each of the graphs shown above, important statistics are displayed for each conference. Each graph shows an average value of the given variable 
    for each conference for the last ten years. In basketballl, four factors are considered the most important strategies for winning a basketball game: scoring 
    every possession, picking up rebounds, getting to the foul line, and protecting the ball. While all the variables analyzed are important for analyizng a team's 
    past, present, and future success, four of these bargraphs are the most notable for determining a team's success. 'Scoring every possession' is analyzed through 
    effective field goals, 'picking up all rebounds' is analyzed through the turnovers precentage, 'getting to the fou line' is analyzed through the 
rebounding percentage, and 'protecting the ball' is analyzed through the free throw rate. Additionally, it is not only important for a team to score points through these
factors, but it is important to minimize the points scored by the other team, so the opponent's average data for each of these factors is also shown."
})

  # Conference tab bar graph
        output$plot <- renderPlot({
        ggplot(data=conf_avg, aes_string(x='Conference',
                                       y=input$y_var)) +
              geom_bar(stat = "identity", width = 0.8) +
              labs(x="Conference", y=input$y_var)
  })
        
        output$yVar <- renderText({
          "Adjusted Offensive Efficiency = Points scored per 100 possessions.
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
Wins Above Bubble = The bubble is the cut off between qualifying for the tournament and not qualifying for the tournament. So, the wins above bubble refers to the number of won games that a team has that is over the number of games they need to qualify for the tournament.
"
        })
        
        # Conference Tab Heat Map
    output$heatmapPlot <- renderD3heatmap({
          req(input$YEAR)
      df <- heatmap_stats %>%
        filter(YEAR == input$YEAR)
      row.names(df) <- df$Conference
      df$Conference <- NULL
       d3heatmap(as.matrix(df))
         })
     
  # Maps tab   
        output$geo <- renderLeaflet ({
          chosen_stat <- switch(input$map_stat,
                                "avgPR" = "BARTHAG",
                                "avgFT" = "EFG_O",
                                "avgFG" = "EFG_O",
                                "avgTOR" = "TOR",
                                "avgTORD" = "TORD",
                                "avgORB" = "ORB",
                                "avgFTR" = "FTR",
                                "avgTEMPO" = "ADJ_T")
          
          state_stat <- merged_data %>%
            group_by(state) %>%
            summarize(stat_value = mean(!!sym(chosen_stat)), na.rm = TRUE)
          
          geo <- geojson_read("states.geo.json", what = "sp")
          geo@data <- left_join(geo@data, state_stat, by = c("NAME" = "state"))
          
          pal <- colorBin("Blues", domain = geo@data$stat_value)
          
          leaflet(geo) %>%
            addPolygons(
              fillOpacity = 2.5,
              fillColor = ~pal(stat_value),
              color = "white",
              dashArray = '3',
              weight = 3
            ) %>%
            setView(lng = -79.442778, lat = 37.783889, zoom = 5) %>%
            addTiles()
        })
}       
