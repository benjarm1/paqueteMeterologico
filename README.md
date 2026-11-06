
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

## Funciones disponibles

El paquete incluye cuatro funciones para trabajar con datos
meteorológicos:

- `leer_estacion()`: permite obtener datos meteorológicos de una
  estación.
- `celsius_a_fahrenheit()`: convierte temperaturas de grados Celsius a
  Fahrenheit.
- `resumen_temperaturas()`: calcula estadísticas descriptivas de
  temperatura, con la posibilidad de agrupar los datos.
- `graficar_temperaturas()`: genera gráficos de líneas, histogramas y
  diagramas de caja.

## Ejemplo de análisis

``` r
library(paqueteMeteorologico)

# Resumen de temperaturas
resumen_temperaturas(
  datos,
  col_temp = "temperatura_abrigo_150cm"
)

# Histograma de temperaturas
graficar_temperaturas(
  datos,
  col_temp = "temperatura_abrigo_150cm",
  tipo = "histograma"
)
```

## Desarrollo

Este paquete fue desarrollado como trabajo práctico grupal de
Programación 2 de la Universidad Austral. Incluye funciones,
documentación, pruebas automatizadas y una viñeta de uso.

## Autores

- Benjamín Ríos Maderna
- Matías Miailhe

Trabajo grupal de Programacion 2 - Universidad Austral
