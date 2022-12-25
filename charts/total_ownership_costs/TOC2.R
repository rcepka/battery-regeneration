

if (!require("pacman")) install.packages("pacman")

pacman::p_load(
  tidyverse,
  dplyr,
  readxl,
  readr,
  here,
  ggthemes,
  scales
)





backup_batt <- tibble (
  Years.Initial = rep(5:10, each = 1, times = 5000),
  Years.Prolonged = rep(1:5, each = 6, times=1000),
  Regeneration.Costs = rep(1:100, each = 30, times = 10),
  Battery.Costs = rep( c(75, 100, 125, 150, 175, 200, 250, 300, 400, 500), each = 3000, times = 1)
)


backup_batt <- backup_batt %>%
  mutate(
    Years.Total = Years.Initial + Years.Prolonged,
    TOC.y = num(Battery.Costs / Years.Initial, digits = 2),
    Regeneration.Costs.y = num(Regeneration.Costs / Years.Prolonged, digits = 2, label = "€"),
    TOC.Regeneration = Battery.Costs + Regeneration.Costs,
    TOC.Regeneration.y = num(TOC.Regeneration / Years.Total, digits = 2)) %>%
  relocate(Years.Total, .after = Years.Prolonged) %>%
  relocate(TOC.y, .after = Battery.Costs) %>%
  relocate(Regeneration.Costs, .after = TOC.y) %>%
  relocate(TOC.Regeneration, .after = Regeneration.Costs)

backup_batt <- backup_batt %>%
  mutate(
    TOC.savings.y.eur = TOC.y - TOC.Regeneration.y,
    TOC.savings.y.perc = 1 - TOC.Regeneration.y / TOC.y,
    Lifetime.Savings = TOC.savings.y.eur * Years.Total
    )






ggplot(
  data = backup_batt,
  aes(
    x = Years.Prolonged,
    y = Reg.Costs
  )
) +
  geom_point()
