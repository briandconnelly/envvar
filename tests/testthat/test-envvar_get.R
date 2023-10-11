test_that("envvar_get() validates `x` argument correctly", {
  # x should be a scalar string
  expect_error(envvar_get(x = ""))
  expect_error(envvar_get(x = NULL))
  expect_error(envvar_get(x = NA_character_))
  expect_error(envvar_get(x = c("HOME", "USER")))
})

test_that("envvar_get() validates `default` argument correctly", {
  # x should be a scalar
  expect_error(envvar_get("HOME", default = c(1, 2)))
})

test_that("envvar_get() validates `transform` argument correctly", {
  # transform should be a single function or NULL
  expect_error(envvar_get("HOME", transform = NA))
  expect_error(envvar_get("HOME", transform = TRUE))
  expect_error(envvar_get("HOME", transform = "hello"))
  expect_error(envvar_get("HOME", transform = "as.integer"))
  expect_error(envvar_get("HOME", transform = c(as.integer, as.character)))
  expect_snapshot(
    envvar_get("HOME", transform = TRUE),
    error = TRUE
  )
})

test_that("envvar_get() validates `validate` argument correctly", {
  # validate should be a single function or NULL
  expect_error(envvar_get("HOME", validate = NA))
  expect_error(envvar_get("HOME", validate = TRUE))
  expect_error(envvar_get("HOME", validate = "hello"))
  expect_error(envvar_get("HOME", validate = "as.integer"))
  expect_error(envvar_get("HOME", validate = c(as.integer, as.character)))
  expect_snapshot(
    envvar_get("HOME", validate = TRUE),
    error = TRUE
  )
})

test_that("envvar_get() validates `error_if_unset` argument correctly", {
  # error_if_unset should be a scalar logical
  expect_error(envvar_get("HOME", error_if_unset = NULL))
  expect_error(envvar_get("HOME", error_if_unset = NA))
  expect_error(envvar_get("HOME", error_if_unset = 1))
  expect_error(envvar_get("HOME", error_if_unset = "Yes"))
  expect_error(envvar_get("HOME", error_if_unset = "TRUE"))
  expect_error(envvar_get("HOME", error_if_unset = c(TRUE, FALSE)))
})

test_that("envvar_get() errors if variable unset (and error_if_unset = TRUE)", {
  withr::local_envvar(c("TESTENV_ENVVAR" = NA))
  expect_error(envvar_get("TESTENV_ENVVAR", error_if_unset = TRUE))
  expect_snapshot(
    envvar_get("TESTENV_ENVVAR", error_if_unset = TRUE),
    error = TRUE
  )
})

test_that("envvar_get() shows message if variable unset (and error_if_unset = FALSE)", { # nolint: line_length_linter
  withr::local_envvar(c("TESTENV_ENVVAR" = NA))
  expect_message(envvar_get("TESTENV_ENVVAR", error_if_unset = FALSE))
  envvar_get("TESTENV_ENVVAR", default = "HELLO", error_if_unset = FALSE) |>
    expect_equal("HELLO") |>
    expect_snapshot()
})

test_that("envvar_get() `transform` function works as expected", {
  withr::local_envvar(c("TESTENV_ENVVAR" = "heLLo"))
  expect_equal(envvar_get("TESTENV_ENVVAR", transform = toupper), "HELLO")
})

test_that("envvar_get() `validate` function works as expected", {
  withr::local_envvar(c("TESTENV_ENVVAR" = "HELLO"))
  envvar_get("TESTENV_ENVVAR", validate = \(x) nchar(x) == 5L) |>
    expect_equal("HELLO") |>
    expect_no_error()

  expect_snapshot(
    envvar_get("TESTENV_ENVVAR", validate = \(x) nchar(x) == 50L),
    error = TRUE
  )
})

test_that("envvar_get_oneof() validates `choices` argument correctly", {
  # Choices should be a list of 1+ options
  withr::local_envvar(c("TESTENV_ENVVAR" = "HELLO"))
  expect_error(envvar_get_oneof("TESTENV_ENVVAR"))
  expect_error(envvar_get_oneof("TESTENV_ENVVAR", choices = NULL))
  expect_error(envvar_get_oneof("TESTENV_ENVVAR", choices = NA_character_))
})

test_that("envvar_get_oneof() works as expected", {
  withr::local_envvar(c("TESTENV_ENVVAR" = "HELLO"))

  # Current value isn't one of the choices
  expect_error(envvar_get_oneof("TESTENV_ENVVAR", choices = c("APPLE", "DUCK")))
  expect_snapshot(
    envvar_get_oneof("TESTENV_ENVVAR", choices = c("APPLE", "DUCK")),
    error = TRUE
  )

  # Current value is one of the choices
  expect_equal(
    envvar_get_oneof("TESTENV_ENVVAR", choices = c("WORLD", "HELLO")),
    "HELLO"
  )
})
