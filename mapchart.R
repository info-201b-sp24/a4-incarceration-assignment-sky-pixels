library(ggplot2)
library(dplyr)
library(tidyr)
library(scales)

# to merge abbreviations with full state names
state_lookup <- data.frame(
  state_abbr = tolower(state.abb),
  state_name = tolower(state.name)
)

prison_pop_state <- prison_pop_data %>%
  mutate(state_abbr = tolower(state)) %>%  
  left_join(state_lookup, by = c("state_abbr" = "state_abbr")) %>%  
  # merge with the lookup table
  mutate(state = state_name) %>%  
  select(-state_name, -state_abbr) 

# remove na values
prison_pop_state <- prison_pop_state %>%
  na.omit()  

states_map <- map_data("state")

map_data <- states_map %>%
  left_join(prison_pop_state, by = c("region" = "state"))

female_population_map <- ggplot(map_data, aes(x = long, y = lat, group = group, fill = female_pop_15to64)) +
  geom_polygon(color = "white") +
  scale_fill_gradient(low = "#ffd9ee", high = "#ff008d", na.value = "grey80", name = "Population", labels = label_number(big.mark = ",")) +
  expand_limits(x = states_map$long, y = states_map$lat) +
  labs(title = "Female Prision Population Distribution by State",
       fill = "Population") +
  theme_minimal()

# Print the map
print(female_population_map)
