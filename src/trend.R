trendUI <- function(id) {
    ns <- NS(id)
    tagList(
        seriesSelector(id, prefix = 'trend_'),
        plotOutput(ns('trendline'), height = 400)
    )
}

trend <- function(input, output, session, min_year) {
    output$trendline <- renderPlot({
        if (input$show_trendline) {
            series_name <- input$trend_series_name
            
            dt <- pullBaseWdiData(series_name) %>% 
                filterWdiData(series_name, min_year()) %>% 
                .[, median(get(series_name), na.rm = TRUE), by = 'year'] %>%
                setnames('V1', str_c('median_', series_name))
            
            ggplot(dt) + 
                geom_line(aes_string(x = 'year', y = str_c('median_', series_name))) + 
                expand_limits(y = 0) +
                ggtitle(str_c(
                    series_name, ' is plotted but ',
                    input$series_name, ' is accessible as well.'
                ))
        }
    })
}
