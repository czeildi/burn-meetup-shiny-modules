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
            column(6, trendUI('population')),
            column(6, trendUI('life_expectancy'))
        )
    )
))
