datos_prueba <- function() {
  data.frame(
    fecha = as.Date("2024-01-01") + 0:5,
    ciudad = rep(c("A", "B"), each = 3),
    temperatura = c(20, 22, 24, 30, NA, 34)
  )
}