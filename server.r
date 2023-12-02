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


<<<<<<< HEAD
function(input, output, session) {

=======
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
  
  
  output$textBox <- renderText({
    "Welcome to our cutting-edge dashboard, where we look at a decades worth of statistical data on NCAA Division 1 basketball teams. The postseason
    period of college basketball, coined 'March Madness'', is one of the most revered sporting events of all time. Statistical data covers both in-season and post-season information, including important points such as power ranking, win percentage,
    and free throw success. This data illustrates a unique narrative about each season and how the game of basektball has evolved over the 
    last decade. Data can be used to understand conference performance, recruitment patterns, the impact of rule changes and adaptations, 
    and team trends over time. This app provides a comprehensive understanding of the sport's development over time by identifying patterns and
    trends useful for anyone who appreciates the sport. Important to note, however, is the COVID-19 pandemic that occurred; there is not data from the year 2020,
    because postseason college basketbakll games were not held."
  })
  
>>>>>>> 03c01f23ad0473400771d2962fefde8182618870

  # Conference tab bar graph
        output$plot <- renderPlot({
        ggplot(data=conf_avg, aes_string(x='Conference',
                                       y=input$y_var)) +
              geom_bar(stat = "identity", width = 0.8) +
              labs(x="Conference", y=input$y_var)
  })
        
 # Text
    #     output$home_img <- renderImage({
    #       
    #       list(src = "www/header_img.png",
    #            width = "800",
    #            height = 200)
    #       
    #     }, deleteFile = F)
    #     
    #     output$logo_img <- renderImage({
    #       
    #       list(src = "www/logo_img.png",
    #            width = "450",
    #            height = 400)
    #       
    #     }, deleteFile = F)
    #     
    #     
    #     output$textBox <- renderText({
    #       "Welcome to our cutting-edge dashboard, where we look at a decades worth of statistical data on NCAA Division 1 basketball teams. The postseason
    # period of college basketball, coined March Madness, is one of the most revered sporting events of all time. Statistical data covers both in-season and post-season information, including importatn points such as power ranking, win percentage,
    # period of college basketball, coined 'March Madness'', is one of the most revered sporting events of all time. Statistical data covers both in-season and post-season information, including importatn points such as power ranking, win percentage,
    # and free throw success. This data illustrates a unique narrative about each season and how the game of basektball has evolved over the 
    # last decade. Data can be used to understand conference performance, recruitment patterns, the impact of rule changes and adaptations, 
    # and team trends over time. This app provides a comprehensive understanding of the sport's development over time by identifying patterns and
    # trends useful for anyone who appreciates the sport. Important to note, however, is the COVID-19 pandemic that occurred; there is not data from the year 2020,
    # because postseason college basketbakll games were not held."
    #     })
        
        
        
        
        
        
        
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
        output$map <- renderLeaflet ({
          leaflet(date = ) %>%
            setView(lng = , lat = , zoom = ) %>%
            addTiles
        })
          
}       
