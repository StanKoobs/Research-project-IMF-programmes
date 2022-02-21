### In this script we perform the sentiment analysis ######################

rm(list = ls())

setwd(file.path("C:/Users/stank/Documents/Jaar 4 uni/",
                "RA Saliha Metinsoy/TurkeyIMFSentimentAnalysis"))

source("Code/Packages.R")
source("Code/OwnggTheme.R")
source("Code/DataPreparation.R")

get_sentiments("afinn")
get_sentiments("bing")
get_sentiments("nrc")

### First using the bing dictionary

# Find all words in dataset that have a bing sentiment
bingsentiments = dfletters %>%
  inner_join(get_sentiments("bing"))

# Count all positive and negatives and deduct them from each other 
totalsentiments = bingsentiments %>% 
  group_by(year) %>% 
  count(year, sentiment) %>%
  pivot_wider(names_from = sentiment, values_from = n, values_fill = 0) %>%
  mutate(sentiment = positive - negative) %>%
  mutate(method = "bing")

# Dataset with these values
totalsentiments

# Plot of absolute sentiments
ggplot(totalsentiments, aes(year, sentiment)) +
  geom_col(fill = "skyblue") +
  ThesisggTheme() +
  ggtitle("Sentiment plot over the years of IMF letters Turkey")

# Create dataset in which sentiments are proportions 
weightedsentiment = totalsentiments %>%
  mutate(weightedsentiment = sentiment / (negative + positive))

# Relative sentiment plot
ggplot(weightedsentiment, aes(year, weightedsentiment)) +
  geom_col(fill = "skyblue") +
  ThesisggTheme() +
  ggtitle("Relative sentiment plot over the years of IMF letters Turkey")

# Relative sentiment plot using a line
# Seems less readable
ggplot(weightedsentiment, aes(x = as.double(year), y = weightedsentiment)) +
  geom_line(colour = "skyblue", size = 1.5) +
  ThesisggTheme() +
  ggtitle("Relative sentiment plot over the years of IMF letters Turkey")



### Now using the AFINN dictionary

afinn = dfletters %>%
  inner_join(get_sentiments("afinn")) %>%
  group_by(year) %>%
  summarise(sentiment = sum(value)) %>%
  mutate(method = "afinn")
  
ggplot(afinn, aes(year, sentiment)) +
  geom_col(fill = "skyblue") +
  ThesisggTheme() +
  ggtitle("Sentiment plot over the years of IMF letters Turkey")



### Now using NRC


nrc = dfletters %>%
  inner_join(get_sentiments("nrc")) %>%
  group_by(year) %>% 
  count(year, sentiment) %>%
  pivot_wider(names_from = sentiment, values_from = n, values_fill = 0) %>%
  mutate(sentiment = positive - negative) %>%
  mutate(method = "nrc")

ggplot(nrc, aes(year, sentiment)) +
  geom_col(fill = "skyblue") +
  ThesisggTheme() +
  ggtitle("Sentiment plot over the years of IMF letters Turkey")



### Comparison

totaldf = bind_rows(totalsentiments, afinn, nrc)

totaldf %>%
  ggplot(aes(year, sentiment, fill = method)) +
  geom_col(fill = "skyblue") +
  facet_wrap(~method, ncol = 1, scales = "free_y") +
  ThesisggTheme() +
  ggtitle("Sentiment plot of IMF letters about Turkey using three different dictionaries") +
  xlab("Year") +
  ylab("Sentiment")






