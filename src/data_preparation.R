pullBaseWdiData <- function(series_name) {
    if (! series_name %in% names(series_indicators)) {
        stop(str_c(
             'data for ', 
             series_name,
             ' is not available, choose one of ',
             str_c(names(series_indicators), collapse = ', ')
        ), call. = FALSE)
    }
    
    if (!dir.exists('data')) {
        dir.create('data')
    }
    file_name <- file.path('data', str_c(series_name, '.rds'))
    
    if (file.exists(file_name)) {
        dt <- readRDS(file_name)
    } else {
        dt <- WDI(
            indicator = series_indicators[[series_name]],
            country = 'all',
            start = CONST[['wdi_start_year']],
            end = year(Sys.Date())
        ) %>% 
            data.table() %>% 
            setnames(series_indicators[[series_name]], series_name) %T>% 
            saveRDS(file_name)
    }
    dt[, iso2c := NULL][]
}
