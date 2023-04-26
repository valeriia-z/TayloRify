# install required packages
# install.packages(c("spotifyr", "plyr", "tidyverse", "httr", "rvest", "stringr", "ggthemes", "tidytext", "wordcloud", "ggridges", "wesanderson", "yarrr", "knitr", "kableExtra", "radarchart", "prettydoc", "geniusr"))

# load required packages
library(spotifyr)
library(plyr)
library(tidyverse)
library(httr)
library(rvest)
library(stringr)
library(ggthemes)
library(tidytext)
library(wordcloud)
library(ggridges)
library(wesanderson)
library(yarrr)
library(knitr)
library(kableExtra)
library(radarchart)
library(prettydoc)
library(geniusr)
# set your Spotify API credentials (need to provide your Client ID and Client Secret)
client_id <- "40e05819d37d49b7a73804c728f1773c" # change to your own crenedtials
client_secret <- "f97f4adeb138417c8a6d052257598b09"

Sys.setenv(SPOTIFY_CLIENT_ID = client_id)
Sys.setenv(SPOTIFY_CLIENT_SECRET = client_secret)

# Generate an access token
access_token <- get_spotify_access_token(client_id, client_secret)

#using spotifyr
taylor <- get_artist_audio_features('taylor swift')




