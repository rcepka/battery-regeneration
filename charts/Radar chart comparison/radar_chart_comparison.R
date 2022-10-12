pacman::p_load(
  tidyverse,
  here,
  directlabels,
  fmsb,
  DiagrammeR,
  googlesheets4
)






data <- as.data.frame(
  read_sheet(
  "https://docs.google.com/spreadsheets/d/1kH_hIYEc_KI0Dit8tpRHmeiYWCMjvQJh7pc7e4wjrA4/edit#gid=1691262196",
  sheet = 2,
  range = "A3:I9",
  col_names = TRUE,
  )
  )

riadky <- data[,1]

row.names(data) <- riadky

data <- select(data, -1)

#data <- as.data.frame(data)

colors_border=c( rgb(0.2,0.5,0.5,0.99), rgb(0.8,0.2,0.5,0.9) , rgb(0.7,0.5,0.1,0.9), "red")
colors_in=c( rgb(0.2,0.5,0.5,0.4), rgb(0.8,0.2,0.5,0.4) , rgb(0.7,0.5,0.1,0.4), "red" )
radarchart(
  data,
  pcol=colors_border,
  #pfcol=colors_in,
  plwd=4,
  plty=1,
  #pcol = 2:6,
  #plwd = 1,
  vlcex=0.8,
  cglcol="grey", cglty=1, axislabcol="grey", caxislabels=seq(0,5,1), cglwd=0.8,
  #pfcol = "Green",
  maxmin = TRUE,
  )

legend(x=1.5, y=1, legend = rownames(data[-c(1,2),]), bty = "n", pch=20 , col=colors_in , text.col = "grey", cex=1.2, pt.cex=3)






data_BM <- as.data.frame(
  read_sheet(
    "https://docs.google.com/spreadsheets/d/1kH_hIYEc_KI0Dit8tpRHmeiYWCMjvQJh7pc7e4wjrA4/edit#gid=1691262196",
    sheet = 2,
    range = "A18:H24",
    col_names = TRUE,
  )
)

riadky <- data_BM[,1]

row.names(data_BM) <- riadky

data_BM <- select(data_BM, -1)

#data <- as.data.frame(data)

colors_border=c( rgb(0.2,0.5,0.5,0.99), rgb(0.8,0.2,0.5,0.9) , rgb(0.7,0.5,0.1,0.9), "red")
colors_in=c( rgb(0.2,0.5,0.5,0.4), rgb(0.8,0.2,0.5,0.4) , rgb(0.7,0.5,0.1,0.4), "red" )
radarchart(
  data_BM,
  pcol=colors_border,
  #pfcol=colors_in,
  plwd=4,
  plty=1,
  #pcol = 2:6,
  #plwd = 1,
  vlcex=0.8,
  cglcol="grey", cglty=1, axislabcol="grey", caxislabels=seq(0,5,1), cglwd=0.8,
  #pfcol = "Green",
  maxmin = TRUE,
)

legend(x=1.5, y=1, legend = rownames(data[-c(1,2),]), bty = "n", pch=20 , col=colors_in , text.col = "grey", cex=1.2, pt.cex=3)


