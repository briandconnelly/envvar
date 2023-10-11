#' @rdname envvar_get
#' @title Get the value of an environment variable
#'
#' @description
#' `envvar_get()` returns the value of an environment variable.
#'
#' @details
#' `envvar_get()` and the other type-specific variants follow this workflow:
#' - The value of the environment variable is retrieved. If that variable is
#' not set, the value specified by `default` is used (or an error is raised if
#' `use_default` is `FALSE`).
#' - Optionally, the value can be transformed by a function specified by the
#' `transform` argument. Transformation functions return a scalar object.
#' - Optionally, the value can be validated by a function specified by the
#' `validate` argument. Validation functions return a logical value indicating
#' whether or not the value matches the given criteria. An error is raised if
#' the validation function does not return `TRUE`.
#' - The transformed, validated value is returned.
#'
#' @param x String containing an environment variable name
#' @param default Optional default value if the environment variable is not set
#' @param transform Optional function that applies a transformation to the
#'   variable's value
#' @param validate Optional function that checks a value for validity
#' @param use_default Logical value indicating whether the value specified by
#'   `default` should be used (`TRUE`, the default) or an error should be raised
#'   (`FALSE`)
#'
#' @return The value of the given environment variable, if set. This is a string
#'   unless a `transform` function has changed the object's type.
#' @export
#'
#' @examples
#' # Get the current user's home directory
#' envvar_get("HOME")
#'
envvar_get <- function(x,
                       default = NA_character_,
                       transform = NULL,
                       validate = NULL,
                       use_default = TRUE) {
  assert_scalar_string(x)
  assert_function(transform, null_ok = TRUE)
  assert_function(validate, null_ok = TRUE)
  assert_flag(use_default)

  if (!envvar_is_set(x)) {
    if (!use_default) {
      cli::cli_abort("Environment variable {.envvar {x}} is not set.")
    } else {
      cli::cli_alert_info("Environment variable {.envvar {x}} is not set. Using default value {.val {default}}.") # nolint: line_length_linter
    }
  }

  value_raw <- Sys.getenv(x, unset = default, names = FALSE)

  if (!rlang::is_null(transform)) {
    value <- transform(value_raw)
  } else {
    value <- value_raw
  }

  if (!rlang::is_null(validate)) {
    # use a try-catch instead??
    if (!validate(value)) {
      cli::cli_abort("{.val {value_raw}} is not a valid value for {.envvar {x}}") # nolint: line_length_linter
    }
  }

  value
}


#' @rdname envvar_get
#' @description `envvar_get_oneof()` gets the value of an environment variable
#'   and ensures that it is within a defined set of potential values.
#' @param choices A list containing the potential values
#' @export
#' @examples
#' # Get the current user, making sure it is either 'root' or 'alice'
#' \dontrun{
#' envvar_get_oneof("USER", choices = c("root", "alice"))
#' }
envvar_get_oneof <- function(x,
                             choices,
                             default = NA_character_,
                             transform = NULL,
                             validate = NULL,
                             use_default = TRUE) {
  if (length(choices) < 1) {
    cli::cli_abort("{.arg choices} must include at least one valid choice")
  }

  envvar_get(
    x,
    default = NA_character_,
    transform = transform,
    validate = function(x) {
      x %in% choices
    },
    use_default = use_default
  )
}
