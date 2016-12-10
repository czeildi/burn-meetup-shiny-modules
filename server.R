shinyServer(function(input, output) {
    
    min_year <- reactive({
        input$`global-start`
    })
    
    population_data <- callModule(dataPeeker, 'population', min_year)
    callModule(dataPeeker, 'life_expectancy', min_year)
    
    output$trend_chosen_series <- renderText({
        str_c(
            input$`population-trend_series_name`,
            ' and ',
            input$`life_expectancy-trend_series_name`,
            ' have been chosen'
        )
    })
    
    callModule(trend, 'population', min_year)
    callModule(trend, 'life_expectancy', min_year)
    
    callModule(distribution, 'births_per_woman')
    callModule(distribution, 'GDP_per_capita_income')
    
    output$population_data <- renderDataTable({
        population_data()
    })
})
