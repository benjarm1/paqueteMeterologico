test_that("resumen global es correcto", {
  r <- resumen_temperaturas(datos_prueba())
  expect_equal(r$n, 5)
  expect_equal(r$media, mean(c(20, 22, 24, 30, 34)))
  expect_equal(r$minimo, 20)
  expect_equal(r$maximo, 34)
})

test_that("resumen por grupo devuelve una fila por grupo", {
  r <- resumen_temperaturas(datos_prueba(), por = "ciudad")
  expect_equal(nrow(r), 2)
  expect_equal(r$ciudad, c("A", "B"))
  expect_equal(r$media, c(22, 32))
})

test_that("na.rm = FALSE propaga NA", {
  r <- resumen_temperaturas(datos_prueba(), na.rm = FALSE)
  expect_true(is.na(r$media))
})

test_that("valida entradas", {
  expect_error(resumen_temperaturas(1:3), "data.frame")
  expect_error(resumen_temperaturas(datos_prueba(), col_temp = "x"), "No existe")
  expect_error(resumen_temperaturas(datos_prueba(), col_temp = "ciudad"), "numérica")
  expect_error(resumen_temperaturas(datos_prueba(), por = "zzz"), "no existe")
})