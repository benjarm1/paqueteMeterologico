#' Gráfico de temperaturas
#'
#' @param datos Un `data.frame`.
#' @param col_temp Nombre de la columna de temperatura.
#' @param col_fecha Nombre de la columna de fecha (requerida para `tipo = "linea"`).
#' @param tipo Tipo de gráfico: `"linea"`, `"histograma"` o `"caja"`.
#' @param por Columna opcional para colorear/separar por grupo.
#' @param titulo Título del gráfico.
#'
#' @return Un objeto `ggplot`.
#' @importFrom rlang .data
#' @export
#' @examples
#' d <- data.frame(fecha = as.Date("2024-01-01") + 0:9,
#'                 temperatura = c(20, 22, 21, 25, 27, 26, 24, 23, 22, 21))
#' graficar_temperaturas(d, col_fecha = "fecha")
#' graficar_temperaturas(d, tipo = "histograma")
graficar_temperaturas <- function(datos, col_temp = "temperatura",
                                  col_fecha = NULL,
                                  tipo = c("linea", "histograma", "caja"),
                                  por = NULL,
                                  titulo = "Temperaturas") {
  tipo <- match.arg(tipo)

  if (!is.data.frame(datos)) {
    stop("`datos` debe ser un data.frame.", call. = FALSE)
  }
  if (!col_temp %in% names(datos)) {
    stop("No existe la columna '", col_temp, "'.", call. = FALSE)
  }
  if (!is.null(por) && !por %in% names(datos)) {
    stop("No existe la columna '", por, "'.", call. = FALSE)
  }
  if (tipo == "linea") {
    if (is.null(col_fecha) || !col_fecha %in% names(datos)) {
      stop("Para `tipo = \"linea\"` indica una `col_fecha` valida.", call. = FALSE)
    }
  }

  base <- ggplot2::ggplot(datos)

  p <- switch(
    tipo,
    linea = {
      aes_l <- if (is.null(por)) {
        ggplot2::aes(x = .data[[col_fecha]], y = .data[[col_temp]])
      } else {
        ggplot2::aes(x = .data[[col_fecha]], y = .data[[col_temp]],
                     colour = .data[[por]], group = .data[[por]])
      }
      base + ggplot2::geom_line(aes_l) +
        ggplot2::labs(x = "Fecha", y = "Temperatura")
    },
    histograma = {
      aes_h <- if (is.null(por)) {
        ggplot2::aes(x = .data[[col_temp]])
      } else {
        ggplot2::aes(x = .data[[col_temp]], fill = .data[[por]])
      }
      base + ggplot2::geom_histogram(aes_h, bins = 20, alpha = 0.8) +
        ggplot2::labs(x = "Temperatura", y = "Frecuencia")
    },
    caja = {
      aes_c <- if (is.null(por)) {
        ggplot2::aes(y = .data[[col_temp]])
      } else {
        ggplot2::aes(x = .data[[por]], y = .data[[col_temp]])
      }
      base + ggplot2::geom_boxplot(aes_c) +
        ggplot2::labs(y = "Temperatura")
    }
  )

  p + ggplot2::labs(title = titulo) + ggplot2::theme_minimal()
}
