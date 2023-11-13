function(input,output, session) {
  
}

geodf <- read.csv("geodata.csv")
colnames(geodf)[2] <- "TEAM"
colnames(geodf)[2] <- "Conference"
colnames(geodf)[5] <- "Adjusted Offensive Efficiency"
colnames(geodf)[6] <- "Adjusted Defensive Efficiency"
colnames(geodf)[7] <- "Power Rating"
colnames(geodf)[8] <- "Effective Field Goal Percentage Shot"
colnames(geodf)[9] <- "Effective Field Goal Percentage Allowed"
colnames(geodf)[10] <- "Turnover Percentage"
colnames(geodf)[11] <- "Steal Rate"
colnames(geodf)[12] <- "Offensive Rebound Rate"
colnames(geodf)[13] <- "Offensive Rebound Rate Allowed"
colnames(geodf)[14] <- "Free Throw Rate"
colnames(geodf)[15] <- "Free Throw Rate Allowed"
colnames(geodf)[16] <- "Two Point Shooting Range"
colnames(geodf)[17] <- "Two Point Shooting Range Allowed"
colnames(geodf)[18] <- "Three Point Shooting Range"
colnames(geodf)[19] <- "Three Point Shooting Range Allowed"
colnames(geodf)[20] <- "Adjusted Tempo"
colnames(geodf)[21] <- "Wins Above Bubble"
college_geo <- read.csv("geodata.csv")
bb_data <- read.csv("cbb.csv")
merged_data <- left_join(bb_data, college_geo, by = "TEAM")
college_geo <- read.csv("geodata.csv")
bb_data <- read.csv("cbb.csv")
merged_data <- left_join(bb_data, college_geo, by = "TEAM")

function(input,output,session){
  output$plot <- renderPlot({
    
    ggplot(data=merged_data, aes_string(x='CONF',
                                        y=input$y_var)) +
                                        geom_bar(stat = "identity", width = 0.8) +
                                        labs(x="CONF", y=input$y_var)
  output$map <- renderLeaflet
  #finish server for leaflet maps
  })
}
