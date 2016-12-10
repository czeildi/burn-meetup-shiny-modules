pullBaseWdiData <- function(series_name) {
    if (! series_name %in% names(series_indicators)) {
        stop(str_c(
             'data for ', 
             series_name,
             ' is not available, choose one of ',
             str_c(names(series_indicators), collapse = ', ')
        ), call. = FALSE)
    }
    
    if (!dir.exists('data')) {dir.create('data')}
    file_name <- file.path('data', str_c(series_name, '.rds'))
    
    if (file.exists(file_name)) {
        readRDS(file_name) %>% .[, iso2c := NULL]
    } else {
        WDI(
            indicator = series_indicators[[series_name]],
            country = 'all',
            start = CONST[['wdi_start_year']],
            end = year(Sys.Date())
        ) %>% 
            data.table() %>% 
            setnames(series_indicators[[series_name]], series_name) %T>% 
            saveRDS(file_name) %>% 
            .[, iso2c := NULL]
    }
}

filterWdiData <- function(dt, series_name,
                          min_year = CONST[['wdi_start_year']],
                          max_year = year(Sys.Date())) {
    dt %>% 
        .[complete.cases(.)] %>% 
        .[year >= min_year & year <= max_year] %>% 
        .[get(series_name) > 0]
}

filterForCountry <- function(dt, country_param) {
    if (is.null(country_param) || country_param == 'All') {
        return (dt)
    }
    dt[country == country_param]
}
