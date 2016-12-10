trendUI <- function(id) {
    ns <- NS(id)
    tagList(
        seriesSelector(id, prefix = 'trend_'),
        plotOutput(ns('trendline'), height = 600)
    )
}

trend <- function(input, output, session) {
    output$trendline <- renderPlot({
        series_name <- input$trend_series_name
        
        dt <- pullBaseWdiData(series_name) %>% 
            .[, median(get(series_name), na.rm = TRUE), by = 'year'] %>%
            .[complete.cases(.)] %>% 
            setnames('V1', str_c('median_', series_name))
        
        ggplot(dt) + 
            geom_line(aes_string(x = 'year', y = str_c('median_', series_name))) + 
            expand_limits(y = 0) +
            ggtitle(str_c(series_name, ' is plotted but ', input$series_name, ' is accessible as well.'))
    })
}
