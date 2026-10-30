test_that("conversion de temperatura", {
  expect_equal(celsius_a_fahrenheit(0), 32)
  expect_equal(celsius_a_fahrenheit(100), 212)
  expect_equal(celsius_a_fahrenheit(25), 77)
})

test_that("error si no es un numero", {
  expect_error(celsius_a_fahrenheit("hola"))
})
