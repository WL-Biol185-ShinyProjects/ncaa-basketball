library(shiny)
library(tidyverse)
library(leaflet)
library(ggplot2)
library(geojsonio)
library(dplyr)
library(d3heatmap)

geodf <- read.csv("geodata.csv")
colnames(geodf)[2] <- "TEAM"
write.csv(geodf, "geodata.csv", row.names = FALSE)
college_geo <- read.csv("geodata.csv")
bb_data <- read.csv("cbb.csv")
conf_stats <- read.csv("conference_stats.csv")

function(input, output, session) {
  
  output$plot <- renderPlot({
    ggplot(conf_stats, aes_string(x = 'Conference', y = input$y_var)) +
      geom_bar(stat = "identity", width = 0.8) +
      labs(x = "Conference", y = input$y_var)
  })
  
  output$map <- renderLeaflet({
    # Assuming 'geo' is your spatial data
    leaflet(geo) %>%
      addPolygons(
        fillOpacity = 2.5,
        fillColor = ~pal(avgPR),
        color = "white",
        dashArray = '3',
        weight = 0.3
      )
  })
  
  output$heatmap <- renderD3heatmap({
    d3heatmap(heatmap_data, scale = "column", Rowv = row_labels, dendrogram = "none", colors = "Blues")
  })
  
}

