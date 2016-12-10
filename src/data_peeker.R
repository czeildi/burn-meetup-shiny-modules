dataPeekerUI <- function(id) {
    ns <- NS(id)
    tagList(
        h3(textOutput(ns('default'))),
        fluidRow(
            column(6, seriesSelector(id)),
            column(6, uiOutput(ns('country_selector')))
        ),
        dataTableOutput(ns('raw_data'))
    )
}

dataPeeker <- function(input, output, session, min_year) {
    output$raw_data <- renderDataTable({
        
         data() %>%
            filterForCountry(input$country) %>% 
            .[order(get(input$series_name))]
        
    }, options = list(pageLength = 5, lengthMenu = c(5,25,50,100,200)))
    
    output$default <- renderText({
        str_c('The default value is: ', str_replace(session$ns(''), '-', ''))
    })
    
    output$country_selector <- renderUI({
        ns <- session$ns
        selectInput(
            ns('country'), 'Choose country',
            choices = c('All', unique(data()$country))
        )
    })
    
    # last expression is returned as from any other function
    data <- reactive({
        
        pullBaseWdiData(input$series_name) %>% 
            filterWdiData(input$series_name, min_year())
        
    })
}
