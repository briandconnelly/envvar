#' @rdname types
#' @title Get the value of an environment variable as a particular type
#' @description `envvar_get_integer()` reads environment variables with integer
#'   values (e.g., `15`, `0`, `-1`)
#' @inheritParams envvar_get
#' @export
#' @examples
#'
#' # Get and use an integer value
#' envvar_set("MYNUMBER" = 12)
#' envvar_get_integer("MYNUMBER") + 5
envvar_get_integer <- function(x,
                               default = NA_integer_,
                               validate = NULL,
                               error_if_unset = FALSE) {
  envvar_get(
    x,
    default = default,
    transform = as.integer,
    validate = validate,
    error_if_unset = error_if_unset
  )
}


#' @rdname types
#' @description `envvar_get_numeric()` reads environment variables with numeric
#'   values (e.g., `100.12`, `-31`)
#' @export
#' @examples
#'
#' # Get and use a numeric value
#' # envvar_set("MYNUMBER" = 12.34)
#' # envvar_get_numeric("MYNUMBER") + 5
envvar_get_numeric <- function(x,
                               default = NA_real_,
                               validate = NULL,
                               error_if_unset = error_if_unset) {
  envvar_get(
    x,
    default = default,
    transform = as.numeric,
    validate = validate,
    error_if_unset = error_if_unset
  )
}


#' @rdname types
#' @description `envvar_get_logical()` reads environment variables with logical
#'   values (e.g., `TRUE`, `1`, `"T"`)
#' @export
#' @examples
#'
#' # Check a logical value
#' isTRUE(envvar_get_logical("RSTUDIO_CLI_HYPERLINKS"))
envvar_get_logical <- function(x,
                               default = NA,
                               validate = NULL,
                               error_if_unset = FALSE) {
  envvar_get(
    x,
    default = default,
    transform = as.logical,
    validate = validate,
    error_if_unset = error_if_unset
  )
}

#' @rdname types
#' @description `envvar_get_version` reads environment variables with semantic
#'   version numbers (e.g., `4.3.1`)
#' @export
#' @examples
#'
#' # Get an IP address value and ensure that it is IPv4
#' envvar_set("MY_VER" = "4.3.1")
#' envvar_get_version("MY_VER", validate = \(x) x > as.numeric_version("4.3"))
envvar_get_version <- function(x,
                               default = NA,
                               validate = NULL,
                               error_if_unset = FALSE) {
  envvar_get(
    x,
    default = default,
    transform = as.numeric_version,
    validate = validate,
    error_if_unset = FALSE
  )
}


#' @rdname types
#' @description `envvar_get_date()` reads environment variables with date values
#'   (e.g., `"2023-01-02"`)
#' @param ... Additional arguments passed to [as.Date] for `envvar_date()`
#' @export
envvar_get_date <- function(x,
                            default = NA_character_,
                            validate = NULL,
                            error_if_unset = FALSE,
                            ...) {
  rlang::check_dots_used()
  envvar_get(
    x,
    default = default,
    transform = function(x) {
      as.Date(x, ...)
    },
    validate = validate,
    error_if_unset = FALSE
  )
}
