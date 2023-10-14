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
                               default = NULL,
                               validate = NULL) {
  if (!rlang::is_null(default) && !rlang::is_scalar_integerish(default)) {
    cli::cli_abort("{.arg default} value {.val {default}} should be integer-like.") # nolint: line_length_linter
  }

  envvar_get(
    x,
    default = default,
    transform = as.integer,
    validate = validate
  )
}


#' @rdname types
#' @description `envvar_get_numeric()` reads environment variables with numeric
#'   values (e.g., `100.12`, `-31`)
#' @export
#' @examples
#'
#' # Get and use a numeric value
#' envvar_set("MYNUMBER" = 12.34)
#' envvar_get_numeric("MYNUMBER") + 5
envvar_get_numeric <- function(x,
                               default = NULL,
                               validate = NULL) {
  if (!rlang::is_null(default) && !rlang::is_scalar_double(default)) {
    cli::cli_abort("{.arg default} value {.val {default}} should be numeric.") # nolint: line_length_linter
  }

  envvar_get(
    x,
    default = default,
    transform = as.numeric,
    validate = validate
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
                               default = NULL,
                               validate = NULL) {
  if (!rlang::is_null(default) && !rlang::is_scalar_logical(default)) {
    cli::cli_abort("{.arg default} value {.val {default}} should be a logical value.") # nolint: line_length_linter
  }

  envvar_get(
    x,
    default = default,
    transform = as.logical,
    validate = validate
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
                               default = NULL,
                               validate = NULL) {
  if (!rlang::is_null(default) && !is.numeric_version(default) && rlang::is_na(numeric_version(default, strict = FALSE))) { # nolint: line_length_linter
    cli::cli_abort("{.arg default} value {.val {default}} should be a numeric version.") # nolint: line_length_linter
  }

  envvar_get(
    x,
    default = default,
    transform = as.numeric_version,
    validate = validate
  )
}


#' @rdname types
#' @description `envvar_get_date()` reads environment variables with date values
#'   (e.g., `"2023-01-02"`)
#' @param ... Additional arguments passed to [lubridate::as_date] for
#'   `envvar_get_date()` or [lubridate::as_datetime] for `envvar_get_datetime()`
#' @export
envvar_get_date <- function(x,
                            default = NULL,
                            validate = NULL,
                            ...) {
  rlang::check_dots_used()
  envvar_get(
    x,
    default = default,
    transform = function(x) {
      lubridate::as_date(x, ...)
    },
    validate = validate
  )
}


#' @rdname types
#' @description `envvar_get_date()` reads environment variables with date-time
#'   values (e.g., `"2023-01-02 01:23:45 UTC"` or 1697037804)
#' @param ... Additional arguments passed to [lubridate::as_date] for
#'   `envvar_get_date()` or [lubridate::as_datetime] for `envvar_get_datetime()`
#' @export
envvar_get_datetime <- function(x,
                                default = NULL,
                                validate = NULL,
                                ...) {
  rlang::check_dots_used()
  envvar_get(
    x,
    default = default,
    transform = function(x) {
      lubridate::as_datetime(x, ...)
    },
    validate = validate
  )
}
