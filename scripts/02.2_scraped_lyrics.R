library(geniusr)

# Create an empty list to store the lyrics vectors
lyrics_list <- list()

# Set the maximum number of retries for a URL
max_retries <- 10

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
      Sys.sleep(5)
      next
    }
    
    # If the result is a character vector, add it to the list and break out of the retry loop
    lyrics_list[[length(lyrics_list) + 1]] <- result
    break
  }
}
