# Get Taylor Swift's albums
albums <- get_artist_albums(artist_id, authorization = access_token)

# Initialize an empty list to store all tracks from all albums
album_tracks <- list()

# Loop through each album in the albums dataframe
for (i in seq_along(albums$id)) {
  album_name <- albums$name[i]
  album_id <- albums$id[i]
  tracks <- get_album_tracks(album_id, authorization = access_token) # Retrieve the album tracks
  album_tracks[[album_name]] <- tracks
}

# Combine all the tracks into one data frame
all_tracks <- do.call(rbind, album_tracks)


# Combine all tracks from all albums into a single dataframe
all_tracks <- do.call(rbind, album_tracks)

