validate_file <- function(x,
                          create = TRUE,
                          is_readable = TRUE,
                          is_writable = FALSE) {
  if (!fs::file_exists(x) && isTRUE(create)) {
    cli::cli_alert_info("File {.file {x}} does not exist. Creating.")
    fs::file_create(x)
  }

  modes <- c("exists")
  if (is_readable) {
    modes <- c(modes, "read")
  }
  if (is_writable) {
    modes <- c(modes, "write")
  }
  fs::file_access(x, mode = modes)
}


validate_dir <- function(x,
                         create = TRUE,
                         is_readable = TRUE,
                         is_writable = FALSE) {
  if (!fs::dir_exists(x) && isTRUE(create)) {
    cli::cli_alert_info("Directory {.file {x}} does not exist. Creating.")
    fs::dir_create(x)
  }

  modes <- c("exists")
  if (is_readable) {
    modes <- c(modes, "read")
  }
  if (is_writable) {
    modes <- c(modes, "write")
  }
  fs::file_access(x, mode = modes)
}
