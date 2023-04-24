# acousticness ridge plot 
spotify_genius %>% ggplot(aes(x = acousticness, y = album_name, fill = ..x..)) + 
  geom_density_ridges_gradient(scale = 0.9) + 
  scale_fill_gradient(low = "white", high = "maroon3") + 
  theme_fivethirtyeight() + 
  theme(panel.background = element_rect(fill = "white")) +
  theme(plot.background = element_rect(fill = "white")) +
  xlim(0,1) +
  theme(legend.position = "none")

# table: album by mean valence
spotify_genius %>% 
  group_by(album_name) %>% 
  summarise(mean(valence)) %>% 
  arrange(desc(`mean(valence)`)) %>% 
  kable() %>% 
  kable_styling("striped", full_width = F, position = "left") %>% 
  row_spec(row = 1:6, background = "#fffce4", color = "red")

# table: top 10 songs by valence
spotify_genius %>% 
  select(track_name, album_name, valence) %>% 
  top_n(10) %>% 
  arrange(-valence) %>% 
  kable() %>% 
  kable_styling("striped", full_width = F, position = "left") %>% 
  row_spec(row = 1:10, background = "azure", color = "deeppink")


# sonic score graph
sonic_score_graph <- pirateplot(valence + danceability + energy ~ album_release_year, spotify_genius,
                                pal = c(wes_palettes$GrandBudapest2, wes_palettes$Moonrise3[1:2]), 
                                xlab = "album", ylab = "sonic score",
                                theme = 0, point.o = 0.7, avg.line.o = 1, jitter.val = .05, 
                                bty = "n", cex.axis = 0.6, xaxt = "n") 
axis(1, cex.axis = 0.6, lwd = 0)
legend("topright", c("1: Taylor Swift", "2: Fearless (Platinum Edition)", "3: Speak Now (Deluxe Edition)", "4: Red (Deluxe Edition)", "5: 1989 (Deluxe Edition)", "6: reputation", "7: Lover", "8: folklore (deluxe version)", "9: evermore (deluxe version)", "10: Midnights (3am Edition)"), bty = "n", cex = 0.4)



# Midnights (3am Edition) sonic scores
spotify_genius %>% 
  mutate(sonic_score = valence + danceability + energy) %>% 
  select(album_name, track_name, sonic_score) %>% 
  arrange(desc(sonic_score)) %>% 
  filter(album_name == "Midnights (3am Edition)") %>% 
  kable() %>% 
  kable_styling(full_width = F, position = "left") %>% 
  row_spec(row = 1:13, background = "seashell", color = "#b39db2")

# album by danceability
spotify_genius %>% 
  group_by(album_name) %>% 
  summarise(mean(danceability)) %>% 
  arrange(desc(`mean(danceability)`)) %>% 
  kable() %>% 
  kable_styling(full_width = F, position = "left") %>% 
  row_spec(row = 1, background = "seashell", color = "#b39db2")


