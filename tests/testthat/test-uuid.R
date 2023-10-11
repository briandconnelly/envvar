test_that("envvar_get_uuid() works as expected with invalid UUIDs", {
  skip_if_not_installed("uuid")

  demo_uuid <- "d647f20f-c44c-4914-8255-9eca"
  withr::local_envvar("TEST_UUID" = demo_uuid)

  # for invalid UUIDs, `uuid::as.UUID()` returns `NA` (no error, warning)
  # `envvar_get_uuid()` adds a warning, though.

  expect_warning(envvar_get_uuid("TEST_UUID"))

  result <- suppressWarnings(envvar_get_uuid("TEST_UUID"))
  expect_s3_class(result, class = "UUID")
  expect_true(is.na(result))


  # for invalid UUIDs, `uuid::as.UUID()` returns `NA` (no error, warning)
})

test_that("envvar_get_uuid() works as expected with valid UUIDs", {
  skip_if_not_installed("uuid")

  demo_uuid <- uuid::UUIDgenerate(1)
  withr::local_envvar("TEST_UUID" = demo_uuid)

  envvar_get_uuid("TEST_UUID") |>
    expect_no_error() |>
    expect_s3_class(class = "UUID")
})
