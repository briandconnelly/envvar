# `envvar_set()` and `envvar_unset()` work as expected

    Code
      envvar_set()
    Condition
      Error in `envvar_set()`:
      ! Arguments must be a name-value pair. For example, `envvar_set("MYVAR" = "value")`.

---

    Code
      envvar_set(TEST1 = "val1", "TEST2")
    Condition
      Error in `envvar_set()`:
      ! Arguments must be a name-value pair. For example, `envvar_set("MYVAR" = "value")`.

---

    Code
      envvar_unset("TEST_NOTSET")
    Message
      i Environment variable `TEST_NOTSET` is not set.

