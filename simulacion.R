# -- Enunciado ---

# En este ejercicio se propone simular B = 50000 valores de las distribuciones
# de los estimadores cuasivarianza muestral y varianza muestral
# a partir de muestras de tamaño n tomadas de una poblacion N (0, σ).

# 1. Calcular, a partir de las simulaciones, los valores aproximados de E{S^2}
# y E{s^2} para los tamaños muestrales n = 25, n = 50 y n = 100; tomese σ = 1.

# 2. Utilizar los valores anteriores para aproximar el sesgo de ambos estimadores.

# Numero de simulaciones
B <- 50000

# Valores de n
n_values <- c(25, 50, 100)

# data frame para guardar posteriormente lso resultados
results <- data.frame(
  n = numeric(),
  E_S2 = numeric(),
  E_s2 = numeric(),
  sesgo_S2 = numeric(),
  sesgo_s2 = numeric()
)

# Itera sobre cada valor de n
for(n in n_values) {
  insesgada_vals <- numeric(B) # Guarda las cuasivarianzas
  sesgada_vals <- numeric(B) # Guarda las varianzas
  
  # Ejecuta B simulaciones independientes
  for(b in 1:B) {
    # Genera una muestra aleatoria de tamaño n de N(0,1)
    muestra <- rnorm(n, mean = 0, sd = 1)
    
    # Calculo de la cuasivarianza
    insesgada <- var(muestra)
    
    # Calculo de la varianza
    sesgada <- ((n - 1) / n) * insesgada
    
    # Almacenamos los datos
    insesgada_vals[b] <- insesgada
    sesgada_vals[b] <- sesgada
  }
  
  # Calculo de esperanzas aproximadas
  E_insesgada <- mean(insesgada_vals)
  E_sesgada <- mean(sesgada_vals)
  
  # Calculo del sesgo
  sesgo_insesgada <- E_insesgada - 1
  sesgo_sesgada <- E_sesgada - 1
  
  results <- rbind(results, 
                   data.frame(
                     n = n,
                     E_S2 = E_insesgada,
                     E_s2 = E_sesgada,
                     sesgo_S2 = sesgo_insesgada,
                     sesgo_s2 = sesgo_sesgada
                   ))
}

print(results)

# Valores teóricos
E_S2_teorico <- rep(1, length(n_values))
E_s2_teorico <- (n_values - 1) / n_values

# Gráfica
plot(results$n, results$E_S2, type = "b", pch = 16,
     ylim = c(0.95, 1.01),
     xlab = "Tamaño muestral (n)",
     ylab = "Esperanza",
     main = "Esperanza de los estimadores")

lines(results$n, results$E_s2, type = "b", pch = 17)

# Teóricos
lines(n_values, E_S2_teorico, lty = 2)
lines(n_values, E_s2_teorico, lty = 2)

legend("bottomright",
       legend = c("E[S^2] simulado", "E[s^2] simulado",
                  "E[S^2] teórico", "E[s^2] teórico"),
       pch = c(16,17,NA,NA),
       lty = c(1,1,2,2))

# Sesgos teóricos
sesgo_S2_teorico <- rep(0, length(n_values))
sesgo_s2_teorico <- -1 / n_values

plot(results$n, results$sesgo_S2, type = "b", pch = 16,
     ylim = c(-0.05, 0.005),
     xlab = "Tamaño muestral (n)",
     ylab = "Sesgo",
     main = "Sesgo de los estimadores")

lines(results$n, results$sesgo_s2, type = "b", pch = 17)

# Teóricos
lines(n_values, sesgo_S2_teorico, lty = 2)
lines(n_values, sesgo_s2_teorico, lty = 2)

legend("bottomright",
       legend = c("Sesgo S^2 simulado", "Sesgo s^2 simulado",
                  "Sesgo S^2 teórico", "Sesgo s^2 teórico"),
       pch = c(16,17,NA,NA),
       lty = c(1,1,2,2))
