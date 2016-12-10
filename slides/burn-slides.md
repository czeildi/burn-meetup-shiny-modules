<!-- no title top of each slide -->


BURN - 30th meetup
========================================================
title: false
author: Ildikó Czeller -- Data Analyst @Emarsys
css: custom.css
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
- called with same id, namely ~~population~~: must have

same id, multiple modules 1
========================================================
title: false
## ui side

```r
countryShowerUI <- function(id) {
  checkboxInput(
    NS(id)('country'), 'show countries'
  )
}
yearSelectorUI <- function(id) {
  numericInput(
    NS(id)('year'), 'Year:', value = 2000
  )
}
```

```r
countryShowerUI('population')
yearSelectorUI('population') 
checkboxInput('population-x', 'X:')
```

same id, multiple modules 2
========================================================
title: false
## server side

```r
filters <- function(input, output, session) {
  output$text <- renderText({
    str_c(
      input$country,
      ' and ',
      input$year,
      ' and ',
      input$x
    )
  })
}
```

```r
callModule(filters, 'population')
```

access module ui-s from outside
========================================================
title: false
## ui side

```r
yearSelectorUI('global')
```
## server side

```r
global_year <- reactive({
  
  input$`global-year`
  
})
```

pass reactives to module
========================================================
title: false
## server side

```r
global_year <- reactive({
  input$`global-year`
})

callModule(dataPeeker, 'popul', global_year)
```

```r
dataPeeker <- function(input, output, 
                       session, year) {
  
  output$dt <- renderDataTable({
    data() %>% 
      filterForYear(year())
  })
}
```
reactive ui
========================================================
title: false
## server side

```r
countrySelector <- function(input, output,
                            session) {
  
  output$country_selector <- renderUI({
    
    ns <- session$ns
    
    selectInput(
      ns('country'), '?', choices = countries
    )
  })
  
  chosen_country <- reactive({
    input$country
  })
}
```

return reactive from module
========================================================
title: false
## server side

```r
countrySelector <- function(input, output,
                            session) {
  # ...
  # this is returned: last reactive
  chosen_country <- reactive({
    input$country
  })
}

country <- callModule(countrySelector, 'popul')
output$popul_chosen_country <- renderText({
  country()
})
```

nesting modules 1
========================================================
title: false

========================================================

# Questions?

Reference
========================================================

- <https://github.com/czeildi/burn-meetup-shiny-modules>
- <https://twitter.com/czeildi>
