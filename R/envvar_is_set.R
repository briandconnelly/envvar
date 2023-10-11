#' @rdname envvar_is_set
#' @title Check whether an environment variable is set
#'
#' @description `envvar_is_set()` checks whether a given environment variable is
#' set.
#' @param x String with the name of environment variable
#'
#' @return A logical value
#' @export
#'
#' @examples
#' envvar_is_set("HOME")
envvar_is_set <- function(x) {
  assert_scalar_string(x)
  !is.na(Sys.getenv(x, unset = NA_character_))
}
