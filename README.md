# sample-variance-simulation-r
# Simulación de estimadores de la varianza muestral en R

Este repositorio contiene una práctica de simulación en R cuyo objetivo es analizar el comportamiento de dos estimadores de la varianza poblacional:

- Cuasivarianza muestral \( S^2 \)
- Varianza muestral \( s^2 \)

## Objetivo

Simular \( B = 50000 \) muestras de una distribución normal \( N(0,1) \) para distintos tamaños muestrales:

- \( n = 25 \)
- \( n = 50 \)
- \( n = 100 \)

y aproximar:

- \( E[S^2] \)
- \( E[s^2] \)
- El sesgo de ambos estimadores

## Fundamento teórico

- \( S^2 = \frac{1}{n-1} \sum (X_i - \bar{X})^2 \) es un estimador **insesgado** de \( \sigma^2 \)
- \( s^2 = \frac{1}{n} \sum (X_i - \bar{X})^2 \) es un estimador **sesgado**, con:

\[
E[s^2] = \frac{n-1}{n} \sigma^2
\]

## Metodología

Para cada valor de \( n \):

1. Se generan 50000 muestras de tamaño \( n \) usando `rnorm()`
2. Se calculan ambos estimadores
3. Se almacenan los resultados
4. Se estiman las esperanzas mediante la media muestral

## Resultados

Ejemplo de salida:

| n   | E[S²] | E[s²] | Sesgo S² | Sesgo s² |
|-----|------|------|----------|----------|
| 25  | ≈1.00 | ≈0.96 | ≈0 | ≈-0.04 |
| 50  | ≈1.00 | ≈0.98 | ≈0 | ≈-0.02 |
| 100 | ≈1.00 | ≈0.99 | ≈0 | ≈-0.01 |

## Conclusiones

- La cuasivarianza muestral es insesgada
- La varianza muestral subestima la varianza poblacional
- El sesgo disminuye al aumentar el tamaño muestral
- Las simulaciones reproducen fielmente los resultados teóricos

## Requisitos

- R (>= 4.0)
- No se requieren paquetes adicionales

## Ejecución

```r
source("simulacion.R")
