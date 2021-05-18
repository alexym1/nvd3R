![](https://img.shields.io/badge/github%20version-0.0.0.9000-orange.svg)

The package is fully inspired by 'ramnathv/rCharts'.

## Installation

The latest version can be installed from GitHub as follows: 

```{r eval = FALSE}
install.packages("devtools")
devtools::install_github("alexym1/nvd3R")
```

## Example

```{r}
library(nvd3R)

mtcars %>%
nvd3Plot(
x = "cyl",
y = "mpg",
type = "boxplot",
xlab = "Test1",
ylab = "Test2"
)
```

## Ressources

Official website at https://nvd3.org/

