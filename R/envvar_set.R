#' @rdname envvar_set
#' @title Set, unset, and check environment variables
#'
#' @description `envvar_set()` sets one or more environment variables.
#'
#' @param ... Named arguments containing an environment variable and its value
#'
#' @return TODO
#' @export
#'
#' @examples
#' envvar_set(DEBUG = 1)
envvar_set <- function(...) {
  Sys.setenv(...)
}


#' @rdname envvar_set
#' @description `envvar_unset()` unsets an environment variable.
#' @param x String with the name of environment variable
#'
#' @return TODO
#' @export
#'
#' @examples
#' envvar_unset("DEBUG")
envvar_unset <- function(x) {
  assert_scalar_string(x)
  Sys.unsetenv(x)
}
