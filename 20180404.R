library(tidyverse)
library(fiftystater)
library(scales)

df <- readxl::read_excel("us_avg_tuition.xlsx") %>%
  select(state = State, tuition = "2015-16") %>%
  mutate(tuition = round(tuition, 0)) %>%
  mutate(state = tolower(state))

data("fifty_states") # this line is optional due to lazy data loading

# crimes <- data.frame(state = tolower(rownames(USArrests)), USArrests)

# map_id creates the aesthetic mapping to the state name column in your data
p <- ggplot(df, aes(map_id = state)) + 
  # map points to the fifty_states shape data
  geom_map(aes(fill = tuition), map = fifty_states) + 
  expand_limits(x = fifty_states$long, y = fifty_states$lat) +
  coord_map() +
  scale_x_continuous(breaks = NULL) + 
  scale_y_continuous(breaks = NULL) +
  labs(x = "", y = "") +
  theme(legend.position = "right", 
        panel.background = element_blank(),
        legend.title=element_blank()
        ) +
  ggtitle("Average Tuition in the United States, 2015-16") +
  scale_fill_gradient(labels=dollar)

p

