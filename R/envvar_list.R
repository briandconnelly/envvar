#' Get a list of environment variables
#'
#' @description
#' `envvar_list()` returns a named list of the defined environment variables
#'
#' @return A named list
#' @export
#'
#' @examples
#' envvar_list()
envvar_list <- function() {
  as.list(Sys.getenv(names = TRUE))
}
