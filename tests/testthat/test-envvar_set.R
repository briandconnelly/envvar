test_that("`envvar_set()` and `envvar_unset()` work as expected", {
  expect_error(envvar_set())
  expect_snapshot(envvar_set(), error = TRUE)
  expect_snapshot(envvar_set("TEST1" = "val1", "TEST2"), error = TRUE)

  expect_error(envvar_unset())
  expect_error(envvar_unset(""))
  expect_error(envvar_unset(c("TEST1", "TEST2")))

  withr::local_envvar(list("TEST_NOTSET" = NA))

  expect_snapshot(envvar_unset("TEST_NOTSET"))

  envvar_set("TESTVAR1" = "hello")
  expect_true(envvar_is_set("TESTVAR1"))
  expect_equal(envvar_get("TESTVAR1"), "hello")
  envvar_unset("TESTVAR1")
  expect_false(envvar_is_set("TESTVAR1"))
})
