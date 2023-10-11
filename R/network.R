#' @rdname network
#' @title Environment variables for internet and network-related values
#' @description `envvar_get_url` gets a URL value from an environment
#'   variable and parses it with [httr2::url_parse].
#' @inheritParams envvar_get
#' @export
#' @examples
#'
#' # Get a URL value and ensure that it is https
#' envvar_set("TEST_URL" = "https://google.com:80/?a=1&b=2")
#' envvar_get_url("TEST_URL", validate = \(x) x$scheme == "https")
envvar_get_url <- function(x,
                           default = NA,
                           validate = NULL,
                           error_if_unset = FALSE) {
  rlang::check_installed("httr2")

  envvar_get(
    x,
    default = default,
    transform = httr2::url_parse,
    validate = validate,
    error_if_unset = error_if_unset
  )
}

#' @rdname network
#' @description `envvar_get_ipaddress` gets an IP address value from an
#'   environment variable
#' @export
#' @examples
#'
#' # Get an IP address value and ensure that it is IPv4
#' envvar_set("TEST_HOST" = "192.168.1.15")
#' envvar_get_ipaddress("TEST_HOST", validate = ipaddress::is_ipv4)
envvar_get_ipaddress <- function(x,
                                 default = NA,
                                 validate = NULL,
                                 error_if_unset = FALSE) {
  rlang::check_installed("ipaddress")

  envvar_get(
    x,
    default = default,
    transform = function(x) {
      ip <- suppressWarnings(ipaddress::as_ip_address(x))
      if (is.na(ip)) {
        cli::cli_warn("{.val {x}} is not a valid IP address")
      }
      ip
    },
    validate = validate,
    error_if_unset = error_if_unset
  )
}
