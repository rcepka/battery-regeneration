#

if (!require("pacman")) install.packages("pacman")

pacman::p_load(
  shiny,
  tidyverse,
  ggplot2,
  plotly,
  reactable,
  reactablefmtr,
  shinyWidgets,
  bslib
)




# Create the main dataset - limited Battery Costs
backup_batt <- tibble (
  Years.Initial = rep(5:10, each = 1, times = 5000),
  Years.Prolonged = rep(1:5, each = 6, times=1000),
  Regeneration.Costs = rep(1:100, each = 30, times = 10),
  Battery.Costs = rep( c(75, 100, 125, 150, 175, 200, 250, 300, 400, 500), each = 3000, times = 1)
)

# Create the main dataset - large woth Battery Costs from 1 to 500€
backup_batt_LG <- tibble (
  Years.Initial = rep(5:10, each = 1, times = 250000),
  Years.Prolonged = rep(1:5, each = 6, times=50000),
  Regeneration.Costs = rep(1:100, each = 30, times = 500),
  Battery.Costs = rep(1:500, each = 3000, times = 1)
)





# Adjust main dataset, do calcullations
backup_batt.TOC <- backup_batt %>%
  mutate(
    Years.Total = Years.Initial + Years.Prolonged,
    TOC.y = Battery.Costs / Years.Initial,
    Regeneration.Costs.y = Regeneration.Costs / Years.Prolonged,
    TOC.Regeneration = Battery.Costs + Regeneration.Costs,
    TOC.Regeneration.y = TOC.Regeneration / Years.Total) %>%
  relocate(Years.Total, .after = Years.Prolonged) %>%
  relocate(TOC.y, .after = Battery.Costs) %>%
  relocate(Regeneration.Costs, .after = TOC.y) %>%
  relocate(TOC.Regeneration, .after = Regeneration.Costs) %>%
  mutate(
    TOC.savings.y.eur = TOC.y - TOC.Regeneration.y,
    TOC.savings.y.perc = (1 - TOC.Regeneration.y / TOC.y),
    Lifetime.Savings = TOC.savings.y.eur * Years.Total
  )

# Adjust main dataset, do calcullations for the large dataset
backup_batt.TOC_LG <- backup_batt_LG %>%
  mutate(
    Years.Total = Years.Initial + Years.Prolonged,
    TOC.y = Battery.Costs / Years.Initial,
    Regeneration.Costs.y = Regeneration.Costs / Years.Prolonged,
    TOC.Regeneration = Battery.Costs + Regeneration.Costs,
    TOC.Regeneration.y = TOC.Regeneration / Years.Total) %>%
  relocate(Years.Total, .after = Years.Prolonged) %>%
  relocate(TOC.y, .after = Battery.Costs) %>%
  relocate(Regeneration.Costs, .after = TOC.y) %>%
  relocate(TOC.Regeneration, .after = Regeneration.Costs) %>%
  mutate(
    TOC.savings.y.eur = TOC.y - TOC.Regeneration.y,
    TOC.savings.y.perc = (1 - TOC.Regeneration.y / TOC.y),
    Lifetime.Savings = TOC.savings.y.eur * Years.Total
  )

# Data for battery costs select list
battery_costs <- unique(backup_batt.TOC$Battery.Costs)
#battery_costs2 <- backup_batt.TOC %>% distinct(Battery.Costs)


# Regeneration costs for select list
regeneration_costs <- seq(from = 0, to = 100, by = 5)


# Initial years of battery use for select list
initial_years <- unique(backup_batt.TOC$Years.Initial)


# Year added by regeneration for select list
# NOT USED
years_prolonged <- unique(backup_batt.TOC$Years.Prolonged)
