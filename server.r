library(shiny)
library(leaflet)
library(ggplot2)
library(tidyverse)
library(plyr)

#Loading data frames
geodf <- read.csv("geodata.csv")

# Recoding Geodf to have column name 2 as TEAM 
colnames(geodf)[2] <- "TEAM"
college_geo <- read.csv("geodata.csv")
bb_data <- read.csv("cbb.csv")
merged_data <- left_join(bb_data, college_geo, by = "TEAM")

# Fixing the column names in merged data
merged_data %>%
  plyr::rename(
    CONF = Conference,
    G = Number.of.Games.Played,
    W = Number.of.Wins,
    ADJOE = Adjusted.Offensive.Efficency,
    ADJDE = Adjusted.Defensive.Efficiency,
    BARTHAG = Power.Rating,
    EFG_O = Effective.Field.Goal.Percentage.Shot,
    EFG_D = Effective.Field.Goal.Percentage.Allowed,
    TOR = Turnover.Percentage.Rate,
    TORD = Steal.Rate,
    ORB = Offensive.Rebound.Rate,
    DRB = Offensive.Rebound.Rate.Allowed,
    FTR = Free.Throw.Rate,
    FTRD = Free.Throw.Rate.Allowed,
    X2P_O = Two.Point.Shooting.Range,
    X2P_D = Two.Point.Shooting.Range.Allowed,
    X3P_O = Three.Point.Shooting.Range.Allowed,
    X3P_D = Three.Point.Shooting.Range.Allowed,
    ADJ_T = Adjusted.Tempo,
    WAB = Wins.Above.Bubble)


function(input,output,session){
  output$plot <- renderPlot({
    
    ggplot(data=merged_data, aes_string(x='CONF',
                                        y=input$y_var)) +
                                        geom_bar(stat = "identity", width = 0.8) +
                                        labs(x="CONF", y=input$y_var)
  })
}


