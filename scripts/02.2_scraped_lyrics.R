library(geniusr)

# Create an empty list to store the lyrics vectors
lyrics_list <- list()

# Set the maximum number of retries for a URL
max_retries <- 15 # big amount, because when less, server is not always giving answer back

# Iterate through each URL in the column
for (url in taylor_lyrics$filtered_track_lyric_urls) {
  # Initialize the number of retries for the current URL
  retries <- 0
  
  # Loop until the maximum number of retries is reached
  while (retries < max_retries) {
    # Try to get the lyrics for the current URL
    result <- tryCatch({
      lyrics_df <- get_lyrics_url(url)
      lyrics_vec <- paste(lyrics_df$line, collapse = " ")
      lyrics_vec
    }, error = function(e) {
      # Print an error message and increment the number of retries
      cat(paste("Error for URL:", url, "\n"))
      retries <<- retries + 1
    })
    
    # If the result is not a character vector, retry the URL
    if (!is.character(result)) {
      # Print a message and wait for a short time before trying again
      cat(paste("Error for URL:", url, "\n"))
      retries <- retries + 1
      Sys.sleep(2)
      next
    }
    
    # If the result is a character vector, add it to the list and break out of the retry loop
    lyrics_list[[length(lyrics_list) + 1]] <- result
    break
  }
}

# Cleaning and standardizing lyrics
for (i in seq_along(lyrics_list)) {
  lyrics_list[i] <- gsub("([a-z])([A-Z])", "\\1 \\2", lyrics_list[i])
  lyrics_list[i] <- gsub("\n", " ", lyrics_list[i])
  lyrics_list[i] <- gsub("\\[.*?\\]", " ", lyrics_list[i])
  lyrics_list[i] <- tolower(lyrics_list[i])
  lyrics_list[i] <- gsub("[ [:punct:] ]", " ", lyrics_list[i])
  lyrics_list[i] <- gsub(" {2,}", " ", lyrics_list[i])
}

# Convert lyrics_list into df
lyrics_list <- data.frame(lyrics = unlist(lyrics_list), stringsAsFactors = FALSE)

# Create df with titles and lyrics
genius_data <- data.frame(track_name = taylor_lyrics$filtered_track_lyric_titles, lyrics = lyrics_list)
genius_data$track_name <- as.character(genius_data$track_name)
genius_data$lyrics <- as.character(genius_data$lyrics_list)

