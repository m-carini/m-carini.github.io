#setwd("/Users/marinannacarini/Documents/MSBA/Winter/BANA 277 Social Analytics/Spotify")

#---------------#
#-----SET-UP----#
#---------------#

library(igraph)
library(dplyr)

songs_file <- read.csv("data.csv")
conn_file <- read.csv("connection.csv")
data_full <- merge(x=songs_file, y=conn_file, by='id', all=TRUE)
main_artist <- read.csv('main_artist.csv')
genre <- read.csv('data_w_genres_clean.csv')
#drop extra columns
genre <- genre[,c("artists", "genres")]
#add main artist to songs data
songs_file <- merge(songs_file, main_artist, by="id")

#add artist to artist_1 for songs with only one artist
for (i in 1:nrow(data_full)) {
  if(is.na(data_full[i,'artist_1'])) {
    data_full$artist_1[i] = data_full$artists[i]
  }
}

#remove unwanted characters in data full
data_full$artist_1 <- gsub("[[\']", "", data_full$artist_1)
data_full$artist_1 <- gsub("[[\"]", "", data_full$artist_1)
data_full$artist_1 <- gsub("[\"]]", "", data_full$artist_1)
data_full$artist_1 <- gsub("[\']]", "", data_full$artist_1)
data_full$artist_1 <- gsub("[]]", "", data_full$artist_1)

#remove unwanted characters in songs file
songs_file$artists <- gsub("[[\']", "", songs_file$artists)
songs_file$artists <- gsub("[[\"]", "", songs_file$artists)
songs_file$artists <- gsub("[\"]]", "", songs_file$artists)
songs_file$artists <- gsub("[\']]", "", songs_file$artists)
songs_file$artists <- gsub("[]]", "", songs_file$artists)

#add genre to songs file by artists
songs_file <- merge(songs_file, genre, by='artists', all.x = TRUE)

#---------------#
#---FULL CALC---#
#---------------#
#get metrics for full graph

#graph data
full.graph <- graph.data.frame(conn_file[,2:3], directed = FALSE)

#degree
full_deg <- degree(full.graph)

#density
full_density <- edge_density(full.graph, loops=F)

#closeness
full_clsness <- closeness(full.graph, mode='all', weights=NA)

#betweenness
full_btwnness <- betweenness(full.graph, directed='F', weights=NA)

#authority score
full_auth.score <- authority_score(full.graph)

#Hubs = Authorities bc undirected graph

#mean distance
full_mean.dist <- mean_distance(full.graph, directed=F)

#turn igraph objects to dfs
full_auth_score_df <- as.data.frame(full_auth.score, keep.rownames = TRUE)
names <- rownames(full_auth_score_df)
full_auth_score_df <- cbind(names, full_auth_score_df)
full_auth_score_df <- full_auth_score_df[,1:2]

full_cls_df <- as.data.frame(full_clsness, keep.rownames = TRUE)
names <- rownames(full_cls_df)
full_cls_df <- cbind(names, full_cls_df)

full_btwn_df <- as.data.frame(full_btwnness, keep.rownames = TRUE)
names <- rownames(full_btwn_df)
full_btwn_df <- cbind(names, full_btwn_df)

#---------------#
#-----SCOPE-----#
#---------------#
#artists with 1+ songs with popularity over 70

#filter for songs with popularity >= 70
popu_songs <- unique(songs_file[songs_file$popularity >= 70,'id'])
#get list of artists for popular songs
popu_artists <- unique(c(data_full$artist_1[data_full$id %in% popu_songs], data_full$artist_2[data_full$id %in% popu_songs]))
conn <- conn_file[conn_file$artist_1 %in% popu_artists | conn_file$artist_2 %in% popu_artists,]
data <- data_full[data_full$id %in% conn$id,]

#turn conn into graph
artist.graph <- graph.data.frame(conn[,2:3], directed = FALSE)

#calc degree
deg <- degree(artist.graph, mode = "all")

#print avg. degree
mean(deg)

V(artist.graph)$degree <- degree(artist.graph)

#plot graph
plot(artist.graph,
     vertex.color="springgreen1",
     vertex.size=V(artist.graph)$degree*0.4,
     edge.arrow.size=0.01,
     vertex.label=NA,
     layout=layout.kamada.kawai)

#color graph by genre
V(artist.graph)$genre <- genre[V(artist.graph),c("genres")]
pal <- palette("Accent")
plot(artist.graph,
     vertex.color=pal[as.numeric(as.factor(V(artist.graph)$genre))],
     edge.arrow.size=0.01,
     vertex.label=NA,
     layout=layout.kamada.kawai)

#density
density <- edge_density(artist.graph, loops=F)

#closeness
clsness <- closeness(artist.graph, mode='all', weights=NA)

#betweenness
btwnness <- betweenness(artist.graph, directed='F', weights=NA)

#authority score
auth.score <- authority_score(artist.graph)

#hub score
hb.score <- hub_score(artist.graph)

#Hubs = Authorities bc undirected graph

#mean distance
mean.dist <- mean_distance(artist.graph, directed=F)

#turn igraph objects to dfs
auth_score <- as.data.frame(auth.score, keep.rownames = TRUE)
names <- rownames(auth_score)
auth_score <- cbind(names, auth_score)
auth_score <- auth_score[,1:2]

hb_score <- as.data.frame(hb.score, keep.rownames = TRUE)
names <- rownames(hb_score)
hb_score <- cbind(names, hb_score)
hb_score <- hb_score[,1:2]

cls <- as.data.frame(clsness, keep.rownames = TRUE)
names <- rownames(cls)
cls <- cbind(names, cls)

btwn <- as.data.frame(btwnness, keep.rownames = TRUE)
names <- rownames(btwn)
btwn <- cbind(names, btwn)

degr <- as.data.frame(deg, keep.rownames = TRUE)
names <- rownames(degr)
degr <- cbind(names, degr)

#highest deg artists
deg[deg >= 155]

#diameter of pop artists

#find the diameter value
diameter(artist.graph, directed=F, weights=NA)
#find diameter path
artist.diam <- get_diameter(artist.graph, directed=F)

#plot again highlighting the diameter
V(artist.graph)$color <- "gray27"
V(artist.graph)$size <- 3
V(artist.graph)$color[artist.diam] <- "springgreen1"
V(artist.graph)$size[artist.diam] <- 7.5
plot(artist.graph,
     edge.arrow.size=0.1,
     vertex.label=NA,
     layout=layout.kamada.kawai)

#---------------#
#-----T TEST----#
#---------------#
#see if differences between popu songs (treatment) and rest is stat. sig. 

#auth score t.test: not sig
t.test(full_auth_score_df$vector[!(full_auth_score_df$names %in% auth_score$names)], auth_score$vector)

#closeness t test: sig
t.test(full_cls_df$full_clsness[!(full_cls_df$names %in% cls$names)], cls$clsness)

#betweenness t test: sig
t.test(full_btwn_df$full_btwnness[!(full_btwn_df$names %in% btwn$names)], btwn$btwnness)

#---------------#
#----SUBCOMP----#
#---------------#
#assess subcomp with most connections

#calc max node
maxnode <- deg[deg == max(deg)]

#get subcomponent of maxnode
subcomp <- subcomponent(artist.graph, maxnode , mode='all')

#turn subcomp into df
subcompdf <- conn[(conn$artist_1 %in% subcomp$name | conn$artist_2 %in% subcomp$name),]

#turn subcomp into graph
subcomp.graph <- graph.data.frame(subcompdf[,2:3], directed = FALSE)

V(subcomp.graph)$degree <- degree(subcomp.graph)

#plot subcomp
plot(subcomp.graph,
     vertex.color="springgreen1",
     vertex.size=V(subcomp.graph)$degree*0.3,
     edge.arrow.size=0.01,
     vertex.label=NA,
     layout=layout.kamada.kawai)

#find the diameter value
diameter(subcomp.graph, directed=F, weights=NA)
#find diameter path
subcomp.diam <- get_diameter(subcomp.graph, directed=F)

#plot again highlighting the diameter
V(subcomp.graph)$color <- "gray27"
V(subcomp.graph)$size <- 3
V(subcomp.graph)$color[subcomp.diam] <- "springgreen1"
V(subcomp.graph)$size[subcomp.diam] <- 7.5
plot(subcomp.graph,
     edge.arrow.size=0.1,
     vertex.label=NA,
     layout=layout.kamada.kawai)

#density
subcomp_density <- edge_density(subcomp.graph, loops=F)

#closeness
subcomp_clsness <- closeness(subcomp.graph, mode='all', weights=NA)

#betweenness
subcomp_btwnness <- betweenness(subcomp.graph, directed='F', weights=NA)

#authority score
subcomp_auth.score <- authority_score(subcomp.graph)
plot(subcomp.graph,
     vertex.size=subcomp_auth.score$vector*30,
     main = 'Subcomponent Authorities',
     vertex.color = rainbow(52),
     vertex.label=NA,
     edge.arrow.size=0.1,
     layout = layout.kamada.kawai)

#Hubs = Authorities bc undirected graph

#mean distance
subcomp_mean.dist <- mean_distance(subcomp.graph, directed=F)

#---------------#
#-----NEIGHB----#
#---------------#
#calculate neighbors mean values

#create db of all neighbors from conn data
neighb_df <- data_full[data_full$artist_2 %in% conn$artist_2,]

#calc avg neighbor values
neighb_avgs <- neighb_df %>%
  group_by(artist_2) %>%
  summarise(nb_acousticness=mean(acousticness), nb_danceability=mean(danceability), 
            nb_duration=mean(duration_ms), nb_energy=mean(energy), nb_explicit=mean(explicit), 
            nb_instrumentalness=mean(instrumentalness), nb_key=mean(key), nb_liveness=mean(liveness), 
            nb_loudness=mean(loudness), nb_mode=mean(mode), nb_popularity=mean(popularity), 
            nb_speechiness=mean(speechiness), nb_tempo=mean(tempo), nb_valence=mean(valence))

#---------------#
#----PREDICT----#
#---------------#
#create df with network values, neighbor avg values, song qualities to predict popularity

#combine to make network metrics df
net_metrics <- merge(auth_score, hb_score, by="names", all=TRUE)
colnames(net_metrics) <- c("names", "auth_score", "hb_score")
net_metrics <- merge(net_metrics, cls, by="names", all=TRUE)
net_metrics <- merge(net_metrics, btwn, by="names", all=TRUE)
net_metrics <- merge(net_metrics, degr, by="names", all=TRUE)

#create prediction df for each song
pred_df <- songs_file[songs_file$id %in% conn$id,]
#include network metrics in df
pred_df <- merge(pred_df, net_metrics, by.x = "main_artist", by.y="names")
#calculate avg. featured artist song profiles
df <- merge(data, neighb_avgs, by="artist_2",all.x = TRUE)
df <- df %>%
  group_by(id) %>%
  summarise(avg_nb_acousticness=mean(nb_acousticness), avg_nb_danceability=mean(nb_danceability), 
            avg_nb_duration=mean(nb_duration), avg_nb_energy=mean(nb_energy), avg_nb_explicit=mean(nb_explicit), 
            avg_nb_instrumentalness=mean(nb_instrumentalness), avg_nb_key=mean(nb_key), avg_nb_liveness=mean(nb_liveness), 
            avg_nb_loudness=mean(nb_loudness), avg_nb_mode=mean(nb_mode), avg_nb_popularity=mean(nb_popularity), 
            avg_nb_speechiness=mean(nb_speechiness), avg_nb_tempo=mean(nb_tempo), avg_nb_valence=mean(nb_valence))

pred_df <- merge(pred_df, df, by='id', all.x = TRUE)

#want df by song with song prof, main artists network metrics, and avg of featured artists prof
#merge data_full with neighb df on artist 2, then group by id and avg. nb values
#merge that with pred df we want

#check out dist. of variables, assess if log is needed
summary(pred_df)

data_vars <- c("avg_nb_acousticness", "avg_nb_danceability", 
              "avg_nb_duration", "avg_nb_energy", "avg_nb_explicit", 
              "avg_nb_instrumentalness", "avg_nb_key", "avg_nb_liveness", 
              "avg_nb_loudness", "avg_nb_mode", "avg_nb_popularity", 
              "avg_nb_speechiness", "avg_nb_tempo", "avg_nb_valence", "acousticness", 
              "danceability","duration_ms", "energy", "explicit", "instrumentalness", "key", 
              "liveness", "loudness", "mode", "speechiness", "tempo", "valence", "auth_score", 
              "clsness", "btwnness","deg")

#plot histograms of potential variables as is
for (i in data_vars) {
  hist(pred_df[,i], main=i)
}

#log some variables
hist(log(pred_df$avg_nb_acousticness))
hist(log(pred_df$avg_nb_danceability))
hist(log(pred_df$avg_nb_duration)) #normal dist use this
hist(log(pred_df$avg_nb_energy))
hist(log(pred_df$avg_nb_explicit))
hist(log(pred_df$avg_nb_instrumentalness)) #somewhat normal dist
hist(log(pred_df$avg_nb_liveness)) #normal dist use this
hist(log(pred_df$avg_nb_loudness+1))
hist(log(pred_df$avg_nb_mode))
hist(log(pred_df$avg_nb_popularity))
hist(log(pred_df$avg_nb_speechiness)) #somewhat normal dist
hist(log(pred_df$acousticness))
hist(log(pred_df$duration_ms)) #normal dist use this
hist(log(pred_df$energy))
hist(log(pred_df$instrumentalness))
hist(log(pred_df$key))
hist(log(pred_df$liveness)) #normal dist use this
hist(log(pred_df$loudness+1))
hist(log(pred_df$speechiness))
hist(log(pred_df$auth_score))  #somewhat normal dist
hist(log(pred_df$clsness))
hist(log(pred_df$btwnness))
hist(log(pred_df$deg)) #somewhat normal dist

#run model with all variables as is
reg1 <- lm(popularity ~ avg_nb_acousticness + avg_nb_danceability + avg_nb_duration + 
              avg_nb_energy + avg_nb_explicit + avg_nb_instrumentalness + avg_nb_key + 
              avg_nb_liveness + avg_nb_loudness + avg_nb_mode + avg_nb_popularity + 
              avg_nb_speechiness + avg_nb_tempo + avg_nb_valence + acousticness + 
              danceability + duration_ms + energy + explicit + instrumentalness + key + 
              liveness + loudness + mode + speechiness + tempo + valence + auth_score + 
              clsness + btwnness + deg, data=pred_df)
summary(reg1)

#log some values
reg2 <- lm(popularity ~ avg_nb_acousticness + avg_nb_danceability + log(avg_nb_duration) + 
             avg_nb_energy + avg_nb_explicit + log(avg_nb_instrumentalness+1) + avg_nb_key + 
             log(avg_nb_liveness+1) + avg_nb_loudness + avg_nb_mode + avg_nb_popularity + 
             log(avg_nb_speechiness+1) + avg_nb_tempo + avg_nb_valence + acousticness + 
             danceability + log(duration_ms) + energy + explicit + instrumentalness + key + 
             log(liveness+1) + loudness + mode + speechiness + tempo + valence + log(auth_score+1) + 
             clsness + btwnness + log(deg+1), data=pred_df)
summary(reg2)

#remove insig vars
reg3 <- lm(popularity ~ avg_nb_acousticness + avg_nb_danceability + log(avg_nb_duration) + 
             avg_nb_energy + avg_nb_explicit + log(avg_nb_instrumentalness+1) +  
             avg_nb_loudness + avg_nb_popularity + acousticness + log(duration_ms) + 
             energy + explicit + instrumentalness + loudness, data=pred_df)
summary(reg3)

#check for correlation between ind vars.
reg_data <- pred_df[,c("avg_nb_acousticness","avg_nb_danceability","avg_nb_duration",
                       "avg_nb_energy","avg_nb_explicit","avg_nb_instrumentalness",
                       "avg_nb_loudness","avg_nb_popularity","acousticness","duration_ms",
                       "energy","explicit","instrumentalness","loudness", "popularity")]

#get cor matrix
round(cor(reg_data, use = "complete.obs"),2)

#remove highly correlated variables
reg4 <- lm(popularity ~ avg_nb_danceability + log(avg_nb_duration) + 
             avg_nb_loudness + avg_nb_popularity + danceability + explicit, data=pred_df)
summary(reg4)

#compare reg1 and reg2: use reg1
anova(reg1, reg2)
#compare reg1 and reg3: use reg1
anova(reg1, reg3)
#compare reg1 and reg4: use reg4
anova(reg1, reg4)

#remove different set of highly correlated variables
reg5 <- lm(popularity ~ avg_nb_danceability + log(avg_nb_duration) + 
             avg_nb_loudness + avg_nb_popularity+ log(duration_ms) + 
             energy + explicit + loudness, data=pred_df)
summary(reg5)

#use model4
anova(reg5, reg4)

#make regression with just song profile
reg6 <- lm(popularity ~ acousticness + 
             danceability + duration_ms + energy + explicit + instrumentalness + key + 
             liveness + loudness + mode + speechiness + tempo + valence, data=pred_df)
summary(reg6)

#poisson
reg7 <- glm(popularity ~ avg_nb_danceability + log(avg_nb_duration) + 
             avg_nb_loudness + avg_nb_popularity + danceability + explicit, data=pred_df, family="poisson")
summary(reg7)

#
reg8 <- glm(popularity/100 ~ avg_nb_danceability + log(avg_nb_duration) + 
              avg_nb_loudness + avg_nb_popularity + danceability + explicit, data=pred_df, family="binomial")
summary(reg8)

#---------------#
#------EDA------#
#---------------#

#EDWARDS CHARTS

#network metrics by genre
genre_auth_score <- merge(auth_score, genre, by.x="names", by.y="artists")
genre_auth_score <- genre_auth_score %>%
  group_by(genres) %>%
  summarise(mean(vector))

genre_cls <- merge(cls, genre, by.x="names", by.y="artists")
genre_cls <- genre_cls %>%
  group_by(genres) %>%
  summarise(mean(clsness))

genre_btwn <- merge(btwn, genre, by.x="names", by.y="artists")
genre_btwn <- genre_btwn %>%
  group_by(genres) %>%
  summarise(mean(btwnness))

genre_degr <- merge(degr, genre, by.x="names", by.y="artists")
genre_degr <- genre_degr %>%
  group_by(genres) %>%
  summarise(mean(deg))

# num of genres by year
year_gen <- songs_file[,c("year", "genres")] %>%
  group_by(genres, year) %>%
  summarise(num = n())

year_gen <- year_gen %>%
  group_by(year) %>%
  summarise(num_gens = n())

library(ggplot2)

ggplot(data=year_gen, aes(x=year, y=num_gens)) +
  geom_segment( aes(x=year, xend=year, y=0, yend=num_gens), color="grey") +
  geom_point( color="orange", size=4) +
  theme_light() +
  theme(
    panel.grid.major.x = element_blank(),
    panel.border = element_blank(),
    axis.ticks.x = element_blank()
  ) +
  xlab("Year") +
  ylab("# of Genres")

#===============================================================================
library(tidyverse)  # data manipulation
library(cluster)    # clustering algorithms
library(factoextra) # clustering algorithms & visualization

kk1 <- songs_file[c("name","acousticness", "danceability", "duration_ms", "energy", "explicit", "instrumentalness","key","liveness",
                    "loudness", "mode", "popularity", "speechiness", "tempo", "valence", "year")]

#pop over 90+
kk <- filter(kk1,popularity >= 90)

#unique name
kk <- kk %>% slice(-c(31))

#covert name to index
#row.names(kk)<-sample(c(kk$name),nrow(kk))
rownames(kk) <- kk$name
head(kk)

kk = subset(kk, select= -c(name))
head(kk)

#scaling/standardizing name variable
kk <- scale(kk)

#Computing k-means clustering in R
k2 <- kmeans(kk, centers = 2, nstart = 25)
str(k2)

#illustration of the clusters
fviz_cluster(k2, data = kk)

#3, 4, and 5 clusters
k3 <- kmeans(kk, centers = 3, nstart = 25)
k4 <- kmeans(kk, centers = 4, nstart = 25)
k5 <- kmeans(kk, centers = 5, nstart = 25)

# plots to compare
p1 <- fviz_cluster(k2, geom = "point", data = kk) + ggtitle("k = 2")
p2 <- fviz_cluster(k3, geom = "point",  data = kk) + ggtitle("k = 3")
p3 <- fviz_cluster(k4, geom = "point",  data = kk) + ggtitle("k = 4")
p4 <- fviz_cluster(k5, geom = "point",  data = kk) + ggtitle("k = 5")

library(gridExtra)
grid.arrange(p1, p2, p3, p4, nrow = 2)

#elbow chart
set.seed(123)

# function to compute total within-cluster sum of square 
wss <- function(k) {
  kmeans(kk, k, nstart = 10 )$tot.withinss
}

# Compute and plot wss for k = 1 to k = 10
k.values <- 1:10

# extract wss for 2-5 clusters
wss_values <- map_dbl(k.values, wss)

plot(k.values, wss_values,
     type="b", pch = 19, frame = FALSE, 
     xlab="Number of clusters K",
     ylab="Total within-clusters sum of squares")

#boxplot valence
box<-data.frame(kk)
boxplot(box$valence ~ k2$cluster, xlab='Cluster', ylab='x-value', main="Valence")

#boxplot duration_ms
boxplot(box$duration_ms ~ k2$cluster, xlab='Cluster', ylab='x-value', main="Duration_ms")

#boxplot loudness
boxplot(box$loudness ~ k2$cluster, xlab='Cluster', ylab='x-value', main="Loudness")

#boxplot acousticness
boxplot(box$acousticness ~ k2$cluster, xlab='Cluster', ylab='x-value', main="Acousticness")

#boxplot danceability
boxplot(box$danceability ~ k2$cluster, xlab='Cluster', ylab='x-value', main="Danceability")
