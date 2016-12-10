distributionUI <- function(id) {
  ns <- NS(id)
  tagList(
    h3(textOutput(ns('namespace_text')), align = 'center'),
    distributionPlotUI(ns('1980')),
    distributionPlotUI(ns('2000'))
  )
}


distribution <- function(input, output, session) {
  callModule(distributionPlot, '1980')
  callModule(distributionPlot, '2000')
  namespaceText(input, output, session)
}


namespaceText <- function(input, output, session) {
  output$namespace_text <- renderText({
    str_c('"Namespace": ', session$ns(''))
  })
}


distributionPlotUI <- function(id) {
  ns <- NS(id)
  start_year <- as.numeric(str_match(id, '[[:digit:]]+')[[1]])
  
  tagList(
    fluidRow(
      column(6, yearSelector(id, 'start', start_year)),
      column(6, yearSelector(id, 'end', start_year + 20))
    ),
    h4(textOutput(ns('inner_namespace'))),
    plotOutput(ns('distribution'), height = 200)
  )
}


distributionPlot <- function(input, output, session) {
  inner_namespace <- reactive({
    session$ns('')
  })
  
  output$distribution <- renderPlot({
    
    series_name <- str_split(inner_namespace(), '-')[[1]][1]
    
    pullBaseWdiData(series_name) %>% 
      filterWdiData(series_name, input$start, input$end) %>% 
      histPlot(series_name)
  })
  
  output$inner_namespace <- renderText({
    str_c('"Inner namespace": ', inner_namespace())
  })
}


histPlot <- function(dt, series_name) {
  
  max_value <- ifelse(series_name == 'births_per_woman', 8, 150000)
  
  ggplot(dt) + 
    geom_histogram(aes_string(x = series_name), bins = 20) + 
    coord_cartesian(xlim = c(0, max_value))
}

