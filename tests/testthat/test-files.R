# Some of these tests aren't working on Windows
skip_on_os("windows")

tempfile_exists <- withr::local_tempfile()
fs::file_create(tempfile_exists, mode = "644")

tempfile_noexist <- withr::local_tempfile()

tempdir_exists <- fs::path_dir(tempfile_exists)

withr::local_envvar(
  list(
    "ENVVAR_TEMP_FILE_EXISTS" = tempfile_exists,
    "ENVVAR_TEMP_FILE_NOEXIST" = tempfile_noexist,
    "ENVVAR_TEMP_DIR_EXISTS" = tempdir_exists
  )
)

test_that("envvar_get_file() validates `x` arguments correctly", {
  # `x` should be specified and a scalar string
  expect_error(envvar_get_file())
  expect_error(envvar_get_file(x = ""))
  expect_error(envvar_get_file(x = NA_character_))
  expect_error(envvar_get_file(x = NULL))
  expect_error(envvar_get_file(x = 21))
  expect_error(
    envvar_get_file(x = c("ENVVAR_TEMP_FILE_EXISTS", "ENVVAR_TEMP_FILE_EXISTS"))
  )
})

test_that("envvar_get_file() validates `create` arguments correctly", {
  # `create` should be a logical scalar
  expect_error(envvar_get_file("ENVVAR_TEMP_FILE_EXISTS", create = NULL))
  expect_error(envvar_get_file("ENVVAR_TEMP_FILE_EXISTS", create = NA))
  expect_error(envvar_get_file("ENVVAR_TEMP_FILE_EXISTS", create = "yes"))
  expect_error(envvar_get_file("ENVVAR_TEMP_FILE_EXISTS", create = 1))
  expect_error(
    envvar_get_file("ENVVAR_TEMP_FILE_EXISTS", create = c(TRUE, FALSE))
  )
})

test_that("envvar_get_file() validates `check_readable` arguments correctly", {
  # `check_readable` should be a logical scalar
  expect_error(
    envvar_get_file("ENVVAR_TEMP_FILE_EXISTS", check_readable = NULL)
  )
  expect_error(envvar_get_file("ENVVAR_TEMP_FILE_EXISTS", check_readable = NA))
  expect_error(
    envvar_get_file("ENVVAR_TEMP_FILE_EXISTS", check_readable = "yes")
  )
  expect_error(envvar_get_file("ENVVAR_TEMP_FILE_EXISTS", check_readable = 1))
  expect_error(
    envvar_get_file("ENVVAR_TEMP_FILE_EXISTS", check_readable = c(TRUE, FALSE))
  )
})

test_that("envvar_get_file() validates `check_writable` arguments correctly", {
  # `check_writable` should be a logical scalar
  expect_error(
    envvar_get_file("ENVVAR_TEMP_FILE_EXISTS", check_writable = NULL)
  )
  expect_error(envvar_get_file("ENVVAR_TEMP_FILE_EXISTS", check_writable = NA))
  expect_error(
    envvar_get_file("ENVVAR_TEMP_FILE_EXISTS", check_writable = "yes")
  )
  expect_error(envvar_get_file("ENVVAR_TEMP_FILE_EXISTS", check_writable = 1))
  expect_error(
    envvar_get_file("ENVVAR_TEMP_FILE_EXISTS", check_writable = c(TRUE, FALSE))
  )
})

test_that("envvar_get_file() warns if ... not used properly", {
  expect_error(envvar_get_file("ENVVAR_TEMP_FILE_EXISTS", blah = TRUE))
})

test_that("envvar_get_file() works as expected", {
  expect_equal(
    envvar_get_file("ENVVAR_TEMP_FILE_EXISTS", create = FALSE),
    tempfile_exists
  )
})

test_that("envvar_get_dir() validates `x` arguments correctly", {
  # `x` should be specified and a scalar string
  expect_error(envvar_get_dir())
  expect_error(envvar_get_dir(x = ""))
  expect_error(envvar_get_dir(x = NA_character_))
  expect_error(envvar_get_dir(x = NULL))
  expect_error(envvar_get_dir(x = 21))
  expect_error(
    envvar_get_dir(x = c("ENVVAR_TEMP_DIR_EXISTS", "ENVVAR_TEMP_DIR_EXISTS"))
  )
})

test_that("envvar_get_dir() validates `create` arguments correctly", {
  # `create` should be a logical scalar
  expect_error(envvar_get_dir("ENVVAR_TEMP_DIR_EXISTS", create = NULL))
  expect_error(envvar_get_dir("ENVVAR_TEMP_DIR_EXISTS", create = NA))
  expect_error(envvar_get_dir("ENVVAR_TEMP_DIR_EXISTS", create = "yes"))
  expect_error(envvar_get_dir("ENVVAR_TEMP_DIR_EXISTS", create = 1))
  expect_error(
    envvar_get_dir("ENVVAR_TEMP_DIR_EXISTS", create = c(TRUE, FALSE))
  )
})

test_that("envvar_get_dir() validates `check_readable` arguments correctly", {
  # `check_readable` should be a logical scalar
  expect_error(envvar_get_dir("ENVVAR_TEMP_DIR_EXISTS", check_readable = NULL))
  expect_error(envvar_get_dir("ENVVAR_TEMP_DIR_EXISTS", check_readable = NA))
  expect_error(envvar_get_dir("ENVVAR_TEMP_DIR_EXISTS", check_readable = "yes"))
  expect_error(envvar_get_dir("ENVVAR_TEMP_DIR_EXISTS", check_readable = 1))
  expect_error(
    envvar_get_dir("ENVVAR_TEMP_DIR_EXISTS", check_readable = c(TRUE, FALSE))
  )
})

test_that("envvar_get_dir() validates `check_writable` arguments correctly", {
  # `check_writable` should be a logical scalar
  expect_error(envvar_get_dir("ENVVAR_TEMP_DIR_EXISTS", check_writable = NULL))
  expect_error(envvar_get_dir("ENVVAR_TEMP_DIR_EXISTS", check_writable = NA))
  expect_error(envvar_get_dir("ENVVAR_TEMP_DIR_EXISTS", check_writable = "yes"))
  expect_error(envvar_get_dir("ENVVAR_TEMP_DIR_EXISTS", check_writable = 1))
  expect_error(
    envvar_get_dir("ENVVAR_TEMP_DIR_EXISTS", check_writable = c(TRUE, FALSE))
  )
})

test_that("envvar_get_dir() warns if ... not used properly", {
  expect_error(envvar_get_dir("ENVVAR_TEMP_DIR_EXISTS", blah = TRUE))
})

test_that("validate_file() `create` arg works as expected", {
  # If the file exists, `validate_file()` returns TRUE regardless of value
  expect_true(validate_file(tempfile_exists, create = TRUE))
  expect_true(validate_file(tempfile_exists, create = FALSE))

  # If the file does not exist and `create` is `FALSE`, `validate_file()`
  # returns `FALSE`
  expect_false(validate_file(tempfile_noexist, create = FALSE))

  # If the file does not exist and `create` is `TRUE`, `validate_file()`
  # creates the file and returns `TRUE`
  tempfile_create <- withr::local_tempfile()
  expect_false(fs::file_exists(tempfile_create))
  expect_true(suppressMessages(validate_file(tempfile_create, create = TRUE)))
  expect_true(fs::file_exists(tempfile_create))
})

test_that("validate_file() `check_readable` and `check_writeable()` args works as expected", { # nolint: line_length_linter
  tempfile <- withr::local_tempfile()
  fs::file_create(tempfile, mode = "000")

  # File is neither readable nor writable
  expect_false(
    validate_file(
      tempfile,
      create = FALSE,
      check_readable = TRUE,
      check_writable = TRUE
    )
  )

  expect_false(
    validate_file(
      tempfile,
      create = FALSE,
      check_readable = FALSE,
      check_writable = TRUE
    )
  )

  expect_false(
    validate_file(
      tempfile,
      create = FALSE,
      check_readable = TRUE,
      check_writable = FALSE
    )
  )

  # File is readable, but not writable
  fs::file_chmod(tempfile, mode = "444")
  expect_true(
    validate_file(
      tempfile,
      create = FALSE,
      check_readable = TRUE,
      check_writable = FALSE
    )
  )
  expect_false(
    validate_file(
      tempfile,
      create = FALSE,
      check_readable = TRUE,
      check_writable = TRUE
    )
  )

  # File is both readable and writable
  fs::file_chmod(tempfile, mode = "666")
  expect_true(
    validate_file(
      tempfile,
      create = FALSE,
      check_readable = TRUE,
      check_writable = TRUE
    )
  )

  fs::file_delete(tempfile)
})


test_that("validate_dir() `create` arg works as expected", {
  # If the directory exists, `validate_dir()` returns TRUE regardless of value
  expect_true(validate_dir(tempdir_exists, create = TRUE))
  expect_true(validate_dir(tempdir_exists, create = FALSE))

  # Create a directory that doesn't exist
  tempdir <- paste0(as.character(fs::path_temp()), "EVTEST")
  if (fs::dir_exists(tempdir)) {
    fs::dir_delete(tempdir)
  }

  # If the dir does not exist and `create` is `FALSE`, `validate_dir()`
  # returns `FALSE`
  expect_false(validate_dir(tempdir, create = FALSE))

  # If the directory does not exist and `create` is `TRUE`, `validate_dir()`
  # creates the directory and returns `TRUE`
  expect_true(suppressMessages(validate_dir(tempdir, create = TRUE)))
  expect_true(fs::dir_exists(tempdir))

  fs::file_chmod(tempdir, mode = "777")
  expect_true(
    validate_dir(
      tempdir,
      create = FALSE,
      check_readable = TRUE,
      check_writable = TRUE
    )
  )
  expect_true(
    validate_dir(
      tempdir,
      create = FALSE,
      check_readable = TRUE,
      check_writable = FALSE
    )
  )
  expect_true(
    validate_dir(
      tempdir,
      create = FALSE,
      check_readable = FALSE,
      check_writable = TRUE
    )
  )
  expect_true(
    validate_dir(
      tempdir,
      create = FALSE,
      check_readable = FALSE,
      check_writable = FALSE
    )
  )

  # Directory is not writable
  fs::file_chmod(tempdir, mode = "555")
  expect_false(
    validate_dir(
      tempdir,
      create = FALSE,
      check_readable = TRUE,
      check_writable = TRUE
    )
  )
  expect_true(
    validate_dir(
      tempdir,
      create = FALSE,
      check_readable = TRUE,
      check_writable = FALSE
    )
  )
  expect_false(
    validate_dir(
      tempdir,
      create = FALSE,
      check_readable = FALSE,
      check_writable = TRUE
    )
  )
  expect_true(
    validate_dir(
      tempdir,
      create = FALSE,
      check_readable = FALSE,
      check_writable = FALSE
    )
  )

  fs::dir_delete(tempdir)
})

test_that("envvar_get_dir() works as expected", {
  expect_equal(
    envvar_get_dir("ENVVAR_TEMP_DIR_EXISTS", create = FALSE),
    tempdir_exists
  )
})

fs::file_delete(tempfile_exists)
