shinyServer(function(input, output) {
    callModule(dataPeeker, 'population')
    callModule(dataPeeker, 'life_expectancy')
    callModule(dataPeeker, 'GDP_per_capita_income')
    callModule(dataPeeker, 'births_per_woman')
    output$default <- renderText({
        'The default value is: '
    })
})
