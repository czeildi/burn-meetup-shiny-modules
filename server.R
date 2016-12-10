shinyServer(function(input, output) {
    
    output$default <- renderText({
        'The default value is: '
    })
    
    min_year <- reactive({input$min_year})
    
    callModule(dataPeeker, 'population', min_year)
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
    
})
