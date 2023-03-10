#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

#source("data.R")


# Define UI for application that draws a histogram
#shinyUI(

  # # Version I
  # fluidPage(
  #
  #   # Application title
  #   titlePanel("Battery total ownership costs"),
  #
  #
  #   wellPanel(
  #
  #     fluidRow(
  #
  #       column(3,
  #
  #              selectInput("in_battery_costs", label = "Battery costs",
  #                          choices = battery_costs
  #                          #selected = 1
  #                          ),
  #       ),
  #
  #       column(3,
  #
  #              selectInput("in_regeneration_costs", label = "Regeneration costs",
  #                          choices = regeneration_costs,
  #                          selected = 15
  #             ),
  #       ),
  #
  #       column(3,
  #
  #              selectInput("in_initial_years", "Initial years",
  #                         choices = initial_years)
  #              ),
  #       ),
  #     ),
  #
  #
  #   # Another row
  #   fluidRow(
  #
  #     column(6,
  #            tabsetPanel(
  #              tabPanel("Name", plotlyOutput("plotly_savings_e", height = "300px")),
  #              tabPanel("Name2", plotOutput("ggplot", height = "300px"))
  #            )
  #     ),
  #
  #
  #     column(6,
  #            h3("Total ownership costs data"),
  #            reactableOutput("reacttable"),
  #            )
  #
  #     )
  #   )

#
#
#
#


  # Version II

# Define UI for application that draws a histogram
ui <- shinyUI(



  fluidPage(

    theme = bs_theme(bootswatch = "minty"),

    # Application title
    titlePanel("Battery total ownership costs"),

    sidebarLayout(

      sidebarPanel(width = 2,

        selectInput("in_battery_costs", label = "Battery costs",
                                   choices = battery_costs
                                   #selected = 1
                          ),

        selectInput("in_regeneration_costs", label = "Regeneration costs",
                             choices = regeneration_costs,
                             selected = 15
                    ),

        selectInput("in_initial_years", "Initial years",
                             choices = initial_years
                    )
      ),


    mainPanel(width = 10,

      tabsetPanel(
               tabPanel("Chart", class = "p-3 border border-top-0 rounded-bottom", plotlyOutput("plotly_savings_e", height = "300px")),
               tabPanel("Table", class = "p-3 border border-top-0 rounded-bottom",  reactableOutput("reacttable"))
            ),
      #reactableOutput("reacttable")
      #plotOutput("ggplot", height = "300px")
    )
    )
  )
)
