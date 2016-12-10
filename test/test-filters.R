context('filters')

test_that('filter aggregate countries', {
  expect_equal(
    filterAggregateCountries(
      data.table(country = c('Hungary', 'Arab World'))
    ),
    data.table(country = c('Hungary'))
  )
})

test_that('filter for country', {
  expect_equal(
    filterForCountry(
      data.table(country = c('Hungary', 'Germany')), 'All'
    ),
    data.table(country = c('Hungary', 'Germany'))
  )
  expect_equal(
    filterForCountry(
      data.table(country = c('Hungary', 'Germany')), 'Hungary'
    ),
    data.table(country = c('Hungary'))
  )
  
})
