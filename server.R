shinyServer(function(input, output) {
  
  min_year <- reactive({
    input$`global-start`
  })
  
  population_data <- callModule(
    dataPeeker, 'population', min_year
  )
  life_expectancy_data <- callModule(
    dataPeeker, 'life_expectancy', min_year
  )
  
  callModule(trend, 'population', min_year)
  callModule(trend, 'life_expectancy', min_year)
  
  callModule(distribution, 'births_per_woman')
  callModule(distribution, 'GDP_per_capita_income')
  
  output$population_data <- renderDataTable({
    population_data()
  })
})
