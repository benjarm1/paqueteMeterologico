#' pasar de celsius a fahrenheit
#'
#' @param celsius temperatura en celsius
#' @return temperatura en fahrenheit
#' @export

celsius_a_fahrenheit <- function(celsius) {

  if (!is.numeric(celsius)) {
    cli::cli_abort("La temperatura tiene que ser un numero")
  }

  resultado <- (celsius * 9/5) + 32
  return(resultado)
}
