function(input,output, session) {
  
}

geodf <- read.csv("geodata.csv")
colnames(geodf)[2] <- "TEAM"
write.csv(geodf, "geodata.csv", row.names=FALSE)

college_geo <- read.csv("geodata.csv")
bb_data <- read.csv("cbb.csv")

library(dplyr)
merged_data <- left_join(bb_data, college_geo, by = "TEAM")

library(leaflet)
leaflet(data = merged_data) %>% setView(lng = -95.71, lat = 37.09, zoom =3) %>% 
  addTiles() %>%
  addCircleMarkers(radius = 1, label = ~TEAM)

#Conference Tab:

#Output for Bar Graphs  
output$BarGraphs <- renderTable(
  
)