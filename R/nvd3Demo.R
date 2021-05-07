#' NVD3 Demo
#'
#' Running Shiny App
#'
#' @import htmlwidgets
#' @import shiny
#'
#' @examples
#' library(nvd3R)
#' nvd3Demo()
#'
#' @export
nvd3Demo <- function(){
  library(shiny)
  ui <- fluidPage(
    tags$br(),
    sidebarLayout(
      sidebarPanel(
        selectInput(
          inputId = "input01",
          label = "Select a type chart",
          choices = c("barplot", "piechart", "donutchart", "boxplot")
        ),
        selectInput(
          inputId = "xvar",
          label = "X-variable",
          choices = names(mtcars)
        ),
        selectInput(
          inputId = "yvar",
          label = "Y-variable",
          choices = names(mtcars)
        ),
        textInput(
          inputId = "lab01",
          label = "Xlab",
          value = "X-axis"
        ),
        textInput(
          inputId = "lab02",
          label = "Ylab",
          value = "Y-axis"
        ),
        actionButton(
          inputId = "submit01",
          label = "RUN"
        )
      ),
      mainPanel(
        nvd3PlotOutput(outputId = "plot", width = "100%", height = "500px")
      )
    )
  )

  server <- function(input, output, session){
    observeEvent(input$submit01,{
      output$plot <- renderNvd3Plot({
        isolate({
          mtcars %>%
            nvd3Plot(
              x = input$xvar,
              y = input$yvar,
              type = input$input01,
              xlab = input$lab01,
              ylab = input$lab02
            )
        })
      })
    })
  }

  shinyApp(ui = ui, server = server)
}
