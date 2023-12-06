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


# reading the data, specifying our conference data used in conference tab
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
  
  
  tags$h2(
    "Welcome to our cutting-edge dashboard, where we look at a decades worth of statistical data on NCAA Division 1 basketball teams. The postseason
    period of college basketball, coined March Madness, is one of the most revered sporting events of all time. Statistical data covers both in-season and post-season information, including importatn points such as power ranking, win percentage,
    period of college basketball, coined 'March Madness'', is one of the most revered sporting events of all time. Statistical data covers both in-season and post-season information, including importatn points such as power ranking, win percentage,
    period of college basketball, coined 'March Madness'', is one of the most revered sporting events of all time. Statistical data covers both in-season and post-season information, including important points such as power ranking, win percentage,
    and free throw success. This data illustrates a unique narrative about each season and how the game of basektball has evolved over the 
    last decade. Data can be used to understand conference performance, recruitment patterns, the impact of rule changes and adaptations, 
    and team trends over time. This app provides a comprehensive understanding of the sport's development over time by identifying patterns and
    trends useful for anyone who appreciates the sport. Important to note, however, is the COVID-19 pandemic that occurred; there is not data from the year 2020,
    because postseason college basketball games were not held."
  )
  
  output$confExp <- renderText({
    "In each of the graphs shown above, important statistics are displayed for each conference. Each graph shows an average value of the given variable 
    for each conference for the last ten years. 
    
    In basketball, four factors are considered the most important strategies for winning a basketball game: scoring 
    every possession, picking up rebounds, getting to the foul line, and protecting the ball. While all the variables analyzed are important for analyizng a team's 
    past, present, and future success, these four bar graphs are most notable for determining a team's success. 
    - 'Scoring every possession' is analyzed through effective field goals
    - 'Picking up all rebounds' is analyzed through the turnover precentage
    - 'Getting to the foul line' is analyzed through the rebounding percentage 
    - 'Protecting the ball' is analyzed through the free throw rate. 
    
    Additionally, it is not only important for a team to score points through these
factors, but it is important to minimize the points scored by the other team, so the opponent's average data for each of these factors is also shown."

})
 


  # Conference tab bar graph
        output$plot <- renderPlot({
        ggplot(data=conf_stats, aes_string(x='Conference',
                                       y=input$y_var)) +
              geom_bar(stat = "identity", width = 0.8) +
              labs(x="Conference", y=input$y_var)
  })
        
        runjs('$("#statsdesc_textbox").css("background-color", "lightblue");')
        
        # Conference Tab Heat Map
    output$heatmapPlot <- renderD3heatmap({
      all_years <- filter(heatmap_stats, YEAR %in% as.numeric(input$YEAR))
       d3heatmap(all_years,
                 width = 800, 
                 height = 600)
         })
     
  # Maps tab
    
    
        output$geo <- renderLeaflet ({
          print(state_stat)
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
          print(state_stat)
          print(merged_data)
          
          geo <- geojson_read("states.geo.json", what = "sp")
          geo@data <- left_join(geo@data, state_stat, by = c("NAME" = "state"))
          
          pal <- colorBin("Blues", domain = geo@data$stat_value)
          
          leaflet(data = geo) %>%
            addPolygons(
              fillOpacity = 2.5,
              fillColor = ~pal(stat_value),
              color = "white",
              dashArray = '3',
              weight = 3
            ) %>%
            setView(lng = -80, lat = 38, zoom = 4) %>%
            addTiles()
        })
        
        
        
        
        
}       
