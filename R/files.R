#' @rdname files
#' @title Environment variables for files and directories

#' @description `envvar_get_file` gets a file name from an environment variable
#' @inheritParams envvar_get
#' @param create Create the file or directory if it does not exist (default:
#'   `TRUE`)
#' @param check_readable Ensure that the file or directory is readable
#' @param check_writable Ensure that the file or directory is writable
#' @param ... Additional arguments passed to [fs::file_create] for
#'   `envvar_get_file()` or [fs::dir_create] for `envvar_get_dir()`
#' @export
#' @examples
#'
#' # Get a file path and make sure it exists
#' \dontrun{
#' envvar_set("MYDATA" = "/tmp/data.parquet")
#' envvar_get_file("MYDATA")
#' }
envvar_get_file <- function(x,
                            create = TRUE,
                            check_readable = FALSE,
                            check_writable = FALSE,
                            transform = NULL,
                            ...) {
  assert_flag(create)
  assert_flag(check_readable)
  assert_flag(check_writable)
  rlang::check_dots_used()

  envvar_get(
    x,
    default = NA_character_,
    transform = transform,
    validate = function(x) {
      validate_file(
        x,
        create = create,
        check_readable = check_readable,
        check_writable = check_writable,
        ...
      )
    }
  )
}


#' @noRd
validate_file <- function(x,
                          create = TRUE,
                          check_readable = TRUE,
                          check_writable = FALSE,
                          ...) {
  if (!fs::file_exists(x) && isTRUE(create)) {
    cli::cli_alert_info("File {.file {x}} does not exist. Creating.")
    fs::file_create(x, ...)
  }

  modes <- c("exists")
  if (check_readable) {
    modes <- c(modes, "read")
  }
  if (check_writable) {
    modes <- c(modes, "write")
  }
  fs::file_access(x, mode = modes)
}


#' @rdname files
#' @description `envvar_get_dir` gets a directory name from an environment
#'   variable
#' @inheritParams envvar
#' @export
#' @examples
#'
#' # Get a file path and make sure it exists
#' \dontrun{
#' envvar_set("MYDATADIR" = "/tmp/data/")
#' envvar_get_dir("MYDATADIR")
#' }
envvar_get_dir <- function(x,
                           create = TRUE,
                           transform = NULL,
                           check_readable = FALSE,
                           check_writable = FALSE,
                           ...) {
  assert_flag(create)
  assert_flag(check_readable)
  assert_flag(check_writable)
  rlang::check_dots_used()

  envvar_get(
    x,
    default = NA_character_,
    transform = transform,
    validate = function(x) {
      validate_dir(
        x,
        create = create,
        check_readable = check_readable,
        check_writable = check_writable,
        ...
      )
    }
  )
}


#' @noRd
validate_dir <- function(x,
                         create = TRUE,
                         check_readable = TRUE,
                         check_writable = FALSE,
                         ...) {
  if (!fs::dir_exists(x) && isTRUE(create)) {
    cli::cli_alert_info("Directory {.file {x}} does not exist. Creating.")
    fs::dir_create(x, ...)
  }

  modes <- c("exists")
  if (check_readable) {
    modes <- c(modes, "read")
  }
  if (check_writable) {
    modes <- c(modes, "write")
  }
  fs::file_access(x, mode = modes)
}
