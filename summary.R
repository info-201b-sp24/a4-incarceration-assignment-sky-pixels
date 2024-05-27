library(dplyr)

# loading the data
prison_pop_data <- read.csv("https://github.com/melaniewalsh/Neat-Datasets/blob/main/us-prison-pop.csv?raw=true")

wa_pop_data <- read.csv("https://github.com/melaniewalsh/Neat-Datasets/raw/main/us-prison-jail-rates-1990-WA.csv")

# calculations for the broad prison population 
prison_total <- round(mean(prison_pop_data$total_pop_15to64, na.rm = T), 2)
prison_fem <- round(mean(prison_pop_data$female_pop_15to64, na.rm = T), 2)
prison_male <- round(mean(prison_pop_data$male_pop_15to64, na.rm = T), 2)

# calculating the avg prison population in WA
wa_total <- round(mean(wa_pop_data$total_prison_pop_rate, na.rm = T), 2)
wa_fem <- round(mean(wa_pop_data$female_prison_pop_rate, na.rm = T), 2)
wa_male <-round(mean(wa_pop_data$male_prison_pop_rate, na.rm = T), 2)

# calculating ratios
prison_fem_ratio <- round(prison_fem / prison_total, 2)
prison_male_ratio <- round(prison_male / prison_total, 2)

wa_fem_ratio <- round(wa_fem / wa_total, 2)
wa_male_ratio <- round(wa_male / wa_total, 2)


# for the data collection part
# prison
zrows_p <- nrow(prison_pop_data)
zcols_p <- ncol(prison_pop_data)

# wa 
zrows_wa <- nrow(wa_pop_data)
zcols_wa <- ncol(wa_pop_data)

# for readme 
summary_stats <- list (
  prison_total = prison_total,
  prison_fem = prison_fem,
  prison_male = prison_male,
  
  wa_total = wa_total,
  wa_fem = wa_fem,
  wa_male = wa_male,
  
  rows_p = zrows_p,
  cols_p = zcols_p,
  rows_wa = zrows_wa,
  cols_wa = zcols_wa
)

