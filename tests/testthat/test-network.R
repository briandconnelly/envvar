# Note: httr2 is quite permissive of incomplete URLs, so testing with invalid
#       URLs is difficult.

test_that("envvar_get_url() works as expected with valid URLs", {
  skip_if_not_installed("httr2")

  test_url <- "http://username@google.com:80/path;test?a=1&b=2#40"
  withr::local_envvar(list("TEST_URL" = test_url))

  result <- expect_no_error(envvar_get_url("TEST_URL"))
  expect_s3_class(result, class = "httr2_url")
  expect_equal(result$hostname, "google.com")
})


test_that("envvar_get_ipaddress() works as expected with invalid IPv4", {
  skip_if_not_installed("ipaddress")

  test_ipv4 <- "256.256.1.4"
  withr::local_envvar(list("TEST_IPV4" = test_ipv4))

  expect_warning(envvar_get_ipaddress("TEST_IPV4"))

  # {ipaddress} still returns an ip_address object with value NA
  result <- suppressWarnings(envvar_get_ipaddress("TEST_IPV4"))
  expect_true(ipaddress::is_ip_address(result))
  expect_true(is.na(result))
})


test_that("envvar_get_ipaddress() works as expected with invalid IPv6", {
  skip_if_not_installed("ipaddress")

  test_ipv6 <- "not even close to valid"
  withr::local_envvar(list("TEST_IPV6" = test_ipv6))

  expect_warning(envvar_get_ipaddress("TEST_IPV6"))

  # {ipaddress} still returns an ip_address object with value NA
  result <- suppressWarnings(envvar_get_ipaddress("TEST_IPV6"))
  expect_true(ipaddress::is_ip_address(result))
  expect_true(is.na(result))
})


test_that("envvar_get_ipaddress() works as expected with valid IPv4", {
  skip_if_not_installed("ipaddress")

  test_ipv4 <- "192.168.1.14"
  withr::local_envvar(list("TEST_IPV4" = test_ipv4))

  result <- envvar_get_ipaddress("TEST_IPV4") |>
    expect_no_error()
  expect_true(ipaddress::is_ip_address(result))
  expect_true(ipaddress::is_ipv4(result))
})


test_that("envvar_get_ipaddress() works as expected with valid IPv6", {
  skip_if_not_installed("ipaddress")

  test_ipv6 <- "2001:0db8:0000:0000:0000:8a2e:0370:7334"
  withr::local_envvar(list("TEST_IPV6" = test_ipv6))

  result <- envvar_get_ipaddress("TEST_IPV6") |>
    expect_no_error()
  expect_true(ipaddress::is_ip_address(result))
  expect_true(ipaddress::is_ipv6(result))
})
