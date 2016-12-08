shinyServer(function(input, output) {
    callModule(dataPeeker, 'population')
    callModule(dataPeeker, 'life_expectancy')
    output$default <- renderText({
        'The default value is: '
    })
})
