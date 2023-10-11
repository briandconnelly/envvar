test_that("assert_scalar_string() validates `x` arguments properly", {
  # x must be a scalar string with at least 1 character
  expect_error(assert_scalar_string(x = ""))
  expect_error(assert_scalar_string(x = NULL))
  expect_error(assert_scalar_string(x = NA_character_))
  expect_error(assert_scalar_string(x = c("hello", "world")))
})

test_that("assert_scalar_string() returns valid input, invisibly", {
  expect_equal(assert_scalar_string(x = "Hello"), "Hello")
  expect_invisible(assert_scalar_string(x = "Hello"))
})


test_that("assert_function() validates `x` arguments properly", {
  # x must be a single function
  expect_error(assert_function(x = NULL))
  expect_error(assert_function(x = NA))
  expect_error(assert_function(x = TRUE))
  expect_error(assert_function(x = "hello"))
  expect_error(assert_function(x = "as.integer"))
  expect_error(assert_function(c(as.integer, as.character)))
  expect_no_error(assert_function(x = as.integer))
  expect_no_error(assert_function(x = NULL, null_ok = TRUE))
})

test_that("assert_function() validates `null_ok` arguments properly", {
  # null_ok must be a scalar logical
  expect_error(assert_function(x = as.integer, null_ok = NULL))
  expect_error(assert_function(x = as.integer, null_ok = NA))
  expect_error(assert_function(x = as.integer, null_ok = NA_logical))
  expect_error(assert_function(x = as.integer, null_ok = 1))
  expect_error(assert_function(x = as.integer, null_ok = "yes"))
  expect_error(assert_function(x = as.integer, null_ok = c(TRUE, FALSE)))
})

test_that("assert_function() returns valid input, invisibly", {
  expect_equal(assert_function(x = is.integer), is.integer)
  expect_invisible(assert_function(x = is.integer))
})
