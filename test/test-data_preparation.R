context('pull data for selected metrics')

test_that('stop when metric is not available', {
  expect_error(
    pullBaseWdiData('some_series_name'),
    str_c(
      'data for some_series_name is not available, choose one of population, ',
      'life_expectancy, GDP_per_capita_income, births_per_woman'
    )
  )
})
