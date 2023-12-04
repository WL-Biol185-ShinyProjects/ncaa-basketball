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



  # Conference tab bar graph
        output$plot <- renderPlot({
        ggplot(data=conf_avg, aes_string(x='Conference',
                                       y=input$y_var)) +
              geom_bar(stat = "identity", width = 0.8) +
              labs(x="Conference", y=input$y_var)
  })
        
        runjs('$("#statsdesc_textbox").css("background-color", "lightblue");')
        
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
