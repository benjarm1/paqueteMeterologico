library(paqueteMeteorologico)

# Descargar y leer los registros de la estación
datos <- leer_estacion("NH0472", tempdir())

# Chequeos básicos antes de guardar
stopifnot(is.data.frame(datos), nrow(datos) > 0)
message("Observaciones: ", nrow(datos), " | Variables: ", ncol(datos))

# Guardar en data/datos.rda (comprimido)
usethis::use_data(datos, overwrite = TRUE, compress = "xz")
