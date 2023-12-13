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
aggregated_data <- read.csv("aggregated_data.csv")
colnames(aggregated_data)[5] <- "Wins"


# making a function
server <- function(input,output) {

  # first image
  output$home_img <- renderImage({
    
    list(src = "www/header_img.png",
         width = "800",
         height = 200)
    
  }, deleteFile = F)
  
  # second image
  output$logo_img <- renderImage({
    
    list(src = "www/logo_img.png",
         width = "450",
         height = 400)
    
  }, deleteFile = F)
  
  
  #text
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
    ggplot(data = conf_stats, aes_string(x = 'Conference', y = input$y_var)) +
      geom_bar(stat = "identity", width = 0.8, fill = "royal blue") +
      theme(axis.title.x = element_text(size = 20), 
            axis.title.y = element_text(size = 20),
            axis.text.x = element_text(size = 15, angle = 60, hjust = 1),
            axis.text.y = element_text(size = 15)) +
      labs(x = "Conference", y = gsub("\\.", " ", input$y_var))
        
  })
        
        runjs('$("#statsdesc_textbox").css("background-color", "lightblue");')
        
  })
     
  # Maps tab
    
        output$geo <- renderLeaflet ({
        #  print(state_stat)
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
         # print(state_stat)
         # print(merged_data)
          
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
            addTiles() %>%
            addLegend(pal = pal, values = ~stat_value, opacity = 2.5, title = NULL, position = "bottomright")
        })
        
        # Yearly success  tab
        output$yearly_success <- filtered_data <- reactive({
          subset(aggregated_data, TEAM == input$choicePicker1)
        })
        
        
        output$yearly_success <- renderPlot({
          ggplot(filtered_data(), aes_string(x = "YEAR", y = input$choicePicker2)) +
            geom_line(color = "blue") +
            geom_point(color = "blue", size = 4) +
            labs(title = paste("Trends in", input$choicePicker2, "for", input$choicePicker1),
                 x = "Year", y = input$choicePicker2) +
            scale_x_continuous(breaks = c(2013,2014,2015,2016,2017,2018,2019,2020,2021,2022,2023),
                               labels = c(2013,2014,2015,2016,2017,2018,2019,2020,2021,2022,2023))
           })
        
        
        
        
        output$group_img <- renderImage({
          
          list(src = "groupPic.png",
               width = "8")
          
        }, deleteFile = F)
        
<<<<<<< HEAD
        output$downloadData <- downloadHandler(
          filename = function() {
            "merged_data.csv" 
          },
          content = function(file) {
            write.csv(merged_data, file, row.names = FALSE)
          }
        )
}
=======
  }

>>>>>>> c390604e971f2a09ea21c81cddfb1b1bb4a5c5f9

