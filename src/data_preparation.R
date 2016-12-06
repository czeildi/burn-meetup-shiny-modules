pullBaseWdiData <- function(metric_name) {
    metric_indicators <- c(
        'population'            = 'SP.POP.TOTL',
        'life_expectancy'       = 'SP.DYN.LE00.IN',
        'GDP_per_capita_income' = 'NY.GDP.PCAP.PP.CD',
        'births_per_woman'      = 'SP.DYN.TFRT.IN'
    )
    
    if (! metric_name %in% names(metric_indicators)) {
        stop(
            'data for this metric is not available, choose one of ',
            str_c(names(metric_indicators), collapse = ', '),
            call. = FALSE
        )
    }
    
    if (!dir.exists('data')) {dir.create('data')}
    file_name <- file.path('data', str_c(metric_name, '.rds'))
    
    if (file.exists(file_name)) {
        readRDS(file_name)
    } else {
        WDI(
            indicator = metric_indicators[[metric_name]],
            country = 'all',
            start = CONST[['wdi_start_year']],
            end = year(Sys.Date())
        ) %>% 
            data.table() %>% 
            setnames(metric_indicators[[metric_name]], metric_name) %T>% 
            saveRDS(file_name)
    }
}
