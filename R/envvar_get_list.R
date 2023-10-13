#' @rdname list
#' @title Environment variables containing lists
#'
#' @description `envvar_get_list() ` gets lists from environment variables. At
#'   the moment, only unnamed lists are supported.
#'
#' @inheritParams envvar_get
#' @param pattern String specifying the pattern used to separate elements in the
#'   list.
#' @param ... Additional arguments passed to [strsplit]

#'
#' @return A list
#' @export
#'
#' @examples
#' # Get the value of `$PATH`, creating a list with elements for each directory
#' envvar_get_list("PATH")
envvar_get_list <- function(x,
                            pattern = ":",
                            default = NA,
                            validate = NULL,
                            use_default = TRUE,
                            ...) {
  assert_scalar_string(pattern)
  rlang::check_dots_used()

  envvar_get(
    x,
    default = default,
    transform = function(x) {
      strsplit(x, split = pattern, ...)[[1]]
    },
    validate = validate,
    use_default = use_default
  )
}
