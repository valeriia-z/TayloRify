# creating a "lexical diversity" dataset
lexical_diversity <- tidy_taylor %>% group_by(track_name, album_release_year) %>% 
  mutate(lex_div = length(unique(word))/length(word)) %>% 
  select(track_name, lex_div, album_release_year) %>% 
  distinct()


# lexical diversity plot
pirateplot(lex_div ~ album_release_year, lexical_diversity,
           pal = c("cyan3", "darkgoldenrod1", "maroon4", "red3", "#b39db2", "black"),
           xlab = "album", ylab = "lexical diversity",
           theme = 0, point.o = 0.5, avg.line.o = 1, jitter.val = .05, 
           bty = "n", cex.axis = 0.6, xaxt = "n") 
axis(1, cex.axis = 0.6, lwd = 0)
legend("topright", c("1: Taylor Swift", "2: Fearless (Platinum Edition)", "3: Speak Now (Deluxe Edition)", "4: Red (Deluxe Edition)", "5: 1989 (Deluxe Edition)", "6: reputation", "7: Lover", "8: folklore (deluxe version)", "9: evermore (deluxe version)", "10: Midnights (3am Edition)"), bty = "n", cex = 0.6)


# most lexically diverse tracks
tidy_taylor %>% group_by(track_name, album_name) %>% 
  mutate(lex_div = length(unique(word))/length(word)) %>% 
  select(track_name, lex_div, album_name) %>% 
  arrange(desc(lex_div)) %>% 
  distinct() %>% 
  head(10) %>% 
  kable() %>% 
  kable_styling(full_width = F, position = "left") %>% 
  row_spec(row = 1:10, background = "azure", color = "palevioletred")
