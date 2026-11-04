test_that("lee los datos de la estacion", {
  datos <- leer_estacion("NH0472", tempdir())

  expect_s3_class(datos, "data.frame")
  expect_equal(ncol(datos), 35)
  expect_true(nrow(datos) > 0)
  expect_true("fecha" %in% names(datos))
})

test_that("controla los argumentos", {
  expect_error(leer_estacion(123, tempdir()))
  expect_error(leer_estacion("NH0472", "carpeta_inexistente"))
  expect_error(leer_estacion("", tempdir()))
})
