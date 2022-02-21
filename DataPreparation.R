### In this script we load in the IMF letters #############################

# Load the necessary packages
#source("Code/Packages.R")


# Function that conveniently processes a letter
# Tokenizing means putting each unit (for this analysis a unit is a word)
# in a seperate row
tokenizeDocument <- function(document, nGramSize) {
  name = as.character(rlang::enexpr(document))
  document = document %>%
    unnest_tokens(word, text, token = "ngrams", n = nGramSize)
  document = document %>% 
    mutate(year = str_sub(name, -4, -1))
  return(document)
}

# Load a letter as a tibble
year2002 = tibble(text = read_file("IMFLetters/2002.txt"))
# Tokenize it 
dfletters1 = tokenizeDocument(year2002, 1)
dfletters2 = tokenizeDocument(year2002, 2)
dfletters3 = tokenizeDocument(year2002, 3)
dfletters4 = tokenizeDocument(year2002, 4)

year2004 = tibble(text = read_file("IMFLetters/2004.txt"))
# Tokenize it and add it to the previous letter(s)
dfletters1 = bind_rows(dfletters1, tokenizeDocument(year2004, 1)) 
dfletters2 = bind_rows(dfletters2, tokenizeDocument(year2004, 2)) 
dfletters3 = bind_rows(dfletters3, tokenizeDocument(year2004, 3)) 
dfletters4 = bind_rows(dfletters4, tokenizeDocument(year2004, 4)) 

year2007 = tibble(text = read_file("IMFLetters/2007.txt"))
dfletters1 = bind_rows(dfletters1, tokenizeDocument(year2007, 1)) 
dfletters2 = bind_rows(dfletters2, tokenizeDocument(year2007, 2)) 
dfletters3 = bind_rows(dfletters3, tokenizeDocument(year2007, 3)) 
dfletters4 = bind_rows(dfletters4, tokenizeDocument(year2007, 4))

year2010 = tibble(text = read_file("IMFLetters/2010.txt"))
dfletters1 = bind_rows(dfletters1, tokenizeDocument(year2010, 1)) 
dfletters2 = bind_rows(dfletters2, tokenizeDocument(year2010, 2)) 
dfletters3 = bind_rows(dfletters3, tokenizeDocument(year2010, 3)) 
dfletters4 = bind_rows(dfletters4, tokenizeDocument(year2010, 4))

year2012 = tibble(text = read_file("IMFLetters/2012.txt"))
dfletters1 = bind_rows(dfletters1, tokenizeDocument(year2012, 1)) 
dfletters2 = bind_rows(dfletters2, tokenizeDocument(year2012, 2)) 
dfletters3 = bind_rows(dfletters3, tokenizeDocument(year2012, 3)) 
dfletters4 = bind_rows(dfletters4, tokenizeDocument(year2012, 4))

year2013 = tibble(text = read_file("IMFLetters/2013.txt"))
dfletters1 = bind_rows(dfletters1, tokenizeDocument(year2013, 1)) 
dfletters2 = bind_rows(dfletters2, tokenizeDocument(year2013, 2)) 
dfletters3 = bind_rows(dfletters3, tokenizeDocument(year2013, 3)) 
dfletters4 = bind_rows(dfletters4, tokenizeDocument(year2013, 4))

year2014 = tibble(text = read_file("IMFLetters/2014.txt"))
dfletters1 = bind_rows(dfletters1, tokenizeDocument(year2014, 1)) 
dfletters2 = bind_rows(dfletters2, tokenizeDocument(year2014, 2)) 
dfletters3 = bind_rows(dfletters3, tokenizeDocument(year2014, 3)) 
dfletters4 = bind_rows(dfletters4, tokenizeDocument(year2014, 4))

year2016 = tibble(text = read_file("IMFLetters/2016.txt"))
dfletters1 = bind_rows(dfletters1, tokenizeDocument(year2016, 1)) 
dfletters2 = bind_rows(dfletters2, tokenizeDocument(year2016, 2)) 
dfletters3 = bind_rows(dfletters3, tokenizeDocument(year2016, 3)) 
dfletters4 = bind_rows(dfletters4, tokenizeDocument(year2016, 4))

year2017 = tibble(text = read_file("IMFLetters/2017.txt"))
dfletters1 = bind_rows(dfletters1, tokenizeDocument(year2017, 1)) 
dfletters2 = bind_rows(dfletters2, tokenizeDocument(year2017, 2)) 
dfletters3 = bind_rows(dfletters3, tokenizeDocument(year2017, 3)) 
dfletters4 = bind_rows(dfletters4, tokenizeDocument(year2017, 4))

year2018 = tibble(text = read_file("IMFLetters/2018.txt"))
dfletters1 = bind_rows(dfletters1, tokenizeDocument(year2018, 1)) 
dfletters2 = bind_rows(dfletters2, tokenizeDocument(year2018, 2)) 
dfletters3 = bind_rows(dfletters3, tokenizeDocument(year2018, 3)) 
dfletters4 = bind_rows(dfletters4, tokenizeDocument(year2018, 4))

year2019 = tibble(text = read_file("IMFLetters/2019.txt"))
dfletters1 = bind_rows(dfletters1, tokenizeDocument(year2019, 1)) 
dfletters2 = bind_rows(dfletters2, tokenizeDocument(year2019, 2)) 
dfletters3 = bind_rows(dfletters3, tokenizeDocument(year2019, 3)) 
dfletters4 = bind_rows(dfletters4, tokenizeDocument(year2019, 4)) 

year2021 = tibble(text = read_file("IMFLetters/2021.txt"))
dfletters1 = bind_rows(dfletters1, tokenizeDocument(year2021, 1)) 
dfletters2 = bind_rows(dfletters2, tokenizeDocument(year2021, 2)) 
dfletters3 = bind_rows(dfletters3, tokenizeDocument(year2021, 3)) 
dfletters4 = bind_rows(dfletters4, tokenizeDocument(year2021, 4))

# We now created a dataframe that stores all words in a convenient way 
# It also allows us to keep track of the year in which it was published
