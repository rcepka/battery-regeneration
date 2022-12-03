
if (!require("pacman")) install.packages("pacman")

pacman::p_load(
  tidyverse,
  dplyr,
  here,
  directlabels,
  ggthemes,
  hrbrthemes,
  scales,
  ggforce,
  eurostat,
  googlesheets4,
  DiagrammeR,
  readr
)


gs4_deauth()


# All batteries market size
all_batteries_market <- read_sheet(
  "https://docs.google.com/spreadsheets/d/1MnEXLg2WlwMoS88LThUBf3cMiPFvfIbBxvE5pjzvacs",
  sheet = 1,
  range = "A2:F4"
) %>%
  dplyr::rename(Battery.Type = 1)

write_csv (
  all_batteries_market,
  here("marketing", "go-to-market", "data", "all_batteries_market.csv")
)

# MAke table pivot_longer
all_batteries_market_L <- all_batteries_market %>%
  tidyr::pivot_longer(
    cols = 2:6,
    names_to = "Year",
    values_to = "Market.Size"
    )


# Change the order so the lead-acid batteries go first
all_batteries_market_L <- all_batteries_market_L %>%
  mutate(Battery.Type = factor(Battery.Type, levels = c("Lithium", "Lead-Acid")))


# Create the plot
plot_all_batteries_market <- ggplot(
  data = all_batteries_market_L
  ) +
  geom_bar(
    aes(
      x = Year, y = Market.Size, fill = Battery.Type,
      ),
    stat = "identity",
    ) +
  scale_fill_manual(values = c("green", "orange")) +
 # scale_colour_manual(values = c(Lead-Acid = "red", Lithium = "black"))
  theme_ipsum_rc()


# Save the plot
ggsave(
  plot = plot_all_batteries_market,
  here("marketing", "go-to-market", "plots", "plot_all_batteries_market.png"),
  dpi = 300,
  width = 2250, height = 1000, units = "px"
)




googlesheets4::gs4_deauth()

# Lead acid batteries by type
lead_acid_batteries_by_type <- read_sheet(
  "https://docs.google.com/spreadsheets/d/1MnEXLg2WlwMoS88LThUBf3cMiPFvfIbBxvE5pjzvacs",
  sheet = 2,
  range = "A2:B5"
)# %>%
  dplyr::rename(Battery.Type = 1)

write_csv (
  lead_acid_batteries_by_type,
  here("marketing", "go-to-market", "data", "lead_acid_batteries_by_type.csv")
)



gr1 <- DiagrammeR::grViz("digraph {

graph [layout = dot, rankdir = LR]

# define the global styles of the nodes. We can override these in box if we wish
node [shape = rectangle, style = filled, fillcolor = Linen]

data1 [label = 'Dataset 1', shape = box, fillcolor = Beige]
data2 [label = 'Dataset 2', shape = folder, fillcolor = Beige]
process [label =  'Process \n Data']
statistical [label = 'Statistical \n Analysis']
results [label= 'Results']

# edge definitions with the node IDs
#{data1 data2}  -> process -> statistical -> results
data1, data2  -> process -> data1 -> statistical -> results

  }")
