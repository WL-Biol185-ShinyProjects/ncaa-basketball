library(shiny)
library(leaflet)
library(ggplot2)
library(tidyverse)
library(dplyr)

<<<<<<< HEAD
conf_stats <- read.csv("conference_stats.csv")

function(input,output,session){
=======

geodf <- read.csv("geodata.csv")
colnames(geodf)[2] <- "TEAM"
write.csv(geodf, "geodata.csv", row.names=FALSE)
college_geo <- read.csv("geodata.csv")
bb_data <- read.csv("cbb.csv")
conf_stats <- read.csv("conference_stats.csv")

server <- function(input, output, session) {
  browser()
  print("checkpoint")
  
>>>>>>> ff81bfaa3be39eaeb321def218e24c57d23a7324
  output$plot <- renderPlot({
 
    ggplot(data=conf_stats, aes_string(x='Conference',
                                        y=input$y_var)) +
                                        geom_bar(stat = "identity", width = 0.8) +
                                        labs(x="Conference", y=input$y_var)
 
  })

  output$map <- renderLeaflet({
    leaflet() %>%
<<<<<<< HEAD
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

=======
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
>>>>>>> ff81bfaa3be39eaeb321def218e24c57d23a7324
