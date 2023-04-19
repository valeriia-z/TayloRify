install.packages("httr")
install.packages("spotifyr")
library(httr)
library(spotifyr)

# set your Spotify API credentials (need to provide your Client ID and Client Secret)
client_id <- "40e05819d37d49b7a73804c728f1773c"
client_secret <- "f97f4adeb138417c8a6d052257598b09"

# Generate an access token
access_token <- get_spotify_access_token(client_id, client_secret)

# Set the authorization header using the access token
headers <- add_headers(Authorization = paste0("Bearer ", access_token))

# Search for Taylor Swift's artist ID
artist_name <- "Taylor Swift"
artist_id <- "06HL4z0CvFAxyc27GXpf02"

# Get Taylor Swift's albums
albums <- get_artist_albums(artist_id, authorization = access_token)
