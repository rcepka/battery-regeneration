if (!require("pacman")) install.packages("pacman")

pacman::p_load(
  tidyverse,
  googlesheets4,
  googledrive,
  readxl,
  highcharter,
  here,
  directlabels,
  ggthemes,
  hrbrthemes,
  scales,
  ggforce
)


data <- read_csv("Pali/data.csv")


data2 <- data %>%
  separate(3, into = c("a", "b", "c", "d"))



data2 <- data %>%
  separate_rows(3, convert = TRUE) %>%
  separate_rows(4, convert = TRUE) %>%
  separate_rows(5, convert = TRUE) %>%
  separate_rows(6, convert = TRUE) %>%
  drop_na()







d <- data_frame(a = c("1.2,2.9,3","4.8,5,9", "1,2,3"), b=c(1:3))
d2 <- separate_rows(d,1, convert=FALSE)
d3 <- separate_rows(d,1, convert=TRUE)




