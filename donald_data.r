###
### Read tweets from Twitter using API
###
 
# loading the package is required once each session
library(twitteR)

# Authorize
setup_twitter_oauth('key', 'key', 'key', 'key')

N=10000  # tweets to request from each query

S <- "2016-05-04"
U <- "2016-05-05"
geo <- "37.090240,-95.712891,4500km"

#donald <- searchTwitter('#DonaldTrump',lang="en",n=N,resultType="recent",geocode=􏰀37.781157,-122.39720,1mi􏰀)
donald_temp <- searchTwitter('#DonaldTrump',lang="en",n=N,resultType="recent", retryOnRateLimit = 5, since=S, until=U, geocode=geo)

if (length(donald_temp) > 1) {
  donald.df <- twListToDF(donald_temp)
  filename <- paste(c("donald_",S,".xlsx"), collapse="")
  write.xlsx(donald.df, filename)
  print(paste("File", filename, "was created successfully."))
} else print("No tweets were retrieved. No files were created. Please retry.")