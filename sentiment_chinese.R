library(stringr)
library(tm)
library(plyr)
library(dplyr)
library(xlsx)
library(sentR)

if (!exists("weibo_data")) {
  weibo_data <- read.xlsx("../Datasets/weibo_content.xlsx", 1, colIndex=c(1))
}

message <- weibo_data[[1]]

#wb_list=lapply(wb_list, function(x) gsub("htt.*",' ',x))

weibo_data$message <- message

positives <- readLines("ntusd-positive.txt")
negatives <- readLines("ntusd-negative.txt")
  
sentiment <- vector()
  for(i in 1:length(weibo_data$message)) {
    sentiment[i] <- classify.aggregate(weibo_data$message[i], positives, negatives) # This is the library sentR that calculates sentiments
}

