library(geniusr)

# Create an empty character vector to store the lyrics
lyrics_vec <- character(length(taylor_lyrics$filtered_track_lyric_urls))

# Loop over the URLs and scrape the lyrics
for (i in seq_along(taylor_lyrics$filtered_track_lyric_urls)) {
  url <- taylor_lyrics$filtered_track_lyric_urls[i]
  lyrics_df <- get_lyrics_url(url)
  lyrics_vec[i] <- paste(lyrics_df$line, collapse = " ")
}

# Print the lyrics vector
lyrics_vec

lyrics100 <- data.frame()
for (i in c(1:length(taylor_lyrics$filtered_track_lyric_urls))) {
  print(i)
  print("a")
  url <- taylor_lyrics$filtered_track_lyric_urls[i]
  print("b")
  print(url)
  print(get_lyrics_url(url)[1])
  lyrics_df <- get_lyrics_url(url)
  print("c")
  lyrics_vec<- paste(lyrics_df$line, collapse = " ")
  print("d")
  lyrics100[i,"text"] <- lyrics_vec
}


