function(input,output) {
  
}
  
geodf <- read.csv("geodata.csv")
colnames(geodf)[2] <- "TEAM"
write.csv(geodf, "geodata.csv", row.names=FALSE)

college_geo <- read.csv("geodata.csv")
bb_data <- read.csv("cbb.csv")

library(dplyr)
merged_data <- left_join(bb_data, college_geo, by = "TEAM")