
<!-- README.md is generated from README.Rmd. Please edit that file -->

# envvar

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![CRAN
status](https://www.r-pkg.org/badges/version/envvar)](https://CRAN.R-project.org/package=envvar)
[![R-CMD-check](https://github.com/briandconnelly/envvar/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/briandconnelly/envvar/actions/workflows/R-CMD-check.yaml)
[![Codecov test
coverage](https://codecov.io/gh/briandconnelly/envvar/branch/main/graph/badge.svg)](https://app.codecov.io/gh/briandconnelly/envvar?branch=main)
<!-- badges: end -->

Environment variables are a common way to alter how your code behaves
depending on context. They’re represented by name-value pairs, and the
value is always a string. Because of this, most code that uses
environment variables must validate those values to make sure they’re
reasonable and then transform them into a more usable type.

envvar makes working with environment variables easier and more
consistent. It enables you to transform and validate values, making them
immediately usable in your code. Aside from allowing you to define your
own transformation and validation functions, envvar comes with its own
set of helper functions that handle common data types such as integers,
lists, URLs, IP addresses, and more.

For example, pretend we’re using an environment variable called
`IMPORTANT_SERVER` to store the URL of an important server. We can use
envvar’s `envvar_get_url()` function to receive its value and convert it
into an \[httr2\] `url` object:

``` r
library(envvar)

envvar_set("IMPORTANT_SERVER" = "https://192.168.1.12")
```

``` r
library(envvar)

prod_server_url <- envvar_get_url("IMPORTANT_SERVER")
prod_server_url
#> <httr2_url> https://192.168.1.12
#> • scheme: https
#> • hostname: 192.168.1.12
```

Just to be safe, we can set a default value in case someone forgot to
set the value:

``` r
envvar_unset("IMPORTANT_SERVER")

prod_server_url <- envvar_get_url("IMPORTANT_SERVER", default = "https://my_important_server.biz")
#> ℹ Environment variable `IMPORTANT_SERVER` is not set. Using default value "https://my_important_server.biz".
prod_server_url
#> <httr2_url> https://my_important_server.biz
#> • scheme: https
#> • hostname: my_important_server.biz
```

We can also add a validation check to ensure it’s using https:

``` r
envvar_set("IMPORTANT_SERVER" = "https://192.168.1.12")

prod_server_url <- envvar_get_url(
  "IMPORTANT_SERVER",
  default = "https://my_important_server.biz",
  validate = \(x) x$scheme == "https"
)
prod_server_url
#> <httr2_url> https://192.168.1.12
#> • scheme: https
#> • hostname: 192.168.1.12
```

## Installation

If you’d like to try out the development version of envvar, you can
install directly from GitHub:

``` r
# install.packages("remotes")
remotes::install_github("briandconnelly/envvar")
```
