if (!require("pacman")) install.packages("pacman")

pacman::p_load(
  tidyverse,
  here,
  directlabels,
  ggthemes,
  hrbrthemes,
  scales,
  ggforce,
  eurostat
)


# Get the dataset from eurostat,
# table: "Goods road transport enterprises, by number of vehicles"
# Note: relevant table but very incomplete
road_transport_enterprises <- get_eurostat("road_ec_entveh")


# We will better select different table - all trucks dataset
# it is much more complete than table above
# So get the dataset from eurostat,
road_transport_vehicle_quantities <- get_eurostat("road_eqs_lorroa")


# ******************************************************************************
# modify the dataset, all vehicle types
# ******************************************************************************
road_transport_vehicle_quantities_all <- road_transport_vehicle_quantities %>%
  # filter just records for all age vehicles (TOTAL) and for year 2020
  filter(
    time == "2020-01-01",
    age == "TOTAL"
  ) %>%
  rename(
    vehicle.quantity = values
  ) %>%
  # remove unneeded columns
  select(-unit, -age, -time) %>%
  # change large numbers of vehicle quantities
  mutate(
    vehicle.quantity = vehicle.quantity / 1000
  ) %>%
  arrange(geo, match(vehicle, c("TRC", "VG_GT3P5", "VG_LE3P5")))

road_transport_vehicle_quantities_all <- road_transport_vehicle_quantities_all %>%
  group_by(geo)


plot_road_transport_vehicle_quantities_all <- ggplot(
  subset(road_transport_vehicle_quantities_all,
         geo %in% c("AT", "BE", "BG", "CY", "CZ", "DE", "DK", "ES", "FI", "FR",
                    "HU", "IT", "NL", "NO", "PL", "RO", "SE", "SK", "TR")),
  aes(
    x = geo,
    y = vehicle.quantity,
    color = vehicle,
    fill = vehicle,
    #group = vehicle
    )
  ) +
  geom_bar(
    stat = "identity"
    ) +
  labs(
    x = "Country",
    y = "Number of vehicles [ths of units]"
    ) +
  theme_ipsum_rc(grid="Y")


# Save it
ggsave(
  plot = plot_road_transport_vehicle_quantities_all,
  here("marketing", "transport_companies", "outputs", "plot_road_transport_vehicle_quantities_all.png"),
  dpi = 300,
  width = 2250, height = 1000, units = "px"
)




# ******************************************************************************
# Only heavy-duty vehicles 3.5t and above
# ******************************************************************************
road_transport_vehicle_quantities_HVY <- road_transport_vehicle_quantities_all %>%
  # filter just records for all age vehicles (TOTAL) and for year 2020
  filter(
    vehicle != "VG_LE3P5",
    ) %>%
  arrange(geo, match(vehicle, c("TRC", "VG_GT3P5")))


plot_road_transport_vehicle_quantities_HVY <-  ggplot(
  subset(road_transport_vehicle_quantities_HVY,
         geo %in% c("AT", "BE", "BG", "CY", "CZ", "DE", "DK", "ES", "FI", "FR",
                    "HU", "IT", "NL", "NO", "PL", "RO", "SE", "SK", "TR")),
  aes(
    x = geo,
    y = vehicle.quantity,
    color = vehicle,
    fill = vehicle,
    #group = vehicle
  )
) +
  geom_bar(
    stat = "identity"
  ) +
  labs(
    x = "Country",
    y = "Number of vehicles [ths of units]"
  ) +
  theme_ipsum_rc(grid="Y")

# Save it
ggsave(
  plot = plot_road_transport_vehicle_quantities_HVY,
  here("marketing", "transport_companies", "outputs", "plot_road_transport_vehicle_quantities_HVY.png"),
  dpi = 300,
  width = 2250, height = 1000, units = "px"
)




# ******************************************************************************
# Summary of heavy-duty vehicles 3.5t and above
# ******************************************************************************
road_transport_vehicle_quantities_HVY_SUM <- road_transport_vehicle_quantities_HVY %>%
  group_by(geo) %>%
  summarise(
    vehicle.quantity = sum(vehicle.quantity)
  )


#plot_road_transport_vehicle_quantities_HVY_SUM <-
  ggplot(
  subset(road_transport_vehicle_quantities_HVY_SUM,
         geo %in% c("AT", "BE", "BG", "CY", "CZ", "DE", "DK", "ES", "FI", "FR",
                    "HU", "IT", "NL", "NO", "PL", "RO", "SE", "SK", "TR")),
  aes(
    x = geo,
    y = vehicle.quantity
  )
) +
  geom_bar(
    stat = "identity",
   # fill = "blue"
  ) +
  scale_y_continuous(
    labels = label_number(accuracy = NULL, scale = 1,
                          prefix = "", suffix = "A",
                          big.mark = " ", decimal.mark = ".")
  ) +
  labs(
    x = "Selected countries",
    y = "Number of vehicles [ths of units]"
  ) +
  theme_ipsum_rc(grid="Y")

# Save it
ggsave(
  plot = plot_road_transport_vehicle_quantities_HVY_SUM,
  here("marketing", "transport_companies", "outputs", "plot_road_transport_vehicle_quantities_HVY_SUM.png"),
  dpi = 300,
  width = 2250, height = 1000, units = "px"
)












road_transport_vehicle_quantities_all <- road_transport_vehicle_quantities %>%
  # filter just All vehicles 3,5t & over and only for year 2020
  filter(
    age =="TOTAL",
    vehicle != "VG_LE3P5",
    time == "2020-01-01"
  ) %>%
  # remove unneeded columns
  #select(-unit, -vehicle) %>%
  arrange(geo)





# Add country names
eu_countries <- eu_countries %>%
  rename(geo = code) %>%
  select(-label)
  # inconsistent coundry codes
  #mutate(geo = replace(geo, geo=="LT, LI"))

# Some tidying ...
road_transport_enterprises <- road_transport_enterprises %>%
  left_join(eu_countries, by = "geo")

road_transport_enterprises <- road_transport_enterprises %>%
  rename(
    country.name = name,
    country.code = geo) %>%
  relocate(country.code, .before = unit) %>%
  relocate(country.name, .after = country.code) %>%
  select(-unit)



road_transport_enterprises <- road_transport_enterprises %>%
  group_by(country.code, country.name, n_vehicl) %>%
  summarise(
    values = round(mean(values), 1))  %>%
  arrange(match(n_vehicl, c( "1",  "2-5", "6-9", "10-19", "20-49", "GE50", "TOTAL")), (country.name))


# Atach the population information
# Serach eustat for tables
population_eurostat_query <- search_eurostat("Population on 1 January (tps00001)")

eu_population <- get_eurostat("tps00001")
