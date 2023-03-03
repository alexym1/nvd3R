#' List of available charts
#'
#' @export
available_nvd3_charts <- function () {
  list1 <- c("barplot", "boxplot", "piechart", "donutchart")
  list2 <- c("multibarplotH", "multibarplot", "scatterplot")
  df.list <- list(list1, list2)
  names(df.list) <- c("Charts with empty col argument", "Charts using col argument")
  return(df.list)
}

