# joining the tokenized, tidied lyric dataset with sentiment lexicons
taylor_bing <- tidier_taylor %>% 
  inner_join(get_sentiments("bing"))

# Midnights (3am Edition) pyramid plot
sent_taylor_midnights <- taylor_bing %>%
  unique() %>% 
  group_by(track_name, sentiment, album_name) %>%
  count(track_name, sentiment) %>%
  filter(album_name == "Midnights (3am Edition)")

for(i in 1:33) {
  if(sent_taylor_midnights$sentiment[i] == "negative")
    sent_taylor_midnights$n[i] <- -sent_taylor_midnights$n[i]
}

sent_taylor_midnights %>% 
  ggplot(aes(x = track_name, y = n, fill = sentiment)) + 
  geom_bar(subset = .(sentiment == "positive"), stat = "identity") + 
  geom_bar(subset = .(sentiment == "negative"), stat = "identity") + 
  scale_y_continuous(breaks = seq(-20, 20, 5)) +
  coord_flip() +
  theme_fivethirtyeight() +
  ylim(-20,10) +
  theme(panel.background = element_rect(fill = "white")) +
  theme(plot.background = element_rect(fill = "white")) +
  scale_fill_manual(values = c("palevioletred", "olivedrab3")) +
  theme(legend.position="none")


