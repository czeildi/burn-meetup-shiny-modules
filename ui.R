shinyUI(fluidPage(
    title = "BURN - shiny modules",
    navbarPage(
        '',
        tabPanel(
            'raw data',
            column(6, dataPeekerUI('population')),
            column(6, dataPeekerUI('life_expectancy'))
        ),
        tabPanel(
            'trend',
            h3(textOutput('trend_chosen_series'), align = 'center'),
            column(6, trendUI('population')),
            column(6, trendUI('life_expectancy'))
        ),
        tabPanel(
            'settings',
            checkboxInput('population-show_trendline', 'Show population trendline:', value = TRUE),
            checkboxInput('life_expectancy-show_trendline', 'Show life expectancy trendline:', value = TRUE),
            numericInput('min_year', 'First year', min = 1960, max = 2015, value = 1960)
        )
    )
))
