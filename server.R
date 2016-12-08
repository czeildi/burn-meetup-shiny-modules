shinyServer(function(input, output) {
    callModule(dataPeekeer, 'population')
    callModule(dataPeekeer, 'life_expectancy')
    output$default <- renderText({
        'The default value is: '
    })
})
