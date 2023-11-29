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
    "Welcome to our cutting-edge dashboard, where we look at a decades worth of statistical data on NCAA Division 1 basketball teams.
    Statistical data covers both in-season and post-season information, including importatn points such as power ranking, win percentage,
    and free throw success. This data illustrates a unique narrative about each season and how the game of basektball has evolved over the 
    last decade. Data can be used to understand conference performance, recruitment patterns, the impact of rule changes and adaptations, 
    and team trends over time."
  })
  

  
  # Conference tab bar graph
        output$plot <- renderPlot({
        ggplot(data=conf_avg, aes_string(x='Conference',
                                       y=input$y_var)) +
              geom_bar(stat = "identity", width = 0.8) +
              labs(x="Conference", y=input$y_var)
  })

  
  output$textBox <- renderText({
    "In each of the graphs shown above, ."
  })
 
  
}
        
  # Conference Tab Heat Map
       output$heatmapPlot <- renderD3heatmap({
       d3heatmap(heatmap_stats, YEAR == input$selectedYEAR)
         })
          
