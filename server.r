# loading the necessary libraries
library(shiny)
library(tidyverse)
library(leaflet)
library(ggplot2)
library(dplyr)
library(d3heatmap)

# specifying our conference data used in conference tab
conf_stats <- read.csv("conference_stats.csv")

function(input,output,session){
  
  # Conference tab bar graph
        output$plot <- renderPlot({
        ggplot(data=conf_stats, aes_string(x='Conference',
                                       y=input$y_var)) +
              geom_bar(stat = "identity", width = 0.8) +
              labs(x="Conference", y=input$y_var)
  })
        
  # Conference Tab Heat Map
        heatmap_data <- as.matrix(conf_stats[, -1])
        row_labels <- conf_heatmapdata$Conference
        output$heatmap <- renderD3heatmap({
          d3heatmap(heatmap_data, scale = "column", Rowv = row_labels, dendrogram = "none", colors = "Blues")
        })
          
}