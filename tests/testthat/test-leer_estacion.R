test_that("lee un archivo csv local", {

  archivo <- tempfile(fileext = ".csv")
  on.exit(unlink(archivo))

  ejemplo <- data.frame(
    id = c("NH0472", "NH0472"),
    fecha = c("2026-01-01", "2026-01-02"),
    temperatura_abrigo_150cm = c(20, 25)
  )

  utils::write.csv(ejemplo, archivo, row.names = FALSE)

  resultado <- leer_archivo_estacion(archivo)

  expect_s3_class(resultado, "data.frame")
  expect_equal(nrow(resultado), 2)
  expect_s3_class(resultado$fecha, "Date")
  expect_equal(resultado$temperatura_abrigo_150cm, c(20, 25))
})

test_that("detecta columnas faltantes", {

  archivo <- tempfile(fileext = ".csv")
  on.exit(unlink(archivo))

  utils::write.csv(
    data.frame(id = "NH0472", fecha = "2026-01-01"),
    archivo,
    row.names = FALSE
  )

  expect_error(
    leer_archivo_estacion(archivo),
    "Faltan columnas"
  )
})

test_that("controla los argumentos", {

  expect_error(leer_estacion(123, tempdir()))
  expect_error(leer_estacion("NH0472", "carpeta_inexistente"))
  expect_error(leer_estacion("", tempdir()))
})
test_that("descarga y lee una estacion", {

  local_mocked_bindings(
    descargar_csv = function(url, archivo) {

      ejemplo <- data.frame(
        id = "NH0472",
        fecha = "2026-01-01",
        temperatura_abrigo_150cm = 20
      )

      utils::write.csv(ejemplo, archivo, row.names = FALSE)
      invisible(0)
    }
  )

  resultado <- leer_estacion("NH0472", tempdir())

  expect_s3_class(resultado, "data.frame")
  expect_equal(nrow(resultado), 1)
  expect_equal(resultado$temperatura_abrigo_150cm, 20)
})

test_that("avisa cuando falla la descarga", {

  local_mocked_bindings(
    descargar_csv = function(url, archivo) {
      stop("Error de conexion")
    }
  )

  expect_error(
    leer_estacion("NH0472", tempdir()),
    "No se pudo descargar"
  )
})
