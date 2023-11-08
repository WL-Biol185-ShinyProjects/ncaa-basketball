library(shiny)
library(leaflet)
library(ggplot2)
library(tidyverse)
library(dplyr)

#Loading data frames
geodf <- read.csv("geodata.csv")

# Recoding Geodf to have column name 2 as TEAM 
colnames(geodf)[2] <- "TEAM"
college_geo <- read.csv("geodata.csv")
bb_data <- read.csv("cbb.csv")
merged_data <- left_join(bb_data, college_geo, by = "TEAM")

function(input,output,session){
  
}
