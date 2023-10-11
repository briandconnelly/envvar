#' @noRd
#' @title Assertion functions
#' @description `assert_scalar_string()` checks to make sure a value is a scalar
#'   string
#'
#' @param x An object to check
#' @param arg The caller argument
#' @param call The environment of the calling function
#'
#' @return `x`, invisibly, if valid
assert_scalar_string <- function(x,
                                 arg = rlang::caller_arg(x),
                                 call = rlang::caller_env()) {
  if (!rlang::is_scalar_character(x) || nchar(x) < 1) {
    cli::cli_abort(
      message = "{.arg {arg}} must be a non-empty string scalar",
      call = call
    )
  }
  invisible(x)
}


#' @noRd
#' @description `assert_function()` checks to make sure a value is function
#'
#' @param null_ok Whether or not a `NULL` value is allowed (default: `FALSE`)
#'
#' @return `x`, invisibly, if valid
assert_function <- function(x,
                            null_ok = FALSE,
                            arg = rlang::caller_arg(x),
                            call = rlang::caller_env()) {
  if (!rlang::is_logical(null_ok, n = 1) || is.na(null_ok)) {
    cli::cli_abort("{.arg null_ok} must be a single logical value")
  }

  if ((!is.null(x) && !rlang::is_function(x)) || (is.null(x) && isFALSE(null_ok))) { # nolint: line_length_linter
    cli::cli_abort("{.arg {arg}} must be a function", call = call)
  }
  invisible(x)
}


#' @noRd
#' @description `assert_flag()` checks to make sure a value is a flag (i.e., a
#'   scalar logical)
#'
#' @param null_ok Whether or not a `NULL` value is allowed (default: `FALSE`)
#'
#' @return `x`, invisibly, if valid
assert_flag <- function(x,
                        na_ok = FALSE,
                        null_ok = FALSE,
                        arg = rlang::caller_arg(x),
                        call = rlang::caller_env()) {
  if ((rlang::is_na(x) && isFALSE(na_ok)) || (rlang::is_null(x) && isFALSE(null_ok)) || !rlang::is_scalar_logical(x)) { # nolint: line_length_linter
    cli::cli_abort("{.arg {arg}} must be single logical value", call = call)
  }
}
