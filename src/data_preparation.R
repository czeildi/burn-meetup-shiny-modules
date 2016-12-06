pullBaseWdiData <- function(series_name) {
    # series: WDI_data[['series']]
    
    series_indicators <- c(
        'population'            = 'SP.POP.TOTL',
        'life_expectancy'       = 'SP.DYN.LE00.IN',
        'GDP_per_capita_income' = 'NY.GDP.PCAP.PP.CD',
        'births_per_woman'      = 'SP.DYN.TFRT.IN'
    )
    
    if (! series_name %in% names(series_indicators)) {
        stop(
            'data for this series is not available, choose one of ',
            str_c(names(series_indicators), collapse = ', '),
            call. = FALSE
        )
    }
    
    if (!dir.exists('data')) {dir.create('data')}
    file_name <- file.path('data', str_c(series_name, '.rds'))
    
    if (file.exists(file_name)) {
        readRDS(file_name)
    } else {
        WDI(
            indicator = series_indicators[[series_name]],
            country = 'all',
            start = CONST[['wdi_start_year']],
            end = year(Sys.Date())
        ) %>% 
            data.table() %>% 
            setnames(series_indicators[[series_name]], series_name) %T>% 
            saveRDS(file_name)
    }
}

filterAggregateCountries <- function(dt) {
    # countries: WDI_data[['country']]
    # where region == 'Aggregates'
}
