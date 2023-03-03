#' Create NVD3 charts
#'
#' Main function to make new NVD3 chart
#'
#' @param data data.frame
#' @param x,y variables in quote e.i "var1"
#' @param col color using variable
#' @param type Chart type (see details)
#' @param xlab,ylab Axis label
#'
#' @import htmlwidgets
#' @import jsonlite
#' @import datasets
#' @importFrom grDevices boxplot.stats
#'
#' @examples
#' library(nvd3R)
#'
#' ### Boxplot
#' mtcars %>%
#'  nvd3Plot(x = "cyl", y = "mpg", type = "boxplot", xlab = "Test1", ylab = "Test2")
#'
#'
#' ### Multibarplot
#' newdata02 <- data.frame(
#' var1 = c("A", "B", "C", "D", "A", "B", "C", "D"),
#' var2 = c(10,15,20,25,30,35,40,98),
#' label = c("A", "A", "A", "A", "B", "B", "B", "B")
#' )
#'
#'newdata02 %>%
#' nvd3Plot(x = "var1", y = "var2", col = "label", type = "multibarplot")
#'
#'
#' @export
nvd3Plot <- function(data, x, y, col = NULL, type = "boxplot", xlab = "X-axis", ylab = "Y-axis") {

  if(type != "piechart" | type != "donutchart"){
    donut <- NULL
  }


  if(type == "barplot"){
    dataset <- list(
      values = data.frame(
        label = as.character(data[,x]),
        value = data[,y]
      )
    )
  }
  else if(type == "piechart") {
    donut <- FALSE
    dataset <- data.frame(
        key = as.character(data[,x]),
        y = data[,y]
      )
  }
  else if(type == "donutchart"){
    donut <- TRUE
    dataset <- data.frame(
      key = as.character(data[,x]),
      y = data[,y]
    )
  }
  else if(type == "boxplot"){
    n <- levels(factor(data[,x]))
    df.list <- lapply(1:length(n), function(i){
      values <- data[data[,x] == n[i], y]
      summary(values)
    })
    newdata <- do.call(rbind, df.list)

    # Whiskers
    higherW <- lapply(X = 1:nrow(newdata), function(i){
      IQR <- newdata[i, "3rd Qu."] - newdata[i, "1st Qu."]
      min(max(data[data[,x] == n[i], y]), newdata[i, "3rd Qu."] + 1.5 * IQR)
    })

    lowerW <- lapply(X = 1:nrow(newdata), function(i){
      IQR <- newdata[i, "3rd Qu."] - newdata[i, "1st Qu."]
      max(min(data[data[,x] == n[i], y]), newdata[i, "3rd Qu."] - 1.5 * IQR)
    })

    # ++ outliers
    outliers <- lapply(1:length(n), function(i){
      tmp <- boxplot.stats(data[data[,x] == n[i], y])
      unique(tmp$out)
    })

    df <- data.frame(
      label = n,
      Q1 = newdata[,2],
      Q2 = newdata[,3],
      Q3 = newdata[,5],
      whisker_low = do.call(c, lowerW),
      whisker_high = do.call(c, higherW)
    )

    dataset <- lapply(1:length(n), function(x){
      out <- outliers[[x]]
      if(length(out) >= 1){
        list(
          label = df$label[x],
          values = list(
            Q1 = df$Q1[x],
            Q2 = df$Q2[x],
            Q3 = df$Q3[x],
            whisker_low = df$whisker_low[x],
            whisker_high = df$whisker_high[x],
            outliers = out
          )
        )
      }
      else {
        list(
          label = df$label[x],
          values = list(
            Q1 = df$Q1[x],
            Q2 = df$Q2[x],
            Q3 = df$Q3[x],
            whisker_low = df$whisker_low[x],
            whisker_high = df$whisker_high[x]
          )
        )
      }
    })

  }
  else if(type == "multibarplotH"){
    n <- levels(factor(data[,col]))
    dataset <- lapply(1:length(n), function(i){
      list(
        key = n[i],
        values = data.frame(
          label = data[data[,col] == n[i],x],
          value = data[data[,col] == n[i],y]
        )
      )
    })
  }
  else if(type == "multibarplot"){
    n <- levels(factor(data[,col]))
    dataset <- lapply(1:length(n), function(i){
      list(
        key = n[i],
        values = data.frame(
          x = data[data[,col] == n[i],x],
          y = data[data[,col] == n[i],y]
        )
      )
    })
  }
  else if(type == "scatterplot"){
    n <- levels(factor(data[,col]))
    dataset <- lapply(1:length(n), function(i){
      list(
        key = n[i],
        values = data.frame(
          x = data[data[,col] == n[i],x],
          y = data[data[,col] == n[i],y],
          shape = 'circle'
        )
      )
    })
  }

  # forward options using x
  x = list(
    data = toJSON(x = dataset, pretty = TRUE, auto_unbox = FALSE),
    type = type,
    xlab = xlab,
    ylab = ylab,
    donut = donut
  )

  # create widget
  htmlwidgets::createWidget(
    name = 'nvd3Plot',
    x,
    package = 'nvd3R'
  )
}

#' Shiny bindings for nvd3Plot
#'
#' Output and render functions for using nvd3Plot within Shiny
#' applications and interactive Rmd documents.
#'
#' @param outputId output variable to read from
#' @param width,height Must be a valid CSS unit (like \code{'100\%'},
#'   \code{'400px'}, \code{'auto'}) or a number, which will be coerced to a
#'   string and have \code{'px'} appended.
#' @param expr An expression that generates a nvd3Plot
#' @param env The environment in which to evaluate \code{expr}.
#' @param quoted Is \code{expr} a quoted expression (with \code{quote()})? This
#'   is useful if you want to save an expression in a variable.
#'
#' @name nvd3Plot-shiny
#'
#' @export
nvd3PlotOutput <- function(outputId, width = '100%', height = '400px'){
  htmlwidgets::shinyWidgetOutput(outputId, 'nvd3Plot', width, height, package = 'nvd3R')
}

#' @rdname nvd3Plot-shiny
#' @export
renderNvd3Plot <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  htmlwidgets::shinyRenderWidget(expr, nvd3PlotOutput, env, quoted = TRUE)
}
