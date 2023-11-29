library(shiny)
library(tidyverse)
library(leaflet)
library(ggplot2)
library(geojsonio)
library(dplyr)

conf_stats <- read.csv("conference_stats.csv")

<<<<<<< HEAD
server <- function(input, output, session){
 
=======
function(input,output,session){
>>>>>>> 9a340ebbbd93ce8acd1de7a41ecda70d2a78f163
  output$plot <- renderPlot({
    
    ggplot(data=conf_stats, aes_string(x='Conference',
                                       y=input$y_var)) +
      geom_bar(stat = "identity", width = 0.8) +
      labs(x="Conference", y=input$y_var)
  })
}