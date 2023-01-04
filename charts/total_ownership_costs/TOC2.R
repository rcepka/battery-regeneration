

if (!require("pacman")) install.packages("pacman")

pacman::p_load(
  tidyverse,
  dplyr,
  readxl,
  readr,
  here,
  ggthemes,
  scales,
  ggplot2,
  DT,
  ggforce
)



# Create the main dataset
backup_batt <- tibble (
  Years.Initial = rep(5:10, each = 1, times = 5000),
  Years.Prolonged = rep(1:5, each = 6, times=1000),
  Regeneration.Costs = rep(1:100, each = 30, times = 10),
  Battery.Costs = rep( c(75, 100, 125, 150, 175, 200, 250, 300, 400, 500), each = 3000, times = 1)
)


# Adjust main dataset, do calcullations
backup_batt.TOC <- backup_batt %>%
  mutate(
    Years.Total = Years.Initial + Years.Prolonged,
    TOC.y = num(Battery.Costs / Years.Initial, digits = 2),
    Regeneration.Costs.y = num(Regeneration.Costs / Years.Prolonged, digits = 2, label = "€"),
    TOC.Regeneration = Battery.Costs + Regeneration.Costs,
    TOC.Regeneration.y = num(TOC.Regeneration / Years.Total, digits = 2)) %>%
  relocate(Years.Total, .after = Years.Prolonged) %>%
  relocate(TOC.y, .after = Battery.Costs) %>%
  relocate(Regeneration.Costs, .after = TOC.y) %>%
  relocate(TOC.Regeneration, .after = Regeneration.Costs) %>%
  mutate(
    TOC.savings.y.eur = TOC.y - TOC.Regeneration.y,
    TOC.savings.y.perc = (1 - TOC.Regeneration.y / TOC.y),
    Lifetime.Savings = TOC.savings.y.eur * Years.Total
  )




dataset1 <- backup_batt.TOC %>%
  filter(
    Years.Initial == 7,
    Years.Prolonged == 3,
    Battery.Costs %in% c(75, 100, 150, 200),
    Regeneration.Costs %in% c(15, 20, 30, 40, 50)
  )
datatable(dataset1) %>%
  formatCurrency(c(4, 5, 6, 7, 8, 9, 10, 12), "€", digits = 1) %>%
  formatPercentage(11, digits = 1)




dataset2 <- backup_batt.TOC %>%
  filter(
    Years.Initial == 7,
    Years.Prolonged == 3,
    Battery.Costs %in% c(75, 100, 150, 200),
    #Regeneration.Costs %in% c(15, 20, 30, 40, 50)
  )

dataset3 <- backup_batt.TOC %>%
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
  data = dataset1,
  aes(
    x = Regeneration.Costs,
    y = Battery.Costs,
    #y = TOC.savings.y.perc,
    #color = factor(Battery.Costs),
    size = TOC.savings.y.perc,
   # color = factor(TOC.savings.y.perc),
  ),
) +
  geom_point(
    #aes(group = Lifetime.Savings)
  )









ggplot(
  data = dataset1,
  aes(
    x = Regeneration.Costs,
    y = TOC.savings.y.perc,
    color = factor(Battery.Costs),
    #size = Lifetime.Savings,
    # color = factor(Lifetime.Savings),
  ),
) +
  geom_line(
    #aes(group = Lifetime.Savings)
  ) +
  scale_y_continuous(
    labels = label_percent(),
    #limits = c(-0.2, 0.3),
    limits = c(as.numeric(min(dataset1$TOC.savings.y.perc)), as.numeric(max(dataset1$TOC.savings.y.perc))),
    breaks = seq(as.numeric(min(dataset1$TOC.savings.y.perc)) : as.numeric(max(dataset1$TOC.savings.y.perc)), by = 0.1),
    #breaks = seq(-0.2 : 0.25, by = 0.1),
   # breaks = c(-0.2, 0, 0.2, 0.3)
    ) +
  scale_x_continuous(
    labels = label_dollar(prefix = "", suffix = "€"))



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
  data = backup_batt.TOC %>%
    filter(
      Years.Initial == 7,
      #Years.Prolonged == 3,
      Battery.Costs %in% c(100, 200, 300),
      Regeneration.Costs %in% seq(0, 50, by = 5)
      ),
  aes(
    x = Battery.Costs,
    y = Regeneration.Costs,
    size = Lifetime.Savings,
   # size = TOC.savings.y.perc,
    #color = (TOC.savings.y.perc),
   # color = factor(Lifetime.Savings)
   color = Years.Prolonged
  ),
  ) +
  geom_boxplot(
    aes(
      group = Battery.Costs,
     # color = factor(Battery.Costs),
      )
    ) +
  geom_jitter(
    # size = Lifetime.Savings,
    alpha = 0.75,
    ) +
  scale_x_continuous (breaks=c(100, 200, 300)) +
  geom_mark_ellipse(
    aes(
      fill = "red",
      filter = Regeneration.Costs == 40,
      label = "Species"
      )
    )

  facet_wrap(~Years.Initial, nrow = 2 )





# Geom_tile
ggplot(
  data = backup_batt.TOC %>%
    filter(
      Years.Initial == 7,
      #Years.Prolonged == 3,
      Battery.Costs %in% c(100, 150, 200, 250, 300),
      Regeneration.Costs %in% seq(0, 100, by = 5)
    ),
  aes(
    x = Battery.Costs,
    y = Regeneration.Costs,
    #size = Lifetime.Savings,
    # size = TOC.savings.y.perc,
    #color = (TOC.savings.y.perc),
    # color = factor(Lifetime.Savings)
    #color = Years.Prolonged
  ),
) +
  geom_tile(
    aes(
     # fill = Lifetime.Savings,
      fill = TOC.savings.y.perc,
      color = "grey50"
      # color = factor(Battery.Costs),
    )
  ) +
  scale_x_continuous (breaks=c(100, 150, 200, 250, 300))



