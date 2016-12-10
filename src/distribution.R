distributionUI <- function(id) {
    ns <- NS(id)
    tagList(
        h3(textOutput(ns('namespace_text')), align = 'center'),
        distributionPlotUI(ns('1980')),
        distributionPlotUI(ns('2000'))
    )
}

distribution <- function(input, output, session) {
    series_name <- reactive({
        str_replace(session$ns(''), '-', '')
    })
    callModule(distributionPlot, '1980', series_name())
    callModule(distributionPlot, '2000', series_name())
    namespaceText(input, output, session)
}

distributionPlotUI <- function(id) {
    ns <- NS(id)
    start_year <- as.numeric(str_match(id, '[[:digit:]]+')[[1]])
    
    tagList(
        fluidRow(
            column(6, yearSelector(id, 'start', start_year)),
            column(6, yearSelector(id, 'end', start_year + 20))
        ),
        plotOutput(ns('distribution'), height = 200)
    )
}

distributionPlot <- function(input, output, session, series_name) {
    output$distribution <- renderPlot({
        
        dt <- pullBaseWdiData(series_name) %>% 
            filterWdiData(series_name, input$start, input$end)
        
        max_value <- ifelse(series_name == 'births_per_woman', 8, 150000)
        
        ggplot(dt) + 
            geom_histogram(aes_string(x = series_name), bins = 20) + 
            coord_cartesian(xlim = c(0, max_value))
    })
}

namespaceText <- function(input, output, session) {
    output$namespace_text <- renderText({
        str_c('"Namespace": ', session$ns(''))
    })
}
