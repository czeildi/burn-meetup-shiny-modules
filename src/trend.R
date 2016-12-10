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
                .[, .(median = median(get(series_name), na.rm = TRUE)), by = year]
            
            ggplot(dt) + 
                geom_line(aes(x = year, y = median)) + 
                expand_limits(y = 0) +
                ggtitle(str_c(
                    series_name, ' is plotted but ',
                    input$series_name, ' is accessible as well.'
                ))
        }
    })
}
