shinyServer(function(input, output) {
    callModule(dataPeeker, 'population')
    callModule(dataPeeker, 'life_expectancy')
    output$default <- renderText({
        'The default value is: '
    })
    callModule(trend, 'population')
    callModule(trend, 'life_expectancy')
    output$trend_chosen_series <- renderText({
        str_c(
            input$`population-trend_series_name`,
            ' and ',
            input$`life_expectancy-trend_series_name`,
            ' have been chosen'
        )
    })
})
