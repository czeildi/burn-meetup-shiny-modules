seriesSelector <- function(id, prefix = '') {
    ns <- NS(id)
    selectInput(
        ns(str_c(prefix, 'series_name')), 'Choose series:',
        choices = names(series_indicators), selected = id
    )
}
