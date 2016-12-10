trendUI <- function(id) {
  ns <- NS(id)
  tagList(
    h4(textOutput(ns('show_selectors'))),
    seriesSelector(id, prefix = 'trend_'),
    plotOutput(ns('trendline'), height = 400)
  )
}

trend <- function(input, output, session, min_year) {
  
  output$show_selectors <- renderText({
    str_c(
      'In this tab, ',
      input$trend_series_name,
      ' is selected while on the data peeker tab, ',
      input$series_name, '.'
    )
  })
  
  output$trendline <- renderPlot({
    if (input$show_trendline) {
      series_name <- input$trend_series_name
      
      dt <- pullBaseWdiData(series_name) %>% 
        filterWdiData(series_name, min_year()) %>% 
        .[, .(median = median(get(series_name), na.rm = TRUE)), by = year]
      
      ggplot(dt) + 
        geom_line(aes(x = year, y = median), col = 'darkgreen') + 
        expand_limits(y = 0) +
        ggtitle(input$trend_series_name)
    }
  })
}
