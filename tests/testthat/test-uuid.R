test_that("envvar_get_uuid() works as expected with invalid UUIDs", {
  skip_if_not_installed("uuid")

  demo_uuid <- "d647f20f-c44c-4914-8255-9eca"
  withr::local_envvar("TEST_UUID" = demo_uuid)

  expect_error(envvar_get_uuid("TEST_UUID"))
  expect_snapshot(envvar_get_uuid("TEST_UUID"), error = TRUE)
})

test_that("envvar_get_uuid() works as expected with valid UUIDs", {
  skip_if_not_installed("uuid")

  demo_uuid <- uuid::UUIDgenerate(1)
  withr::local_envvar("TEST_UUID" = demo_uuid)

  envvar_get_uuid("TEST_UUID") |>
    expect_no_error() |>
    expect_s3_class(class = "UUID")
})
