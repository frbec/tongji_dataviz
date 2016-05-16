# Sentiment plot

library(stringr)
library(tm)
library(plyr)
library(dplyr)

sentiment_date <- read.csv2("../Datasets/sentiment_date.csv")

opinions <- count(sentiment_date$created, sentiment_date$sentiment)