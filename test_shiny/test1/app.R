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
    )

  ),


  dashboardBody(

    fluidRow(
      box(
        title = "Controls",
        sliderInput("slider", "Number of observations:", 1, 100, 50)
      ),

      textOutput(outputId = "out")


    )

  )

)




server <- function(input, output) {
  a <- "slider"
  output$out <- renderText({
    paste("slider:", input$slider)
    })

  }

shinyApp(ui, server)
