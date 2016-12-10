dataPeekerUI <- function(id) {
    ns <- NS(id)
    tagList(
        h2(textOutput(ns('my_default'))),
        h2(id),
        seriesSelector(id),
        dataTableOutput(ns('raw_data'))
    )
}

dataPeeker <- function(input, output, session) {
    output$raw_data <- renderDataTable({
        pullBaseWdiData(input$series_name) %>% 
            .[, iso2c := NULL] %>% 
            .[get(input$series_name) > 0] %>% 
            .[order(get(input$series_name))]
    }, options = list(pageLength = 5, lengthMenu = c(5,25,50,100,200)))
    
    output$my_default <- renderText({
        'Here the default value is: '
    })
}
