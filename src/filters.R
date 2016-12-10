filterAggregateCountries <- function(dt) {
  real_countries <- WDI_data[['country']] %>% 
    data.table() %>% 
    .[region != 'Aggregates', country]
  dt[country %in% real_countries]
}

filterWdiData <- function(dt, series_name,
                          min_year = CONST[['wdi_start_year']],
                          max_year = year(Sys.Date())) {
  dt %>% 
    filterAggregateCountries() %>% 
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
