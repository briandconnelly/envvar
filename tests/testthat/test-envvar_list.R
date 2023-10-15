test_that("envvar_list() works as expected", {
  withr::local_envvar(
    list(
      "HOME" = "/home/alice",
      "PATH" = "/dir/bin:/opt/dir/bin:/usr/local/bin",
      "NOTSET" = NA,
      "USE_FEATURE" = "FALSE",
      "NUM_ITEMS" = "22",
      "ENVVAR_UNUSED" = NA
    )
  )

  expect_no_error(envvar_list())
  expect_named(envvar_list())
  expect_true(
    all(c("HOME", "PATH", "USE_FEATURE", "NUM_ITEMS") %in% names(envvar_list()))
  )
  expect_false("NOTSET" %in% names(envvar_list()))
  expect_false("ENVVAR_UNUSED" %in% names(envvar_list()))
})
