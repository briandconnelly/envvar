# envvar_get() validates `transform` argument correctly

    Code
      envvar_get("HOME", transform = TRUE)
    Condition
      Error in `envvar_get()`:
      ! `transform` must be a function

# envvar_get() validates `validate` argument correctly

    Code
      envvar_get("HOME", validate = TRUE)
    Condition
      Error in `envvar_get()`:
      ! `validate` must be a function

# envvar_get() errors if variable unset (and error_if_unset = TRUE)

    Code
      envvar_get("TESTENV_ENVVAR", error_if_unset = TRUE)
    Condition
      Error in `envvar_get()`:
      ! Environment variable `TESTENV_ENVVAR` is not set.

# envvar_get() shows message if variable unset (and error_if_unset = FALSE)

    Code
      expect_equal(envvar_get("TESTENV_ENVVAR", default = "HELLO", error_if_unset = FALSE),
      "HELLO")
    Message
      i Environment variable `TESTENV_ENVVAR` is not set. Using default value "HELLO".

# envvar_get() `validate` function works as expected

    Code
      envvar_get("TESTENV_ENVVAR", validate = function(x) nchar(x) == 50L)
    Condition
      Error in `envvar_get()`:
      ! "HELLO" is not a valid value for `TESTENV_ENVVAR`

# envvar_get_oneof() works as expected

    Code
      envvar_get_oneof("TESTENV_ENVVAR", choices = c("APPLE", "DUCK"))
    Condition
      Error in `envvar_get()`:
      ! "HELLO" is not a valid value for `TESTENV_ENVVAR`

