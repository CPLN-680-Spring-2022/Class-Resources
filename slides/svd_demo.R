library(dplyr)
library(tidyr)
library(ggplot2)
library(sf)

df_major <- readRDS("C:/Users/Jonathan Tannen/Dropbox/sixty_six/data/processed_data/df_major_20210118.Rds")

df_turnout <- df_major %>%
  filter(
    election_type == "general",
    is_topline_office,
    ward != "99"
  ) %>%
  group_by(ward, year) %>%
  summarise(votes=sum(votes), .groups="drop") %>%
  mutate(log_votes = log(votes))


wards <- st_read("C:/Users/Jonathan Tannen/Dropbox/sixty_six/data/gis/warddivs/201911/Political_Wards.shp") %>%
  mutate(ward = sprintf("%02d", as.numeric(as.character(WARD_NUM))))

ggplot(wards %>% left_join(df_turnout %>% filter(year == 2016))) + 
  geom_sf(aes(fill=log_votes))

head(df_turnout)

wide_turnout <- df_turnout %>%
  select(ward, year, log_votes) %>%
  pivot_wider(names_from=year, values_from=log_votes)

mat_turnout <- wide_turnout %>% select(-ward) %>% as.matrix()
row.names(mat_turnout) <- wide_turnout$ward

col_means <- colMeans(mat_turnout)
mat_turnout <- sweep(mat_turnout, 2, col_means)
row_means <- rowMeans(mat_turnout)
mat_turnout <- sweep(mat_turnout, 1, row_means)


turnout_svd <- svd(mat_turnout, 2, 2)
turnout_svd$d
  

## Map Dimensions
wards <- wards %>% arrange(ward)
wards$dim_score <- turnout_svd$u

ggplot(wards) +
  geom_sf(aes(fill=dim_score[,1])) +
  scale_fill_gradient2()

elections <- data.frame(
  year=colnames(mat_turnout),
  dim_score=turnout_svd$v
)
  
## Plot Election Effects

ggplot(elections,
       aes(x=as.numeric(year), y=dim_score.1)) +
  geom_point() +
  geom_line()

## Estimate the original matrix
with(turnout_svd, u %*% diag(d[1:2]) %*% t(v))[1:6, 1:6]
mat_turnout[1:6, 1:6]
