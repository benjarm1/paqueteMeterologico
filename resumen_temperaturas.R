#' Resumen de temperaturas
#'
#' Calcula estadísticos descriptivos de una columna de temperaturas,
#' opcionalmente por grupos.
#'
#' @param datos Un `data.frame`.
#' @param col_temp Nombre de la columna numérica de temperatura.
#' @param por Vector de nombres de columnas para agrupar (opcional).
#' @param na.rm Si `TRUE`, ignora valores faltantes.
#'
#' @return Un `data.frame` con `n`, `media`, `mediana`, `minimo`,
#'   `maximo` y `desvio` (una fila por grupo si se usa `por`).
#' @export
#' @examples
#' d <- data.frame(ciudad = c("A", "A", "B"), temperatura = c(20, 25, 30))
#' resumen_temperaturas(d)
#' resumen_temperaturas(d, por = "ciudad")
resumen_temperaturas <- function(datos, col_temp = "temperatura",
                                 por = NULL, na.rm = TRUE) {
  if (!is.data.frame(datos)) {
    stop("`datos` debe ser un data.frame.", call. = FALSE)
  }
  if (!col_temp %in% names(datos)) {
    stop("No existe la columna '", col_temp, "'.", call. = FALSE)
  }
  if (!is.numeric(datos[[col_temp]])) {
    stop("La columna '", col_temp, "' debe ser numérica.", call. = FALSE)
  }
  if (!is.null(por) && !all(por %in% names(datos))) {
    stop("Alguna columna de `por` no existe en `datos`.", call. = FALSE)
  }
  
  calcular <- function(x) {
    if (na.rm) x <- x[!is.na(x)]
    vacio <- length(x) == 0
    data.frame(
      n       = length(x),
      media   = if (vacio) NA_real_ else mean(x),
      mediana = if (vacio) NA_real_ else stats::median(x),
      minimo  = if (vacio) NA_real_ else min(x),
      maximo  = if (vacio) NA_real_ else max(x),
      desvio  = if (length(x) < 2) NA_real_ else stats::sd(x)
    )
  }
  
  if (is.null(por)) {
    return(calcular(datos[[col_temp]]))
  }
  
  grupos <- unique(datos[por])
  grupos <- grupos[do.call(order, unname(as.list(grupos))), , drop = FALSE]
  
  filas <- lapply(seq_len(nrow(grupos)), function(i) {
    idx <- Reduce(`&`, lapply(por, function(p) datos[[p]] == grupos[[p]][i]))
    idx[is.na(idx)] <- FALSE
    cbind(grupos[i, , drop = FALSE], calcular(datos[[col_temp]][idx]))
  })
  
  res <- do.call(rbind, filas)
  rownames(res) <- NULL
  res
}