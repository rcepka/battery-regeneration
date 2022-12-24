

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





backup_batt <- tibble(
  Y.init = rep(6:10, each = 1, times = 4500),
  Y.prol = rep(1:5, each = 5, times=900),
  Reg.Costs = rep(1:100, each = 25, times = 9),
  Batt.Costs = rep( c(100, 125, 150, 175, 200, 250, 300, 400, 500), each = 2500, times = 1)

)
