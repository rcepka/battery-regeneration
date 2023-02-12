#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
if (!require("pacman")) install.packages("pacman")

pacman::p_load(
  shiny,
  tidyverse,
  ggplot2,
  plotly,
  DT,
  reactable,
  shinyWidgets
)

# library(shiny)
# library(tidyverse)
# library(ggplot2)
# library(plotly)
# library(DT)

source("data.R")


# Define UI for application that draws a histogram
shinyUI(

  fluidPage(

    # Application title
    titlePanel("Battery total ownership costs"),


    wellPanel(

      fluidRow(

        column(3,

               selectInput("in_battery_costs", label = "Battery costs",
                           choices = battery_costs
                           #selected = 1
                           ),
        ),

        column(3,

               selectInput("in_regeneration_costs", label = "Regeneration costs",
                           choices = regeneration_costs,
                           selected = 15
              ),
        ),

        column(3,

               selectInput("in_initial_years", "Initial years",
                          choices = initial_years)
               ),
        )
      ),


    # Another row
    fluidRow(

      column(6,
             #plotOutput("ggplot"),
             plotlyOutput("plotly"),
             ),


      column(6,
             DTOutput("dttable"),
             reactableOutput("reacttable"),
             )

      )
    )
  )
