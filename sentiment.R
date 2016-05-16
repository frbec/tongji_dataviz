library(stringr)
library(tm)
library(plyr)
library(dplyr)
library(xlsx)

if (!exists("twitter_data")) {
  twitter_data <- read.xlsx("../Datasets/twitter_data.xlsx", 1, colIndex=c(1))
}

tweet <- twitter_data[[1]]

tweet_list=lapply(tweet, function(x) iconv(x, "latin1", "ASCII", sub=""))
tweet_list=lapply(tweet_list, function(x) gsub("htt.*",' ',x))

tweet <- unlist(tweet_list)
twitter_data$tweet <- tweet

positives <- readLines("positive-words.txt")
negatives <- readLines("negative-words.txt")
  
sentiment <- vector()
  for(i in 1:length(twitter_data$tweet)) {
    sentiment[i] <- classify.aggregate(twitter_data$tweet[i], positives, negatives)
}

