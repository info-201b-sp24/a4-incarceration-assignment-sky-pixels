# Load necessary libraries
library(dplyr)
library(ggplot2)

# Assuming the datasets are named df1 and df2
# Ensure the datasets are combined if needed, otherwise use the relevant dataset directly

# Summarize the data by year for male and female prison populations
prison_population_summary <- prison_pop_data %>%
  filter(year >= 1990) %>%
  group_by(year) %>%
  summarise(
    total_male_prison_pop = sum(prison_male, na.rm = T),
    total_female_prison_pop = sum(prison_fem, na.rm = T)
  ) %>%
  mutate(source = "US")

wa_population_summary <- wa_pop_data %>%
  group_by(year) %>%
  summarise(
    total_male_prison_pop = sum(wa_male, na.rm = T),
    total_female_prison_pop = sum(wa_fem, na.rm = T)
  ) %>%
  mutate(source = "Washington")

# Combine the datasets
combined_data <- bind_rows(
  prison_population_summary %>% rename(male_prison_pop = total_male_prison_pop, female_prison_pop = total_female_prison_pop),
  wa_population_summary %>% rename(male_prison_pop = total_male_prison_pop, female_prison_pop = total_female_prison_pop)
)

# Plot the male vs female prison population over the years
ggplot(combined_data, aes(x = year)) +
  geom_line(aes(y = male_prison_pop, color = "Male", linetype = source)) +
  geom_line(aes(y = female_prison_pop, color = "Female", linetype = source)) +
  scale_color_manual(values = c("Male" = "#348ceb", "Female" = "#f0afc2")) +
  labs(title = "Male vs Female Prison Population Over the Years",
       x = "Year",
       y = "Population",
       color = "Gender",
       linetype = "Dataset") +
  theme_minimal()