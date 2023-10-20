# envvar_get_ipaddress() works as expected with invalid IPv4

    Code
      envvar_get_ipaddress("TEST_IPV4")
    Condition
      Error in `transform()`:
      ! "256.256.1.4" is not a valid IP address

# envvar_get_ipaddress() works as expected with invalid IPv6

    Code
      envvar_get_ipaddress("TEST_IPV6")
    Condition
      Error in `transform()`:
      ! "not even close to valid" is not a valid IP address

