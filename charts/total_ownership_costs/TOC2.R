

if (!require("pacman")) install.packages("pacman")

pacman::p_load(
  tidyverse,
  dplyr,
  readxl,
  readr,
  here,
  ggthemes,
  scales,
  ggplot2
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
    TOC.savings.y.perc = (1 - TOC.Regeneration.y / TOC.y),
    Lifetime.Savings = TOC.savings.y.eur * Years.Total
    )


dataset1 <- backup_batt %>%
  filter(
    Years.Initial == 7,
    Years.Prolonged == 3,
    Battery.Costs %in% c(100, 150, 200),
    Regeneration.Costs %in% c(15, 20, 30, 40, 50)
  )

dataset2 <- backup_batt %>%
  filter(
    Years.Initial == 7,
    Years.Prolonged == 3,
    Battery.Costs %in% c(75, 100, 150, 200),
    #Regeneration.Costs %in% c(15, 20, 30, 40, 50)
  )

dataset3 <- backup_batt %>%
  filter(
    Years.Initial == 7,
    Years.Prolonged == 3,
    Battery.Costs %in% c(75, 150, 250, 500),
    #Regeneration.Costs %in% c(15, 20, 30, 40, 50)
  )




ggplot(
  data = dataset3,
  aes(
    x = Regeneration.Costs,
    y = TOC.savings.y.perc,
    color = factor(Battery.Costs),
    #size = Lifetime.Savings,
   # color = factor(Lifetime.Savings),
   ),
  ) +
  geom_point(
    #aes(group = Lifetime.Savings)
  ) +
  scale_y_continuous(labels = label_percent()) +
  scale_x_continuous(labels = label_dollar(
    prefix = "",
    suffix = "€"
  ))

ggplot(
  data = dataset1,
  aes(
    x = Regeneration.Costs,
    y = TOC.savings.y.perc,
    color = factor(Battery.Costs),
    size = Lifetime.Savings,
    # color = factor(Lifetime.Savings),
  ),
) +
  geom_point(
    #aes(group = Lifetime.Savings)
  ) +
  scale_y_continuous(labels = label_percent()) +
  scale_x_continuous(labels = label_dollar(
    prefix = "",
    suffix = "€"
  ))




ggplot(
  data = backup_batt,
  aes(
    x = Battery.Costs,
    y = Regeneration.Costs,
    size = Lifetime.Savings
  ),

) +
  geom_point(
    # size = Lifetime.Savings
  )


ggplot(
  data = dataset2,
  aes(
    x = Battery.Costs,
    y = Regeneration.Costs,
    #size = Lifetime.Savings
  ),
  ) +
  geom_boxplot(
    aes(group = Battery.Costs)
    ) +
  geom_jitter(
    # size = Lifetime.Savings
    ) +
  scale_x_continuous (breaks=c(75, 100, 150, 200))


