# joining the tokenized, tidied lyric dataset with sentiment lexicons
taylor_nrc_sub <- tidier_taylor %>%
  inner_join(get_sentiments("nrc")) %>%
  filter(!sentiment %in% c("positive", "negative"))

# all-album radar chart
sentiment_nrc <- taylor_nrc_sub %>%
  group_by(album_name, sentiment) %>%
  count(album_name, sentiment) %>% 
  select(album_name, sentiment, sentiment_total = n)

album_nrc <- taylor_nrc_sub %>%
  count(album_name) %>% 
  select(album_name, album_total = n)

radar_chart <- sentiment_nrc %>% 
  inner_join(album_nrc, by = "album_name") %>% 
  mutate(percent = round((sentiment_total/album_total * 100), 3)) %>% 
  select(-sentiment_total, -album_total) %>%
  spread(album_name, percent)

radar_chart <- radar_chart[c(2,7,5,8,4,3,1,6), c(1, 7:2)]

chartJSRadar(radar_chart, polyAlpha = 0.05, lineAlpha = 0.8, maxScale = 25, width = 1000, height = 1000)


