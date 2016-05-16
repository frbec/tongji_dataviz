library(stringr)
library(tm)
library(plyr)
library(dplyr)
library(xlsx)
library(wordcloud)

date <- "2016-05-03"

filename <- paste(c("../Datasets/donald_",date,".xlsx"), collapse="")
#filename <- paste(c("../Datasets/donald_",date,".csv"), collapse="")

tweets <- read.xlsx("../Datasets/twitter_data_noRT.xlsx", 1, colIndex=c(1))
#tweets <- read.csv(filename)
print("Read file OK")

# Create corpus
corpus <- Corpus(VectorSource(tweets))
# Convert to plain text
corpus <- tm_map(corpus, PlainTextDocument)
# remove extra white space
corpus <- tm_map(corpus, stripWhitespace)
# remove punctuation
corpus <- tm_map(corpus, removePunctuation)
# convert to lowercase
corpus <- tm_map(corpus, content_transformer(tolower))
# Remove stopwords
corpus <- tm_map(corpus, removeWords, stopwords("english"))

tweet.tdm <- TermDocumentMatrix(corpus, control = list(minWordLenght = 3))

words <- sort(rowSums(as.matrix(tweet.tdm)), decreasing=TRUE)
words.df <- data.frame(word = names(words), freq=words)
words.df[1] <- NULL

#writename <- paste(c("word_frequency_", date, ".xlsx"), collapse="")
writename <- paste(c("word_frequency_baidu.xlsx"), collapse="")
write.xlsx(words.df, writename)

col <- brewer.pal(6,"Dark2")
wordcloud(corpus, min.freq=2, scale=c(5,1),rot.per = 0.25,
          random.color=T, max.word=45, random.order=F,colors=col)


  