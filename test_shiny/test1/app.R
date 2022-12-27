#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#


library(shinydashboard)


ui <- dashboardPage(


  dashboardHeader(
    title = "test"

  ),


  dashboardSidebar(
    title = "test2",
    sidebarMenu(
      menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
      menuItem("Widgets", tabName = "widgets", icon = icon("th"))
    ),
    sliderInput("slider2", "Number of observations:", 1, 100, 50)

  ),


  dashboardBody(

    fluidRow(
      box(
        title = "Controls",
        sliderInput("slider", "Number of observations:", 1, 100, 50),
        actionButton("action", "My button")
      ),
      box(
        textOutput(outputId = "out"),
        textOutput("action_out")
      )


    )

  )

)




server <- function(input, output) {

  observeEvent(input$action, {

    output$action_out <- renderText(
      {runif(paste
        ("slider: ", input$slider)
      )
        }
      )
    }
  )
  }

shinyApp(ui, server)
