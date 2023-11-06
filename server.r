server <- function(input,output,session
                )
{
  
<<<<<<< HEAD


  
library(ggplot2)
library(tidyverse)

#Loading data frames
geodf <- read.csv("geodata.csv")

# Recoding Geodf to have column name 2 as TEAM 
colnames(geodf)[2] <- "TEAM"
college_geo <- read.csv("geodata.csv")
bb_data <- read.csv("cbb.csv")

library(dplyr)
merged_data <- left_join(bb_data, college_geo, by = "TEAM")



#   merged_data %>%
#     group_by(CONF) %>%
#     summarize(AvgFTR = mean(FTR)) %>%
#     arrange(AvgFTR) %>%
#     mutate(CONF = factor(CONF, levels = CONF, ordered = TRUE)) %>%
#     ggplot(aes(CONF, AvgFTR)) + geom_bar(stat = 'identity') + theme(axis.text.x = element_text(angle = 60, hjust = 1))
# 
#   
}
  
=======
  library(ggplot2)
  library(tidyverse)
  merged_data %>%
    group_by(CONF) %>%
    summarize(AvgFTR = mean(FTR)) %>%
    arrange(AvgFTR) %>%
    mutate(CONF = factor(CONF, levels = CONF, ordered = TRUE)) %>%
    ggplot(aes(CONF, AvgFTR)) + geom_bar(stat = 'identity') + theme(axis.text.x = element_text(angle = 60, hjust = 1))
}
>>>>>>> ba17c9bd3490aefdf048c3591f22becff6ec116d
