# Analisis descriptivo de la base de datos "datos"
# Articulo: Pulgarin et al. (2019). DYNA, 86(210), 131-136.
# Variables: Tipo (coagulante A, B o C), Tiempo (min), Profundidad (cm),
#            Porcentaje (% de particulas floculentas removidas)


# 1. Lectura de datos

if (!requireNamespace("readxl", quietly = TRUE)) install.packages("readxl")
library(readxl)

url <- "https://raw.githubusercontent.com/kmonterrosa04/Articulo_regresion/main/datos.xlsx"
archivo <- tempfile(fileext = ".xlsx")
download.file(url, destfile = archivo, mode = "wb")
datos <- as.data.frame(read_excel(archivo))

# Variables en espanol
names(datos) <- c("Tipo", "Tiempo", "Profundidad", "Porcentaje")
datos$Tipo <- factor(datos$Tipo, levels = c("A", "B", "C"))

str(datos)


# 2. Estructura y resumen general

dim(datos)
colSums(is.na(datos))
summary(datos)
table(datos$Tipo)
round(prop.table(table(datos$Tipo)), 3)


# 3. Variable respuesta: Porcentaje

y <- datos$Porcentaje
estadisticos <- c(n        = length(y),
                  media    = mean(y),
                  mediana  = median(y),
                  desv_est = sd(y),
                  minimo   = min(y),
                  Q1       = unname(quantile(y, 0.25)),
                  Q3       = unname(quantile(y, 0.75)),
                  maximo   = max(y),
                  CV_pct   = 100 * sd(y) / mean(y))
round(estadisticos, 2)

# Por tipo de coagulante
resumen_tipo <- do.call(rbind, tapply(datos$Porcentaje, datos$Tipo, function(x) {
  c(n = length(x), media = mean(x), mediana = median(x),
    desv_est = sd(x), minimo = min(x), maximo = max(x))
}))
round(resumen_tipo, 2)


# 4. Porcentaje segun tiempo y profundidad

round(tapply(datos$Porcentaje, datos$Tiempo, mean), 2)
round(tapply(datos$Porcentaje, datos$Profundidad, mean), 2)
round(tapply(datos$Porcentaje, list(datos$Tipo, datos$Profundidad), mean), 2)

# Correlaciones
round(cor(datos[, c("Tiempo", "Profundidad", "Porcentaje")]), 3)


# 5. Graficos ----

colores <- c(A = "steelblue", B = "darkorange", C = "forestgreen")

graphics.off()
dev.new(width = 10, height = 8)
par(mfrow = c(2, 2), mar = c(4, 4, 2, 1))

hist(datos$Porcentaje, breaks = 10, col = "lightgray", border = "white",
     main = "Histograma de Porcentaje",
     xlab = "Porcentaje de remocion (%)", ylab = "Frecuencia")

boxplot(Porcentaje ~ Tipo, data = datos, col = colores,
        main = "Porcentaje segun tipo de coagulante",
        xlab = "Tipo de coagulante", ylab = "Porcentaje de remocion (%)")

plot(datos$Tiempo, datos$Porcentaje, pch = 19,
     col = colores[as.character(datos$Tipo)],
     main = "Porcentaje vs Tiempo",
     xlab = "Tiempo (min)", ylab = "Porcentaje de remocion (%)")
legend("bottomright", legend = levels(datos$Tipo), col = colores,
       pch = 19, title = "Tipo", bty = "n")

plot(datos$Profundidad, datos$Porcentaje, pch = 19,
     col = colores[as.character(datos$Tipo)],
     main = "Porcentaje vs Profundidad",
     xlab = "Profundidad (cm)", ylab = "Porcentaje de remocion (%)")
legend("bottomleft", legend = levels(datos$Tipo), col = colores,
       pch = 19, title = "Tipo", bty = "n")

# Media de Porcentaje en el tiempo, por tipo
par(mfrow = c(1, 1), mar = c(4, 4, 3, 1))
medias <- tapply(datos$Porcentaje, list(datos$Tiempo, datos$Tipo), mean)
matplot(as.numeric(rownames(medias)), medias, type = "b", pch = 19, lty = 1,
        col = colores, main = "Media de Porcentaje a lo largo del tiempo",
        xlab = "Tiempo (min)", ylab = "Porcentaje de remocion medio (%)")
legend("bottomright", legend = colnames(medias), col = colores,
       pch = 19, lty = 1, title = "Tipo", bty = "n")

# Matriz de dispersion
pairs(datos[, c("Tiempo", "Profundidad", "Porcentaje")],
      col = colores[as.character(datos$Tipo)], pch = 19,
      main = "Matriz de dispersion")
