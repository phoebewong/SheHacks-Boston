library(tidyverse)
survey.df <- read_csv("./data/prof_is_in.csv")
colnames(survey.df)[15] <- "gen_har"
colnames(survey.df)[5] <- "inst_type"
colnames(survey.df)[7] <- "Field"
survey.df$gen_har[survey.df$gen_har == "Man"] <- "Male"
survey.df$Field <- parse_character(survey.df$Field)
# gender
# institution

# Twitter data
tweet.df <- read_csv("./data/MeToo_Data.csv")
orig_tweet_list <- str_split(tweet.df$text[tweet.df$retweet == "False"], " ")
rt_tweet_list <- str_split(tweet.df$text[tweet.df$retweet == "True"], " ")
# tweet_RT.df <- read_csv("./data/MeToo_ReTweets.csv")