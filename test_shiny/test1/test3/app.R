library(shiny)
library(shinipsum)
library(DT)
ui <- fluidPage(
  h2("A Random DT"),
  DTOutput("data_table"),
  h2("A Random Image"),
  plotOutput("image", height = "300px"),
  h2("A Random Plot"),
  plotOutput("plot"),
  h2("A Random Print"),
  verbatimTextOutput("print"),
  h2("A Random Table"),
  tableOutput("table"),
  h2("A Random Text"),
  tableOutput("text")
)

server <- function(input, output, session) {
  output$data_table <- DT::renderDT({
    random_DT(10, 5)
  })
  output$image <- renderImage({
    random_image()
  })
  output$plot <- renderPlot({
    random_ggplot()
  })
  output$print <- renderPrint({
    random_print("model")
  })
  output$table <- renderTable({
    random_table(10, 5)
  })
  output$text <- renderText({
    random_text(nwords = 50)
  })
}
shinyApp(ui, server)
