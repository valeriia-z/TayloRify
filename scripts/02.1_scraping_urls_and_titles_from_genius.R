# Getting artist ID on Genius
token <- "OaIcxlLU0bUmqFRotgQ_uhgx1kkXccvlho7m3DE2qqVuuYbdoPeb5XTVUXBhG00Q" # my token from Genius API

genius_get_artists <- function(artist_name, n_results = 10) {
  baseURL <- 'https://api.genius.com/search?q=' 
  requestURL <- paste0(baseURL, gsub(' ', '%20', artist_name),
                       '&per_page=', n_results,
                       '&access_token=', token)
  
  res <- GET(requestURL) %>% content %>% .$response %>% .$hits
  
  map_df(1:length(res), function(x) {
    tmp <- res[[x]]$result$primary_artist
    list(
      artist_id = tmp$id,
      artist_name = tmp$name
    )
  }) %>% unique
}

genius_artists <- genius_get_artists('taylor swift')

# Getting track urls
baseURL <- 'https://api.genius.com/artists/' 
requestURL <- paste0(baseURL, genius_artists$artist_id[1], '/songs')

track_lyric_urls <- list()
i <- 1
while (i > 0) {
  tmp <- GET(requestURL, query = list(access_token = token, per_page = 50, page = i)) %>% content %>% .$response
  track_lyric_urls <- c(track_lyric_urls, tmp$songs)
  if (!is.null(tmp$next_page)) {
    i <- tmp$next_page
  } else {
    break
  }
}

# Filtering to get urls only for tracks on which Taylor Swift is the primary artist
filtered_track_lyric_urls <- c()
filtered_track_lyric_titles <- c()
index <- c()


for (i in 1:length(track_lyric_urls)) {
  if (track_lyric_urls[[i]]$primary_artist$name == "Taylor Swift") {
    filtered_track_lyric_urls <- append(filtered_track_lyric_urls, track_lyric_urls[[i]]$url)
    filtered_track_lyric_titles <- append(filtered_track_lyric_titles, track_lyric_urls[[i]]$title)
    
    index <- append(index, i)
  }
}

# create df to store titles of tracks and URLs on genius for future scraping

taylor_lyrics <- data.frame(filtered_track_lyric_urls, filtered_track_lyric_titles)
taylor_lyrics <- taylor_lyrics[filtered_track_lyric_titles %in% taylor$track_name, ]

taylor_lyrics$filtered_track_lyric_urls <- as.character(taylor_lyrics$filtered_track_lyric_urls)
taylor_lyrics$filtered_track_lyric_titles <- as.character(taylor_lyrics$filtered_track_lyric_titles)


