seriesSelector <- function(id, prefix = '') {
    ns <- NS(id)
    selectInput(
        ns(str_c(prefix, 'series_name')), 'Choose series:',
        choices = names(series_indicators), selected = id
    )
}

yearSelector <- function(id, name, value) {
    ns <- NS(id)
    numericInput(
        ns(name), str_c('Choose ', name, ' year'),
        min = CONST[['wdi_start_year']], max = year(Sys.Date()), value = value
    )
}
