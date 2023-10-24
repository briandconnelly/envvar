#' @rdname envvar_set
#' @title Set, unset, and check environment variables
#'
#' @description `envvar_set()` sets one or more environment variables.
#'
#' @param ... Named arguments containing an environment variable and its value
#' @return No return value, called for side effects
#' @export
#'
#' @examples
#' envvar_set(DEBUG = 1)
envvar_set <- function(...) {
  args <- list(...)
  if (!rlang::is_list(args) || !rlang::is_named(args) || length(args) < 1) {
    cli::cli_abort("Arguments must be a name-value pair. For example, {.code envvar_set(\"MYVAR\" = \"value\")}.") # nolint: line_length_linter
  }

  Sys.setenv(...)
}


#' @rdname envvar_set
#' @description `envvar_unset()` unsets an environment variable.
#' @param x String with the name of environment variable
#' @export
#'
#' @examples
#' envvar_unset("DEBUG")
envvar_unset <- function(x) {
  assert_scalar_string(x)

  if (!envvar_is_set(x)) {
    cli::cli_alert_info("Environment variable {.envvar {x}} is not set.")
  }

  Sys.unsetenv(x)
}
