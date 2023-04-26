
# wordcloud: all
word_count <- tidier_taylor %>%
  count(word, sort = TRUE) %>% 
  mutate(word = reorder(word, n)) %>%
  ungroup()

wordcloud(words = word_count$word, freq = word_count$n,
          max.words=100, random.order=FALSE, 
          colors= c(wes_palettes$Moonrise3[c(1:2,5)], wes_palettes$Royal2[5]))

# how many tracks does the word "love" appear in?
tidier_taylor %>% 
  select(track_name, word) %>% 
  filter(word == "love") %>% 
  unique() %>% 
  select(track_name)

# wordcloud: Midnights (3am Edition) the album
word_count_ts <- tidier_taylor %>%
  filter(album_name == "Midnights (3am Edition)") %>% 
  count(word, sort = TRUE) %>% 
  mutate(word = reorder(word, n)) %>%
  ungroup()

wordcloud(words = word_count_ts$word, freq = word_count_ts$n,
          max.words=25, random.order=FALSE, 
          colors= c(wes_palettes$GrandBudapest2[3:1]))



