test_that("envvar_is_set() validates inputs properly", {
  expect_error(envvar_is_set())
  expect_error(envvar_get(NA_character_))
  expect_error(envvar_get(NULL))
  expect_error(envvar_get(""))
  expect_error(envvar_get(x))
  expect_error(envvar_get(c("HOME", "USER")))
})

test_that("envvar_is_set() works as expected", {
  withr::local_envvar(
    list(
      "TEST1" = "Hello",
      "TEST2" = "World",
      "TEST3" = NA_character_
    )
  )

  expect_true(envvar_is_set("TEST1"))
  expect_true(envvar_is_set("TEST2"))
  expect_false(envvar_is_set("TEST3"))
})
