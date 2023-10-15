
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

Environment variables are a powerful tool that enable your code to react
to its environment. However, two common design choices are a frequent
source of friction. First, unlike most other “getter”-type functions,
functions that retrieve values from environment variable typically fail
silently. Because of this, additional code to check whether the
environment variable was set are needed. Second, values are almost
always returned as strings. This is understandable, but programmers
often use environment variables to store a wide variety of data types
from numbers to timestamps to URLs. In this case, additional code is
required to coerce those strings into their intended format. For
frequent users of environment variables, writing all this extra code is
unpleasant and time consuming.

envvar takes a slightly opinionated perspective to make working with
environment variables easier and more consistent. Unless a default value
is explicitly given, `envvar_get()` raises an error. For example, let’s
say our code depends on environment variable called `NUM_CPUS`. In base
R, we have to first get the value using `Sys.getenv()` and then see
whether the result is the empty string (not `NA` like you might expect):

``` r
num_cpus <- Sys.getenv("NUM_CPUS")

if (identical(num_cpus, "")) {
  stop("I need `NUM_CPUS` to be set!")
}
#> Error in eval(expr, envir, enclos): I need `NUM_CPUS` to be set!
```

envvar’s `envvar_get()` will just fail if `NUM_CPUS` isn’t set:

``` r
library(envvar)

envvar_get("NUM_CPUS")
#> Error in `envvar_get()`:
#> ! Environment variable `NUM_CPUS` is not set.
```

If a reasonable default is known, it can be supplied via the `default`
argument. envvar prints a message, though, so you know that it’s using a
default rather than a value specified in the environment.

``` r
envvar_get("NUM_CPUS", default = 12)
#> ℹ Environment variable `NUM_CPUS` is not set. Using default value 12.
#> [1] 12
```

## Speaking Native Types

Let’s say our `NUM_CPUS` environment variable is set. For this example,
it’s set to 8. Because `Sys.getenv()` returns strings, we can’t
immediately treat it like the integer that it is.

``` r
Sys.getenv("NUM_CPUS") / 2
#> Error in Sys.getenv("NUM_CPUS")/2: non-numeric argument to binary operator

num_cpus / 2
#> Error in num_cpus/2: non-numeric argument to binary operator
```

envvar includes several helper functions that return commonly-used data
types as their proper type. Here, we’ll use `envvar_get_integer()` to
get `NUM_CPUS` and return it as an integer.

``` r
envvar::envvar_get_integer("NUM_CPUS") / 2
#> [1] 4
```

envvar can handle numbers, logical values, version numbers, URLs,
timestamps, UUIDs, IP addresses, and more. We’ll work with dates in the
next example.

## Validation

envvar’s `envvar_get` functions can also apply validation logic. For
this example, let’s set an environment variable called `LAUNCH_DATE`
that absolutely, positively must be in the future. For now, let’s set it
to a date in the past.

``` r
envvar_set("LAUNCH_DATE" = "1969-07-16")
```

To read `LAUNCH_DATE` and ensure that it is in the future, we can supply
a function to `envvar_get_date()` that checks the value. If this
function returns `FALSE`, an error is raised.

``` r
envvar_get_date("LAUNCH_DATE", validate = \(x) x > Sys.Date())
#> Error in `envvar_get()`:
#> ! "1969-07-16" is not a valid value for `LAUNCH_DATE`
```

Let’s try that again:

``` r
envvar_set("LAUNCH_DATE" = "2028-08-28")

envvar_get_date("LAUNCH_DATE", validate = \(x) x > Sys.Date())
#> [1] "2028-08-28"
```

## Installation

envvar is still changing quickly, so it’s not quite ready for CRAN. If
you’d like to try out the development version, you can install directly
from GitHub:

``` r
# install.packages("remotes")
remotes::install_github("briandconnelly/envvar")
```

## Related Packages

- [dotenv](https://github.com/gaborcsardi/dotenv) package for loading
  environment variables from `.env` files
- [config](https://rstudio.github.io/config/) package for defining and
  using multiple environments
- [options](https://dgkf.github.io/options/) package for defining and
  using R package options, another way of adding flexibility to your
  code
