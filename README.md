
<!-- README.md is generated from README.Rmd. Please edit that file -->

# nvd3R

![](https://img.shields.io/badge/github%20version-0.1.0-orange.svg)

> R interface to NVD3.js

## nvd3R

`{nvd3R}` is an R package for NVD3: a reusable graphics framework for
d3.js.

## Installation

The latest version can be installed from GitHub as follows:

``` r
install.packages("devtools")
devtools::install_github("alexym1/nvd3R")
```

## Example

``` r
library(nvd3R)
mtcars %>%
  nvd3Plot(x = "cyl", y = "mpg", type = "boxplot", xlab = "Test1", ylab = "Test2")
```

## Example for a {shiny} app

``` r
library(nvd3R)
path_to_app <- system.file("App/example01.R", package = "nvd3R")
runApp(path_to_app)
```

## Resource

Official website at <https://nvd3.org/>
