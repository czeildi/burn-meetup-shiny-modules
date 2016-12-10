distributionUI <- function(id) {
    ns <- NS(id)
    tagList(
        h3(textOutput(ns('test')), align = 'center'),
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
    text(input, output, session)
}

distributionPlotUI <- function(id) {
    ns <- NS(id)
    tagList(
        fluidRow(
            column(6, yearSelector(id, 'start', as.numeric(str_match(id, '[[:digit:]]+')[[1]]))),
            column(6, yearSelector(id, 'end', as.numeric(str_match(id, '[[:digit:]]+')[[1]]) + 20))
        ),
        plotOutput(ns('distribution'), height = 200)
    )
}

distributionPlot <- function(input, output, session, series_name) {
    output$distribution <- renderPlot({
        
        dt <- pullBaseWdiData(series_name) %>% 
            filterWdiData(series_name, input$start, input$end)
        
        m <- ifelse(series_name == 'births_per_woman', 8, 150000)
        
        ggplot(dt) + 
            geom_histogram(aes_string(x = series_name), bins = 20, fill = 'darkblue') + 
            coord_cartesian(xlim = c(0, m))
    })
}

text <- function(input, output, session) {
    output$test <- renderText({
        str_c('"Namespace": ', session$ns(''))
    })
}
