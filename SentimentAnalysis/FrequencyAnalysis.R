### In this script we analyze the most frequent words #####################

rm(list = ls())

source("Code/Packages.R")
source("Code/OwnggTheme.R")
source("Code/DataPreparation.R")


dfletters %>%
  count(word, sort = TRUE)
# Not interesting, we need to remove stop words

CleanPopularWords = dfletters %>% 
  anti_join(stop_words) %>%
  count(word, sort = TRUE)
# These words seem to make sense

set.seed(2)
CleanPopularWords %>%
  with(wordcloud(word, n, max.words = 30, scale = c(4,.5)))

