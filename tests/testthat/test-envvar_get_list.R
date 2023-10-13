withr::local_envvar(
  list(
    "TEST_LIST1" = "apple:boat:cat:dog:elephant",
    "TEST_LIST_CSV" = "goat,geoduck,giraffe,gerbil",
    "TEST_LIST_PSV" = "nandor|laszlo|nadja|guillermo|colin"
  )
)


test_that("envvar_get_list() validates arguments properly", {
  # `pattern` is a scalar string
  expect_error(envvar_get_list("TEST_LIST1", pattern = NULL))
  expect_error(envvar_get_list("TEST_LIST1", pattern = NA_character_))
  expect_error(envvar_get_list("TEST_LIST1", pattern = c(":", ",")))

  # Error raised if ... contains unused arguments
  expect_error(envvar_get_list("TEST_LIST1", patern = ":"))
  expect_error(envvar_get_list("TEST_LIST1", notanarg = TRUE))
})

test_that("envvar_get_list() works as expected", {
  expect_no_error(envvar_get_list("TEST_LIST1"))
  result <- envvar_get_list("TEST_LIST1")

  expect_equal(length(result), 5)

  expect_no_error(envvar_get_list("TEST_LIST_CSV", pattern = ","))
  envvar_get_csv("TEST_LIST_CSV") |>
    expect_length(n = 4) |>
    expect_setequal(expected = c("goat", "geoduck", "giraffe", "gerbil"))

  envvar_get_psv("TEST_LIST_PSV") |>
    expect_length(n = 5) |>
    expect_setequal(
      expected = c("nandor", "laszlo", "nadja", "guillermo", "colin")
    )
})
