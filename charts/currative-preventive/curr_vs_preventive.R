
if (!require("pacman")) install.packages("pacman")

pacman::p_load(
  tidyverse,
  googlesheets4,
  googledrive,
  highcharter,
  here,
  directlabels,
  ggthemes,
  hrbrthemes,
  scales,
  ggforce
)



# ******************************************************************************
# ******************************************************************************
# WITHOUT regeneration
# - assuming degradation after 7 years
# ******************************************************************************
# ******************************************************************************

#gs4_deauth()
#gs4_auth()

# Load basic data for backup batteries
df_no_regeneration_BB <- read_sheet(
  "https://docs.google.com/spreadsheets/d/1OQSABH5vFd6GjAXIxo3FRCiZOnnETrOzJh3apjAQ8xY",
  sheet = "no_regeneration-BB",
  range = "A2:D87",
  #skip = 1
)


# Save it as csv
write_csv(df_no_regeneration_BB, here("currative-preventive", "data", "df_no_regeneration_BB.csv"))



dfl_no_regeneration_BB <- pivot_longer(
  df_no_regeneration_BB,
    !Year,
    names_to = "Batteries",
    values_to = "Capacity"
  )


plot_no_regneration_BB <- ggplot(
  data = dfl_no_regeneration_BB,
  aes(
    x = Year,
    y = Capacity
    )
  ) +
  geom_area(
    aes(
      color = Batteries,
      fill = Batteries
    ),
    size = 1,
    alpha = 0.5,
    position = "dodge",
  ) +
    scale_x_continuous(
      limits = c(0, 21),
      breaks = c(0, 7, 10, 14, 20, 21),
      "Years of battery use"
    ) +
    scale_y_continuous(
      limits = c(0, 100),
      breaks = c(0, 50, 75, 100),
      labels = scales::label_percent(scale = 1),
      "Battery capacity"
    ) +
  theme_ipsum_rc(
    grid = "Y",
    axis_title_size = 13
  ) +
  theme(
    legend.title = element_text(face = "bold"),
    legend.text = element_text(face = "bold")
  ) +
    geom_hline(
      yintercept = 75,
      color = "darkgoldenrod",
      size = 0.75,
      alpha = 0.95
    ) +
    geom_vline(
      xintercept = c(10, 20),
      color = "darkorange",
      size = 1,
      alpha = 0.75
    ) +
    annotate(
      geom = "label",
      x = 15, y = 90,
      label = "Designed lifespan",
      size = 4,
     # hjust = 0.065,
      fill = "orange",
      color = "white",
      fontface = "bold",
      #alpha = 0.7
    ) +
  annotate(
    geom = "segment",
    x = c(10, 20), xend = c(15, 15), y = c(100, 100), yend = c(93, 93),
    color = "darkorange",
    size = 0.5,
  ) +
  scale_color_manual(
    values = c("royalblue", "steelblue", "slateblue"),
    #labels = guide_labels_preventive_BB,
    guide = FALSE,
    ) +
  scale_fill_manual(
    values = c("royalblue", "steelblue", "slateblue"),
    # labels = c("red", "orange"),
    ) +
  geom_point(
    aes(x = a, y = b),
    data = data.frame(a = c(7, 14, 21), b = c(75, 75, 75)),
    size = 5,
    color = "red"
    ) +
  annotate(
    geom = "segment",
    x = c(7, 14, 21), xend = c(14, 14, 14), y = c(75, 75, 75), yend = c(45, 45, 45),
    color = "red",
    size = 0.5,
    ) +
  geom_label(
    aes(x = 14, y = 40,),
    fill = "red",
    color = "white",
    label = "Points of battery\nearly replacement",
    size = 3,
    # nudge_x = -1.5,
    # nudge_y = -7
  )


# Save it
  ggsave(
    plot = plot_no_regneration_BB,
    here( "charts", "currative-preventive", "output", "no_regeneration_BB.png"),
    dpi = 300,
    width = 4000, height = 1800, units = "px"
  )



# ******************************************************************************
# ******************************************************************************
# Preventive regeneration chart
# ******************************************************************************
# ******************************************************************************


# Load basic data for backup batteries
df_preventive_BB <- read_sheet(
  "https://docs.google.com/spreadsheets/d/1OQSABH5vFd6GjAXIxo3FRCiZOnnETrOzJh3apjAQ8xY",
  sheet = "preventive-BB",
  range = "A2:J68",
  #skip = 1
  ) %>%
  rename(
    No.Regeneration = 2
  ) %>%
  rename_all(
    ~str_replace(., " ", ".")
  ) %>%
  mutate(
    across(
      .cols = everything(),
       ~str_replace(., ",", ".")
      ),
    across(
      .cols = everything(),
      ~str_replace(., "%", "")
    ),
    across(
      .cols = everything(),
      ~ as.numeric(.x)
    ),
   # Year = as.factor(Year)
  )

# Save it as csv
write_csv(df_preventive_BB, here("currative-preventive", "data", "df_preventive_BB.csv"))


# Plot the basic df_preventive_BB
# Each column has own geom_area
ggplot(
  data = df_preventive_BB,
  aes(x = Year)
  ) +
  geom_area(
    aes(
      #y = No.Regeneration
      y = get(names(df_preventive_BB)[2])
    ),
    alpha = 1,
    color = "darkblue",
    fill = "darkorange",
    size = 1,
  ) +
  geom_area(
    aes(
      y = Regeneration.1
      ),
    color = "#658e64",
    fill = "#658e64",
    size = 1,
    alpha = 0.65,
    ) +
  geom_area(
    aes(
      y = get(names(df_preventive_BB)[4])
    ),
    alpha = 0.60,
    color = "#658e64",
    fill = "#658e64",
    size = 1
  ) +
  geom_area(
    aes(
      y = get(names(df_preventive_BB)[5])
    ),
    alpha = 0.55,
    color = "#658e64",
    fill = "#658e64",
    size = 1
  ) +
  geom_area(
    aes(
      y = get(names(df_preventive_BB)[6])
    ),
    alpha = 0.50,
    color = "#658e64",
    fill = "#658e64",
    size = 1
  ) +
  geom_area(
    aes(
      y = get(names(df_preventive_BB)[7])
    ),
    alpha = 0.45,
    color = "#658e64",
    fill = "#658e64",
    size = 1
  ) +
  geom_area(
    aes(
      #y = No.Regeneration
      y = get(names(df_preventive_BB)[8])
    ),
    alpha = 0.40,
    color = "#658e64",
    fill = "#658e64",
    size = 1
  ) +
  geom_area(
    aes(
      #y = No.Regeneration
      y = get(names(df_preventive_BB)[9])
    ),
    alpha = 0.35,
    color = "red",
    fill = "red",
    size = 1
  ) +
  geom_area(
    aes(
      #y = No.Regeneration
      y = get(names(df_preventive_BB)[10])
    ),
    alpha = 0.30,
    color = "blue",
    fill = "blue",
    size = 1
  ) +
  scale_x_continuous(
    breaks = c(0:17)
  ) +
  scale_y_continuous(
    breaks = c(0, 25, 50, 75, 100, 125)
    ) +
  geom_hline(
    yintercept = 75,
    color = "red",
    size = 0.5,
    alpha = 0.75
  ) +
  theme_ipsum(grid = "Y")




# Create data for automatic plotting of each column
dfl_preventive_BB <- pivot_longer(
  df_preventive_BB,
  cols = c(2, starts_with("Reg")),
  names_to = "Regeneration",
  values_to = "Capacity"
)
# Save it as csv
write_csv(dfl_preventive_BB, here("currative-preventive", "data", "dfl_preventive_BB.csv"))

# Create data frame for printing labels - how much capacity battery has
labels_preventive_BB <- dfl_preventive_BB %>%
  mutate(
    Year = floor(Year)
  ) %>%
  select(Year, Capacity) %>%
  group_by(Year) %>%
  summarise(Capacity = max(Capacity, na.rm = TRUE ))

# Create colors scale for scale_color_manual()
colors_preventive_BB <- c(
  "#0000a3", "#002800", "#004900", "#006a00", "#008a00", "#00ab00", "#00cc00", "#00ec00", "#0eff0e"
  )

# Create alpha levels for scale_alpha()
alphas_preventive_BB <- c("#0.9", paste("#", seq(0.7, 0.35, by=-0.05), sep = ""))

# Guide labels
guide_labels_preventive_BB = c("NONE", "FIRST", "SECOND", "THIRD", "FOURTH", "FIFTH", "SIXTH", "SEVENTH", "EIGHT")


# Plot the chart
preventive_basic_BB <- ggplot(
  data = dfl_preventive_BB,
  aes(
    x = Year,
    y = Capacity,
    )
  ) +
  geom_area(
    aes(
      color = Regeneration,
      fill = Regeneration
     ),
    size = 1,
    alpha = 0.5,
    position = "dodge",
  ) +
  scale_x_continuous(
    limits = c(0, 17),
    breaks = breaks_width(2),
    "Years of battery use"
    ) +
  scale_y_continuous(
    limits = c(0, 100),
    breaks = c(0, 50, 75, 100),
    "Battery capacity [%]"
  ) +
  geom_hline(
    yintercept = 75,
    color = "darkgoldenrod",
    size = 0.75,
    alpha = 0.95
  ) +
    geom_vline(
      xintercept = 10,
      color = "darkorange",
      size = 1,
      alpha = 0.75
    ) +
    annotate(
      "label",
      x = 10.5, y = 100,
      label = "Designed lifespan",
      size = 4,
      hjust = 0.065,
      fill = "orange",
      color = "white",
      fontface = "bold",
      alpha = 0.7
    ) +
  scale_color_manual(
    values = colors_preventive_BB,
    #labels = guide_labels_preventive_BB,
    guide = FALSE,
  ) +
  scale_fill_manual(
    values = colors_preventive_BB,
    labels = guide_labels_preventive_BB,
  ) +
  scale_alpha_manual(
    values = alphas_preventive_BB,
    #guide=F
    ) +
  theme_ipsum_rc(
    grid = "Y",
    axis_title_size = 13
    ) +
  theme(
      legend.title = element_text(face = "bold"),
      legend.text = element_text(face = "bold")
    )

# Save it
ggsave(
  plot = preventive_basic_BB,
  here("currative-preventive", "output", "preventive_basic_BB.png"),
  dpi = 300,
  width = 2250, height = 1000, units = "px"
  )


# Add titles and description
preventive_with_titles_BB <- preventive_basic_BB +
  labs(
    x = "Years of battery life",
    y = "Battery capacity",
    title = "Preventive regeneration",
    subtitle = "Regeneration as a battery maintenance operation"
  ) #+
    # geom_text(
    #   data = labels_preventive_BB,
    #   aes(
    #     x = Year,
    #     y = Capacity,
    #     label = Capacity,
    #     ),
    #   nudge_y = 10
    #   ) +


# Save it
ggsave(
  plot = preventive_with_titles_BB,
  here("currative-preventive", "output", "preventive_with_titles_BB.png"),
  dpi = 300,
  width = 2250, height = 1000, units = "px"
)





# ******************************************************************************
# ******************************************************************************
# Currative
# ******************************************************************************
# ******************************************************************************

gs4_deauth()

# Load basic data for backup batteries
df_currative_BB <- read_sheet(
  "https://docs.google.com/spreadsheets/d/1OQSABH5vFd6GjAXIxo3FRCiZOnnETrOzJh3apjAQ8xY",
  sheet = 3,
  range = "A2:E71"
  # skip = 1
) %>%
  rename(
    No.Regeneration = 2
  ) %>%
  rename_all(
    ~str_replace(., " ", ".")
  ) %>%
  mutate(
    across(
      .cols = everything(),
      ~str_replace(., ",", ".")
    ),
    across(
      .cols = everything(),
      ~str_replace(., "%", "")
    ),
    across(
      .cols = everything(),
      ~ as.numeric(.x)
    ),
    # Year = as.factor(Year)
  )

# Save it as csv
write_csv(df_currative_BB, here("currative-preventive", "data", "df_currative_BB.csv"))



# Create data for automatic plotting of each column
dfl_currative_BB <- pivot_longer(
  df_currative_BB,
  cols = c(2, starts_with("Reg")),
  names_to = "Regeneration",
  values_to = "Capacity"
)
# Save it as csv
write_csv(dfl_currative_BB, here("currative-preventive", "data", "dfl_currative_BB.csv"))

# Create data frame for printing labels - how much capacity battery has
labels_currative_BB <- dfl_currative_BB %>%
  mutate(
    Year = floor(Year)
  ) %>%
  select(Year, Capacity) %>%
  group_by(Year) %>%
  summarise(Capacity = max(Capacity, na.rm = TRUE ))

# Create colors scale for scale_color_manual()
colors_currative_BB <- c("#0000a3", "#003300", "#004d00", "#008000")

# Create alpha levels for scale_alpha()
alphas_currative_BB <- c("#0.9", paste("#", seq(0.7, 0.35, by=-0.05), sep = ""))

# Guide labels
guide_labels_currative_BB = c("NONE", "FIRST", "SECOND", "THIRD")


# Plot the chart
#plot_currative_basic_BB <-
  ggplot(
  data = dfl_currative_BB,
  aes(x = Year, y = Capacity)
  ) +
  geom_area(
    aes(color = Regeneration, fill = Regeneration),
    size = 1,
    alpha = 0.6,
    position = "dodge",
  ) +
  scale_x_continuous(
    limits = c(0, 17),
    #breaks = breaks_width(2),
    breaks = c(0, 7, 10, 13, 15, 17),
    "Years of battery use"
  ) +
  scale_y_continuous(
    limits = c(0, 100),
    breaks = c(0, 50, 75, 100),
    "Battery capacity [%]"
  ) +
  scale_color_manual(
    values = colors_currative_BB,
    #labels = guide_labels_currative_BB,
    guide = FALSE,
  ) +
  scale_fill_manual(
    values = colors_currative_BB,
    labels = guide_labels_currative_BB,
    #guide = FALSE
  ) +
  # scale_alpha_manual(
  #   values = alphas_currative_BB,
  #   guide=F
  # ) +
  # Designed lifespan vertical rule + text
  geom_segment(
    x = 10, xend = 10,
    y = 0, yend = 95,
    color = "orange",
    size = 1
    ) +
  annotate("label",
    x = 8, y = 100,
    label = "Designed lifespan",
    size = 4,
    hjust = 0.075,
    fill = "orange",
    color = "white",
    fontface = "bold",
    alpha = 0.7
  ) +
  # Acceptable battery capacity vertical line + text
  geom_hline(
    yintercept = 75,
    color = "darkorange",
    size = 2,
    alpha = 0.75
  ) +
  geom_point(
    aes(x = a, y = b),
    data = data.frame(a = c(7, 10, 13), b = c(75, 75, 75)),
    size = 4,
    color = "yellowgreen"
  ) +
  geom_label(
    aes(x = df$x, y = df$y),
    df <- data.frame(
      x = c(3, 7),
      y = c(80, 50),
      t = c("Acceptable battery\ncapacity", "Points of battery\nregeneration"),
      clr = c("darkorange", "yellowgreen")),
    fill = df$clr,
    color = "white",
    label = df$t,
    size = 3,
    ) +
  annotate(
    geom = "segment",
    x = c(7, 10, 13), xend = c(7, 7, 7), y = c(75, 75, 75), yend = c(55, 55, 55),
    color = "yellowgreen",
    size = 1
  ) +
  theme_ipsum_rc(
    grid = "Y",
    axis_title_size = 13
  ) +
  theme(
    legend.title = element_text(face = "bold"),
    legend.text = element_text(face = "bold")
  )


# Save it
ggsave(
  plot = plot_currative_basic_BB,
  here( "charts", "currative-preventive", "output", "currative_basic_BB.png"),
  dpi = 300,
  width = 2250, height = 1000, units = "px"
)

# Add another regeneration or replacement
plot_currative_basic_BB <- plot_currative_basic_BB +
  geom_point(
    aes(x = 13, y = 75),
    size = 5,
    color = "khaki4"
  ) +
  geom_label(
    aes(x = 12, y = 50),
    size = 2.75,
    fill = "khaki4" ,
    color = "white",
    label = "Another regeneration\nor battery replacement"
  ) +
  annotate(
    geom = "segment",
    x = 13, xend = 12, y = 75, yend = 55,
    color = "khaki4",
  )

# Save it
ggsave(
  plot = plot_currative_basic_BB,
  here( "charts", "currative-preventive", "output", "currative_basic_BB.png"),
  dpi = 300,
  width = 2250, height = 1000, units = "px"
)

