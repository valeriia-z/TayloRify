# exclude repeated lyrics for re-recorded songs 
taylor <- taylor[!grepl("Taylor's Version", taylor$track_name),]

# joining Spotify and Genius data
spotify_genius <- full_join(genius_data, taylor, by = "track_name")

# filtering for studio albums of interest

studio_albums <- c("Red (Deluxe Edition)", "Lover", "Midnights (3am Edition)", "Taylor Swift", 
                   "1989 (Deluxe Edition)", "Speak Now (Deluxe Edition)", "Fearless (Platinum Edition)", 
                   "reputation", "evermore (deluxe version)", "folklore (deluxe version)")
spotify_genius <- spotify_genius %>%
  filter(album_name %in% studio_albums)

spotify_genius <- spotify_genius[!duplicated(spotify_genius$track_name), ]






