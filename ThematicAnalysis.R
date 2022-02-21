### In this script we perform the thematic analysis ########################

rm(list = ls())

setwd(file.path("C:/Users/stank/Documents/Jaar 4 uni/",
                "RA Saliha Metinsoy/TurkeyIMFSentimentAnalysis"))

source("Code/Packages.R")
source("Code/OwnggTheme.R")
source("Code/DataPreparation.R")

get_sentiments("nrc")

themes = read.xlsx("ThemesEnglish.xlsx", 1)

library(stringr)

# Find one letter themes

onewordtheme = dfletters1 %>%
  inner_join(themes[str_count(themes$word, "\\w+") == 1, ]) %>%
  group_by(year) %>% 
  count(year, theme)

# Find two letter themes

twowordtheme = dfletters2 %>%
  inner_join(themes[str_count(themes$word, "\\w+") == 2, ]) %>%
  group_by(year) %>% 
  count(year, theme)

# Find three letter themes

threewordtheme = dfletters3 %>%
  inner_join(themes[str_count(themes$word, "\\w+") == 3, ]) %>%
  group_by(year) %>% 
  count(year, theme)

# Find four letter themes

fourwordtheme = dfletters4 %>%
  inner_join(themes[str_count(themes$word, "\\w+") == 4, ]) %>%
  group_by(year) %>% 
  count(year, theme)


totaltheme = bind_rows(onewordtheme, 
                       twowordtheme, 
                       threewordtheme, 
                       fourwordtheme) %>%
  count(year, theme, n)
  
totaltheme = tibble(year = rep(c(2002, 2004, 2007, 2010, 2012, 2013, 2014, 
                             2016, 2017, 2018, 2019, 2021), each = 4),
                    theme = rep(c("public spending", "inflation", 
                                "domestic demand and credit", 
                                "taxation"), 12), 
                    n = rep(0, 4 * 12))


addcount = function(df) {
  for (i in 1:nrow(df)) {
    n = as.numeric(df[i, "n"])
    totaltheme[totaltheme$year == df$year[i] & 
                 totaltheme$theme == df$theme[i], "n"] = 
      totaltheme[totaltheme$year == df$year[i] & 
                   totaltheme$theme == df$theme[i], "n"] + n
  }
  return(totaltheme)
}
  
totaltheme = addcount(onewordtheme)
totaltheme = addcount(twowordtheme)
totaltheme = addcount(threewordtheme)
totaltheme = addcount(fourwordtheme)


ggplot(totaltheme[totaltheme$theme == "public spending", ], 
       aes(as.character(year), n)) +
  geom_col(fill = "skyblue") +
  ThesisggTheme() +
  ggtitle('Frequency of the theme "public spending" over time') +
  xlab("Year") +
  ylab("Frequency")

ggplot(totaltheme[totaltheme$theme == "inflation", ], 
       aes(as.character(year), n)) +
  geom_col(fill = "skyblue") +
  ThesisggTheme() +
  ggtitle('Frequency of the theme "inflation" over time') +
  xlab("Year") +
  ylab("Frequency")

ggplot(totaltheme[totaltheme$theme == "domestic demand and credit", ], 
       aes(as.character(year), n)) +
  geom_col(fill = "skyblue") +
  ThesisggTheme() +
  ggtitle('Frequency of the theme "domestic demand and credit" over time') +
  xlab("Year") +
  ylab("Frequency")


ggplot(totaltheme[totaltheme$theme == "taxation", ], 
       aes(as.character(year), n)) +
  geom_col(fill = "skyblue") +
  ThesisggTheme() +
  ggtitle('Frequency of the theme "taxation" over time') +
  xlab("Year") +
  ylab("Frequency")



