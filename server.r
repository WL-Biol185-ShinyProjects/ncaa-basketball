# loading the necessary libraries
library(shiny)
library(tidyverse)
library(leaflet)
library(ggplot2)
library(dplyr)
library(d3heatmap)

# specifying our conference data used in conference tab
conf_stats <- read.csv("conference_stats.csv")

conf_avg <- read.csv("conference_statsAVG.csv")
heatmap_stats <- read.csv("heatmap_data.csv")


function(input,output,session){
  
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
  
  
  output$textBox <- renderText({
    "Welcome to our cutting-edge dashboard, where we look at a decades worth of statistical data on NCAA Division 1 basketball teams. The postseason
    period of college basketball, coined "March Madness", is one of the most revered sporting events of all time. Statistical data covers both in-season and post-season information, including importatn points such as power ranking, win percentage,
    and free throw success. This data illustrates a unique narrative about each season and how the game of basektball has evolved over the 
    last decade. Data can be used to understand conference performance, recruitment patterns, the impact of rule changes and adaptations, 
    and team trends over time. This app provides a comprehensive understanding of the sport's development over time by identifying patterns and
    trends useful for anyone who appreciates the sport. Important to note, however, is the COVID-19 pandemic that occurred; there is not data from the year 2020,
    because postseason college basketbakll games were not held."
  })
  

  
  # Conference tab bar graph
        output$plot <- renderPlot({
        ggplot(data=conf_avg, aes_string(x='Conference',
                                       y=input$y_var)) +
              geom_bar(stat = "identity", width = 0.8) +
              labs(x="Conference", y=input$y_var)
  })

  
  output$confExp <- renderText({
    "In each of the graphs shown above, important statistics are displayed for each conference. Each graph shows an average value of the given variable 
    for each conference for the last ten years. In basketballl, four factors are considered the most important strategies for winning a basketball game - scoring 
    every possession, picking up rebounds, getting to the foul line, and protecting the ball. While all the variables analyzed are important for analyizng a team's 
    past, present, and future success, four of these bargraphs are the most notable for determining a team's success. 'Scoring every possession' is analyzed through
    effective field goals, 'picking up all rebounds' is analyzed through the turnovers precentage, 'getting to the fou line' is analyzed through the 
    rebounding percentage, and 'protecting the ball' is analyzed through the free throw rate. Additionally, it is not only important for a team to score points through these
    factors, but it is important to minimize the points scored by the other team, so the opponent's average data for each of these factors is also shown."
  })
 
  
}
        
  # Conference Tab Heat Map
       output$heatmapPlot <- renderD3heatmap({
       d3heatmap(heatmap_stats, YEAR == input$selectedYEAR)
         })
          
