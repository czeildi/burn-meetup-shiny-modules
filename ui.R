shinyUI(fluidPage(
    title = "BURN - shiny modules",
    navbarPage(
        '',
        tabPanel(
            'raw data',
            fluidRow(
                column(6, dataPeekerUI('population')),
                column(6, dataPeekerUI('life_expectancy'))
            ),
            fluidRow(
                column(6, dataPeekerUI('GDP_per_capita_income')),
                column(6, dataPeekerUI('births_per_woman'))
            )
        )
    )
))
