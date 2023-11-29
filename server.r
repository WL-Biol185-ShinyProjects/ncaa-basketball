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

function(input,output,session){
  
  # Conference tab bar graph
        output$plot <- renderPlot({
        ggplot(data=conf_avg, aes_string(x='Conference',
                                       y=input$y_var)) +
              geom_bar(stat = "identity", width = 0.8) +
              labs(x="Conference", y=input$y_var)
  })
        
  # Conference Tab Heat Map
        filtered_data <- reactive({
          subset(conf_avg, Conference == input$selected_conference)
        })
        output$heatmap <- renderD3heatmap({
        heatmap_data <- select(filtered_data(), -Conference) %>% t() %>% as.matrix()
      
        
        d3heatmap(
          heatmap_data,
          scale = "column",
          dendrogram = "none",
          colors = "Blues"
          
        )
          
        })
}