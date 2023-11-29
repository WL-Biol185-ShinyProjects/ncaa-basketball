library(shiny)
library(tidyverse)
library(leaflet)
library(ggplot2)
library(dplyr)

conf_stats <- read.csv("conference_stats.csv")
 
function(input,output,session){
  output$plot <- renderPlot({
    
    ggplot(data=conf_stats, aes_string(x='Conference',
                                       y=input$y_var)) +
      geom_bar(stat = "identity", width = 0.8) +
      labs(x="Conference", y=input$y_var)
  })
}