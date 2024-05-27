library(dplyr)
library(ggplot2)

# removing NA values
wa_pop_data <- wa_pop_data %>%
  filter(!is.na(female_prison_pop_rate) & !is.na(male_prison_pop_rate))

ggplot(wa_pop_data) +
  geom_point(aes(x = female_prison_pop_rate, y = male_prison_pop_rate, color = "Male")) +
  geom_point(aes(x = female_prison_pop_rate, y = female_prison_pop_rate, color = "Female")) +
  scale_color_manual(values = c("Male" = "#348ceb", "Female" = "#f0afc2")) +
  labs(title = "Scatterplot of Female vs Male Prison Population Rates in WA",
       x = "Female Prison Population Rate",
       y = "Male Prison Population Rate",
       color = "Gender") +
  theme_minimal()