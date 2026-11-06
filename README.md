
# paqueteMeteorologico

<!-- badges: start -->

[![R-CMD-check](https://github.com/benjarm1/paqueteMeterologico/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/benjarm1/paqueteMeterologico/actions/workflows/R-CMD-check.yaml)
[![Codecov test
coverage](https://codecov.io/gh/benjarm1/paqueteMeterologico/graph/badge.svg)](https://app.codecov.io/gh/benjarm1/paqueteMeterologico)
<!-- badges: end -->

Paquete de R desarrollado para la materia Programacion II de la
Universidad Austral, sede Rosario.

El objetivo es facilitar la lectura y el analisis de datos
meteorologicos, utilizando registros de estaciones meteorologicas.

## Instalacion

Para instalar el paquete desde GitHub:

``` r
install.packages("pak")
pak::pak("benjarm1/paqueteMeterologico")
```

## Funciones

Por ahora el paquete incluye estas funciones:

### leer_estacion()

Permite descargar un archivo CSV con los registros de una estacion
meteorologica y cargarlo en R.

``` r
library(paqueteMeteorologico)

datos_estacion <- leer_estacion("NH0472", tempdir())
head(datos_estacion)
```

### celsius_a_fahrenheit()

Convierte una temperatura de grados Celsius a Fahrenheit.

``` r
celsius_a_fahrenheit(25)
# Resultado: 77
```

## Datos

El paquete incluye el conjunto de datos `datos`, correspondiente a la
estacion NH0472.

Contiene 20425 observaciones y 35 variables meteorologicas, incluyendo
temperaturas, humedad, viento y precipitaciones.

``` r
data("datos", package = "paqueteMeteorologico")
head(datos)
```

## Desarrollo

El paquete se encuentra en desarrollo como parte del segundo parcial de
Programacion II.

Se incorporaran funciones para resumir temperaturas y generar graficos
mensuales.

## Autores

Trabajo grupal de Programacion II
