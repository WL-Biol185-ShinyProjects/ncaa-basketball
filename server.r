library(shiny)
library(leaflet)
library(ggplot2)
library(tidyverse)
library(dplyr)

conf_stats <- read.csv("conference_stats.csv")

function(input,output,session){
  output$plot <- renderPlot({
 
    ggplot(data=conf_stats, aes_string(x='Conference',
                                        y=input$y_var)) +
                                        geom_bar(stat = "identity", width = 0.8) +
                                        labs(x="Conference", y=input$y_var)
 
  })

  output$map <- renderLeaflet({
    leaflet() %>%
      addPolygons(
        fillOpacity = 2.5,
        fillColor = ~pal(avgPR),
        color = "white",
        dashArray = '3',
        weight = 0.3,
        data = geo@data
      )
    addTiles() %>%
      
      addGeoJSON(geojson_data)
  })
}

