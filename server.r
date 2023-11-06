function(input,output) {

  geodf <- read.csv("geodata.csv")
  colnames(geodf)[2] <- "TEAM"
  write.csv(geodf, "geodata.csv", row.names=FALSE)
  
  college_geo <- read.csv("geodata.csv")
  bb_data <- read.csv("cbb.csv")
  
  library(dplyr)
  merged_data <- left_join(bb_data, college_geo, by = "TEAM")
  
  
  library(ggplot2)
  library(tidyverse)
  merged_data %>%
    group_by(CONF) %>%
    summarize(AvgFTR = mean(FTR)) %>%
    arrange(AvgFTR) %>%
    mutate(CONF = factor(CONF, levels = CONF, ordered = TRUE)) %>%
    ggplot(aes(CONF, AvgFTR)) + geom_bar(stat = 'identity') + theme(axis.text.x = element_text(angle = 60, hjust = 1))
}