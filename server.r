library(shiny)
library(dplyr)
library(ggplot2)
library(tidyverse)
library(leaflet)

geodf <- read.csv("geodata.csv")
colnames(geodf)[2] <- "TEAM"
write.csv(geodf, "geodata.csv", row.names=FALSE)

college_geo <- read.csv("geodata.csv")
bb_data <- read.csv("cbb.csv")

merged_data <- left_join(bb_data, college_geo, by = "TEAM")
colnames(merged_data)[2] <- "TEAM"
colnames(merged_data)[2] <- "Conference"
colnames(merged_data)[5] <- "Adjusted Offensive Efficiency"
colnames(merged_data)[6] <- "Adjusted Defensive Efficiency"
colnames(merged_data)[7] <- "Power Rating"
colnames(merged_data)[8] <- "Effective Field Goal Percentage Shot"
colnames(merged_data)[9] <- "Effective Field Goal Percentage Allowed"
colnames(merged_data)[10] <- "Turnover Percentage"
colnames(merged_data)[11] <- "Steal Rate"
colnames(merged_data)[12] <- "Offensive Rebound Rate"
colnames(merged_data)[13] <- "Offensive Rebound Rate Allowed"
colnames(merged_data)[14] <- "Free Throw Rate"
colnames(merged_data)[15] <- "Free Throw Rate Allowed"
colnames(merged_data)[16] <- "Two Point Shooting Range"
colnames(merged_data)[17] <- "Two Point Shooting Range Allowed"
colnames(merged_data)[18] <- "Three Point Shooting Range"
colnames(merged_data)[19] <- "Three Point Shooting Range Allowed"
colnames(merged_data)[20] <- "Adjusted Tempo"
colnames(merged_data)[21] <- "Wins Above Bubble"
df = subset(merged_data, select = -c(TEAM, G, W, POSTSEASON, SEED, YEAR, UNITID, STREET, CITY, STATE, ZIP, STFIP, NMCNTY, LOCALE, LAT, LON, CBSA, NMCBSA, CBSATYPE, CSA, NMCSA, NMNECTA, CD, SLDL, SLDU, SCHOOLYEAR, CNTY, NECTA))
        
function(input,output,session){
  output$plot <- renderPlot({
    
    ggplot(data=df, aes_string(x='Conference',
                                        y=input$y_var)) +
                                        geom_bar(stat = "identity", width = 0.8) +
                                        labs(x="CONF", y=input$y_var)
                                        labs(x="Conference", y=input$y_var)

  })
}
