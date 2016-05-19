###
### Read tweets from Twitter using API
###
 
# loading the package is required once each session
library(twitteR)

# Authorize with twitter
setup_twitter_oauth('CONSUMER_KEY', 'CONSUMER_SECRET', 'ACCESS_TOKEN', 'ACCESS_SECRET')

N=10000  # tweets to request from each query

S <- "2016-05-04" # start date
U <- "2016-05-05" # end date
geo <- "37.090240,-95.712891,4500km" # latitude, longitude, radius

donald_temp <- searchTwitter('#DonaldTrump',lang="en",n=N,resultType="recent", retryOnRateLimit = 5, since=S, until=U, geocode=geo)

if (length(donald_temp) > 1) {
  donald.df <- twListToDF(donald_temp)
  filename <- paste(c("donald_",S,".xlsx"), collapse="")
  write.xlsx(donald.df, filename)
  print(paste("File", filename, "was created successfully."))
} else print("No tweets were retrieved. No files were created. Please retry.")