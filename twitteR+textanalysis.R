#Basic text analysis with tweet data obtained via twitteR

library(devtools)
library(twitteR)

APIkey <- "xxxxxxxxxxxxxxxx"
APIsecret <- "xxxxxxxxxxxxxxxx"
accesstoken <- "xxxxxxxxxxxxxxxx"
accesstokensecret <- "xxxxxxxxxxxxxxxx"

setup_twitter_oauth (APIkey, APIsecret, accesstoken, accesstokensecret)

searchTwitter ('Rotterdam + Turkish', n= 1000, since= '2017-03-10')

sink("~/Desktop/Data Analysis/R Studio/twitter-1000-search.txt") # open the sink
sink() # close the sink!

# Load
library("tm")
library("SnowballC")
library("wordcloud")
library("RColorBrewer")

# Read the text file
filePath <- "/Users/metin/Desktop/Data Analysis/R Studio/cookie_eu_trial/All_English_Language_News2017-01-14_15-15.TXT"
text <- readLines(filePath)
# Load the data as a corpus
docs <- Corpus(VectorSource(text))

inspect(docs)

toSpace <- content_transformer(function (x , pattern ) gsub(pattern, " ", x))
docs <- tm_map(docs, toSpace, "/")
docs <- tm_map(docs, toSpace, "@")
docs <- tm_map(docs, toSpace, "\\|")

# Remove punctuations
docs <- tm_map(docs, removePunctuation)
# Convert the text to lower case
docs <- tm_map(docs, content_transformer(tolower))
# Remove numbers
docs <- tm_map(docs, removeNumbers)
# Remove english common stopwords
docs <- tm_map(docs, removeWords, c("your", "which", "has", "they", "also", "you", "who", "but", "there", "will", "the", "and", "this", "into", "its", "their", "would", "was", "were", "one", "two", "still", "should", "how", "such", "get", "that", "for", "are", "not","with","have", "all", "from", "what" )) 

dtm <- TermDocumentMatrix(docs)
m <- as.matrix(dtm)
v <- sort(rowSums(m),decreasing=TRUE)
d <- data.frame(word = names(v),freq=v)
head (d, 20)

#You can analyze the association between frequent terms,
#findAssocs(dtm, terms = "people", corlimit = 0.3)

word_cloud
set.seed(1234)
wordcloud(words = d$word, freq = d$freq, min.freq = 1,
          max.words=200, random.order=FALSE, rot.per=0.35, 
          colors=brewer.pal(8, "Dark2"))


bar_plot
barplot(d[1:20,]$freq, las = 2, names.arg = d[1:20,]$word,
        col ="lightblue", main ="Most Frequent Words",
        ylab = "Word frequencies")
