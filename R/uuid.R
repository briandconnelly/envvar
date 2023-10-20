#' @rdname uuid
#' @title Environment variables for UUIDs

#' @description `envvar_get_uuid` gets a UUID from an environment variable
#' @inheritParams envvar_get
#' @export
#' @examples
#'
#' # Get a file path and make sure it exists
#' envvar_set("DEMO_GUID" = "d647f20f-c44c-4914-8255-9eca97150d4c")
#' envvar_get_uuid("DEMO_GUID")
envvar_get_uuid <- function(x,
                            default = NULL,
                            validate = NULL) {
  rlang::check_installed("uuid")

  envvar_get(
    x,
    default = default,
    transform = function(x) {
      uuid <- uuid::as.UUID(x)
      if (rlang::is_na(uuid)) {
        cli::cli_abort("{.val {x}} is not a valid UUID")
      }
      uuid
    },
    validate = validate
  )
}
