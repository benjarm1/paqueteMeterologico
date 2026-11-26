
#' @format Un data frame con 20425 filas y 35 variables. Entre ellas:
#' \describe{
#'   \item{temperatura_abrigo_150cm}{Temperatura a 150 cm, en grados Celsius.}
#'   \item{...}{Resto de las variables meteorológicas de la estación.}
#' }
#' @source Registros de estaciones meteorológicas, descargados con
#'   [leer_estacion()].
#' @examples
#' data("datos", package = "paqueteMeteorologico")
#' head(datos)
"datos"
