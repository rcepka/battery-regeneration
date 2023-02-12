#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#



# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {



# Prepare the dataframe
  backup_batt.TOC_df <- reactive(

    backup_batt.TOC %>% filter(
      Battery.Costs == input$in_battery_costs,
      Regeneration.Costs == input$in_regeneration_costs,
      Years.Initial == input$in_initial_years
    )
  )



# ************************************
# Table
# ************************************

output$reacttable <- renderReactable({

  reactable(backup_batt.TOC_df(),
            defaultColDef = colDef(
              show = F,
              #header = function(value) gsub(".", " ", value, fixed = TRUE),
              #cell = function(value) format(value, nsmall = 1),
              #headerStyle = list(background = "#f7f7f8"),
              align = "center"
              ),
            highlight = TRUE,
            bordered = TRUE,
            columns = list(
              TOC.y = colDef(name = "Battery",
                             show = T,
                             format = colFormat(
                               suffix = " €", separators = TRUE, digits = 0
                               )
                             ),
              Regeneration.Costs.y = colDef(name = "Regeneration",
                                            show = T,
                                            format = colFormat(
                                              suffix = " €", separators = T, digits = 0
                                              )
                                            ),
              TOC.savings.y.eur = colDef(
                name = "Yearly/€",
                show = T,
                format = colFormat(suffix = " €", separators = T, digits = 1),
                style = function(value) {
                  ifelse(value < 0, c(color <- "#FF0000", fontWeight <- "bold"), c(color <- "#11100f", fontWeight <- "normal"))
                  list(color = color, fontWeight = fontWeight)
                }

                ),
              TOC.savings.y.perc = colDef(name = "Yearly/%",
                                          show = T,
                                          format = colFormat(
                                            percent = T, digits = 1
                                            )
                                          ),
              Lifetime.Savings = colDef(name = "Lifetime",
                                        show = T,
                                        format = colFormat(
                                          suffix = " €", digits = 0
                                          )
                                        )
              ),
            columnGroups = list(
              colGroup(name = "Total ownership costs", columns = c("TOC.y", "Regeneration.Costs.y")),
              colGroup(name = "Savings", columns = c("TOC.savings.y.eur", "TOC.savings.y.perc", "Lifetime.Savings"))
            )
            )

})




# ************************************
# Plot
# ************************************

# # Plot rendering GGPlot
# output$ggplot <- renderPlot({
#   backup_batt.TOC_df() %>%
#     ggplot(
#       aes(
#         x = Years.Prolonged,
#         y = Lifetime.Savings
#         #size = Years.Initial,
#         #fill = as.factor(Years.Prolonged)
#         )
#       ) +
#     geom_bar(stat = "identity") +
#     scale_fill_hue(c = 60) +
#     theme(legend.position="none")
#
# })

# Plot rendering Plotly
output$plotly <- renderPlotly({
  backup_batt.TOC_df() %>%
    plot_ly(
      x = ~Years.Prolonged,
      y = ~Lifetime.Savings,
      type = "bar"
      )
})



})
