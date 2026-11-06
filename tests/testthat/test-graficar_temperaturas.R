test_that("devuelve objetos ggplot para cada tipo", {
  d <- datos_prueba()
  expect_s3_class(graficar_temperaturas(d, col_fecha = "fecha"), "ggplot")
  expect_s3_class(graficar_temperaturas(d, tipo = "histograma"), "ggplot")
  expect_s3_class(graficar_temperaturas(d, tipo = "caja", por = "ciudad"), "ggplot")
})

test_that("linea exige col_fecha", {
  expect_error(graficar_temperaturas(datos_prueba(), tipo = "linea"), "col_fecha")
})

test_that("valida columnas y tipo", {
  d <- datos_prueba()
  expect_error(graficar_temperaturas(d, col_temp = "x"), "No existe")
  expect_error(graficar_temperaturas(d, tipo = "otro"))
})