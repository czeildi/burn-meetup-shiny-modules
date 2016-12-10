<!-- no title top of each slide -->


BURN - 30th meetup
========================================================
title: false
author: Ildikó Czeller -- Data Analyst @Emarsys
date: 2016-12-14
autosize: true

# shiny modules in practice

Shiny: web framework for R
========================================================
title: false

### server side

```r
shinyServer(function(input, output) {
    
    output$my_plot <- renderPlot({
        ggplot(mtcars, aes(wt, mpg)) +
        geom_point()
    })
})
```
### ui side

```r
shinyUI(fluidPage(
  
  title = 'Plot',
  plotOutput('my_plot')
))
```

corresponding server and ui: modules
========================================================
title: false
### server module

```r
dataPeeker <- function(input, output, session) {
  # refer to any input element under same id
  output$raw_data <- renderDataTable({
    pullBaseWdiData(input$series_name)
  })
}
```

### ui module

```r
dataPeekerUI <- function(id) {
  ns <- NS(id)
  # ns('any_text') == `id`-any_text
  dataTableOutput(ns('raw_data'))
}
```


corresponding server and ui
========================================================
title: false

## server side

```r
callModule(dataPeeker, 'population')
callModule(dataPeeker, 'life_expectancy')
```

## ui side

```r
dataPeekerUI('population'),
dataPeekerUI('life_expectancy')
```

- `dataPeeker` <--> `dataPeekerUI` : good convention
- called with same id, namely `population`: must have


========================================================

# Questions?

Reference
========================================================

- <https://github.com/czeildi/burn-meetup-shiny-modules>
- <https://twitter.com/czeildi>
