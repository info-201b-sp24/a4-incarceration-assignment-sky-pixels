# Load required libraries
library(ggplot2)
library(dplyr)
library(tidyr)
library(scales)

# Assuming prison_pop_data is already loaded and has the necessary columns
# Sample structure of prison_pop_data for demonstration
# Replace this with your actual data loading step

# Create a lookup table for state abbreviations and state names
state_lookup <- data.frame(
  state_abbr = tolower(state.abb),
  state_name = tolower(state.name)
)

# Correct the merging and aggregation process
prison_pop_state <- prison_pop_data %>%
  mutate(state_abbr = tolower(state)) %>%  # Convert state abbreviations to lowercase
  left_join(state_lookup, by = c("state_abbr" = "state_abbr")) %>%  # Merge with the lookup table
  mutate(state = state_name) %>%  # Create a new column state with full state names
  select(state, female_pop_15to64, male_pop_15to64) %>%  # Select necessary columns
  group_by(state) %>%  # Group by state
  summarize(
    female_pop_15to64 = sum(female_pop_15to64, na.rm = TRUE),
    male_pop_15to64 = sum(male_pop_15to64, na.rm = TRUE)
  ) %>%  # Aggregate data to ensure each state has only one entry
  na.omit()  # Remove rows with NA values

# Using format from lec slides
states_map <- map_data("state")

# Joining data
map_data <- states_map %>%
  left_join(prison_pop_state, by = c("region" = "state"))

# Create the map for Female Population
female_population_map <- ggplot(map_data, aes(x = long, y = lat, group = group, fill = female_pop_15to64)) +
  geom_polygon(color = "white") +
  scale_fill_gradient(low = "#ffd1df", high = "blue", na.value = "grey80", name = "Female Population", labels = label_number(big.mark = ",")) +
  expand_limits(x = states_map$long, y = states_map$lat) +
  labs(title = "Female Prison Population Distribution by State",
       fill = "Population") +
  theme_minimal()

# Print the map for Female Population
print(female_population_map)