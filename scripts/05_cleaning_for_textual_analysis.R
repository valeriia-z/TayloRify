# tokenized and cleaned datasets of lyrics for textual analysis
tidy_taylor <- spotify_genius %>% unnest_tokens(word, lyrics)
tidier_taylor <- tidy_taylor %>% anti_join(rbind(stop_words[1], "uh", "yeah", "hey", "baby", "ooh", "wanna", "gonna", "ah", "ahh", "ha", "la", "mmm", "whoa", "haa"))
tidier_taylor$word[tidier_taylor$word == "don" | tidier_taylor$word == "didn"] <- NA
tidier_taylor$word[tidier_taylor$word == "ain"] <- NA
tidier_taylor$word[tidier_taylor$word == "isn"] <- NA
tidier_taylor$word[tidier_taylor$word == "usin"] <- "using"
tidier_taylor$word[tidier_taylor$word == "wouldn"] <- "wouldn't"
tidier_taylor$word[tidier_taylor$word == "couldn"] <- "couldn't"
tidier_taylor$word[tidier_taylor$word == "shouldn"] <- "shouldn't"
tidier_taylor$word[tidier_taylor$word == "won"] <- "won't"
tidier_taylor$word[tidier_taylor$word == "ve" | tidier_taylor$word == "ll"] <- NA
tidier_taylor$word[tidier_taylor$word == "ileft"] <- "left"

# more cleaning, can be done earlier
tidier_taylor$album_release_year <- as.character(tidier_taylor$album_release_year)
tidier_taylor$album_release_year <- as.numeric(substr(tidier_taylor$album_release_year, 1, 4))

tidy_taylor$album_release_year <- as.character(tidy_taylor$album_release_year)
tidy_taylor$album_release_year <- as.numeric(substr(tidy_taylor$album_release_year, 1, 4))

