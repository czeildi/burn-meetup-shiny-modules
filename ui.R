shinyUI(fluidPage(
  title = "BURN - shiny modules",
  navbarPage(
    'demo shiny modules',
    tabPanel(
      'peek into data',
      column(6, dataPeekerUI('population')),
      column(6, dataPeekerUI('life_expectancy'))
    ),
    tabPanel(
      'trendline',
      h3(textOutput('trend_chosen_series'), align = 'center'),
      column(6, trendUI('population')),
      column(6, trendUI('life_expectancy'))
    ),
    tabPanel(
      'nesting modules',
      column(6, distributionUI('births_per_woman')),
      column(6, distributionUI('GDP_per_capita_income'))
    ),
    tabPanel(
      'returned reactive',
      dataTableOutput('population_data')
    ),
    tabPanel(
      'global settings',
      checkboxInput(
        'population-show_trendline', 'Show population trendline:', value = TRUE
      ),
      checkboxInput(
        'life_expectancy-show_trendline', 'Show life expectancy trendline:',
        value = TRUE
      ),
      yearSelector('global', 'start', CONST[['wdi_start_year']])
    )
  )
))
