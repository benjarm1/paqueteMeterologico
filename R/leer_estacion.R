
#' Descargar datos de una estacion meteorologica
#'
#' Descarga un archivo CSV con datos meteorologicos
#' y devuelve una tabla con las mediciones.
#'
#' @param id codigo de la estacion
#' @param destino carpeta donde guardar el CSV
#' @return data.frame con las mediciones de la estacion
#' @export
#' @examples
#' \dontrun{
#' leer_estacion("NH0472", tempdir())
#' }

leer_estacion <- function(id, destino) {

  if (!is.character(id) || length(id) != 1 ||
      is.na(id) || !grepl("^[A-Za-z0-9]+$", id)) {
    cli::cli_abort("El id de la estacion no es valido")
  }

  if (!is.character(destino) || length(destino) != 1 ||
      is.na(destino) || !dir.exists(destino)) {
    cli::cli_abort("La carpeta de destino no existe")
  }

  url <- paste0(
    "https://raw.githubusercontent.com/rse-r/",
    "intro-programacion/main/datos/", id, ".csv"
  )

  archivo <- file.path(destino, paste0(id, ".csv"))

  tryCatch(
    utils::download.file(url, archivo, mode = "wb", quiet = TRUE),
    error = function(e) {
      cli::cli_abort("No se pudo descargar el archivo")
    }
  )

  return(leer_archivo_estacion(archivo))
}
# Lee el csv y comprueba las columnas
leer_archivo_estacion <- function(archivo) {

  datos <- utils::read.csv(archivo)

  columnas <- c("id", "fecha", "temperatura_abrigo_150cm")

  if (!all(columnas %in% names(datos))) {
    cli::cli_abort("Faltan columnas en el archivo")
  }

  datos$fecha <- as.Date(datos$fecha)

  return(datos)
}
