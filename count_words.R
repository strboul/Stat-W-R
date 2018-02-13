# Load
library("tm")
library("SnowballC")
library("wordcloud")
library("RColorBrewer")

# Read the text file
filePath <- "/Users/metin/Desktop/Data Analysis/R Studio/textfile2.txt"
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
docs <- tm_map(docs, removeWords, c("your", "you", "who", "but", "there", "will", "the", "and", "this", "that", "for", "are", "not","with","have", "all", "from", "what")) 

dtm <- TermDocumentMatrix(docs)
m <- as.matrix(dtm)
v <- sort(rowSums(m),decreasing=TRUE)
d <- data.frame(word = names(v),freq=v)
head (d, 15)

#You can analyze the association between frequent terms,
#(i.e., terms which correlate) using findAssocs() function.
#The R code below identifies which words are associated with "word."
findAssocs(dtm, terms = "people", corlimit = 0.3)
findAssocs(dtm, terms = "sorry", corlimit = 0.3)
findAssocs(dtm, terms = "hope", corlimit = 0.3)
findAssocs(dtm, terms = "lobster", corlimit = 0.3)
findAssocs(dtm, terms = "good", corlimit = 0.3)

#word_cloud
set.seed(1234)
wordcloud(words = d$word, freq = d$freq, min.freq = 1,
          max.words=200, random.order=FALSE, rot.per=0.35, 
          colors=brewer.pal(8, "Dark2"))


#bar_plot
barplot(d[1:10,]$freq, las = 2, names.arg = d[1:10,]$word,
        col ="lightblue", main ="10 Most Frequent Words",
ylab = "Word frequencies")
