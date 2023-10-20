# `envvar_get_integer()` warnings for non-integerish things

    Code
      envvar_get_integer("TEST_DBL")
    Condition
      Error in `transform()`:
      ! "1.23" is not an integer-like value

# `envvar_get_logical()` works as expected

    Code
      envvar_get_logical("TEST_LOGICAL_BAD")
    Condition
      Error in `transform()`:
      ! "YEP" is not a logical value

