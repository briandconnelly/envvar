#' @rdname files
#' @title Environment variables for files and directories

#' @description `envvar_get_file` gets a file name from an environment variable
#' @param create Create the file or directory if it does not exist (default:
#'   `TRUE`)
#' @param check_readable Ensure that the file or directory is readable
#' @param check_writable Ensure that the file or directory is writable
#' @inheritParams envvar_get
#' @export
#' @examples
#'
#' # Get a file path and make sure it exists
#' \dontrun{
#' envvar_set("MYDATA" = "/tmp/data.parquet")
#' envvar_get_file("MYDATA")}
envvar_get_file <- function(x,
                            check_readable = FALSE,
                            check_writable = FALSE,
                            transform = NULL,
                            create = TRUE,
                            error_if_unset = FALSE) {
  envvar_get(
    x,
    default = NA_character_,
    transform = transform,
    validate = function(x) {
      validate_file(
        x,
        create = create,
        is_readable = check_readable,
        is_writable = check_writable
      )
    },
    error_if_unset = error_if_unset
  )
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
#' envvar_get_dir("MYDATADIR")}
envvar_get_dir <- function(x,
                           transform = NULL,
                           create = TRUE,
                           check_readable = FALSE,
                           check_writable = FALSE,
                           error_if_unset = FALSE) {
  envvar_get(
    x,
    default = NA_character_,
    transform = transform,
    validate = function(x) {
      validate_dir(
        x,
        create = create,
        is_readable = check_readable,
        is_writable = check_writable
      )
    },
    error_if_unset = error_if_unset
  )
}
