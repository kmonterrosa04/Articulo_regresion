# Articulo_regresion

Base de datos para entrenar un modelo de regresión, construida a partir del siguiente artículo científico:

> Pulgarín, D. A., Santamaría-Álzate, F., Ruge, J. C. y Orduz, O. I. (2019). *Determinación de los coeficientes del modelo de San, para calcular el porcentaje de remoción de partículas floculentas con tres tipos de coagulantes*. DYNA, 86(210), 131–136. https://doi.org/10.15446/dyna.v86n210.74851

## Contexto

En la potabilización del agua, los coagulantes hacen que las partículas suspendidas se agrupen en flóculos que luego se sedimentan. Los autores llenaron una torre de sedimentación (altura máxima de 175 cm) con agua problema de turbiedad inicial entre 25 y 30 NTU, preparada con bentonita, y midieron la turbiedad remanente a distintos tiempos (hasta 120 minutos) y distintas profundidades. Con esas mediciones calcularon el porcentaje de material removido y ajustaron el modelo propuesto por Hasan Ali San (1989).

## Archivo `datos.xlsx`

Contiene 235 observaciones, una por cada medición, organizadas en 4 columnas:

| Variable | Descripción | Unidad |
|---|---|---|
| `Type` | Tipo de coagulante (variable categórica) | A, B o C |
| `Time` | Tiempo de sedimentación | minutos |
| `Depth` | Profundidad de la muestra en la torre | cm |
| `Percentage` | Porcentaje de partículas floculentas removidas (**variable respuesta**) | % |

Tipos de coagulante:

| Type | Coagulante | Tabla del artículo | Observaciones |
|---|---|---|---|
| A | Sulfato de aluminio tipo A | Tabla 2 | 78 |
| B | Sulfato de aluminio tipo B | Tabla 3 | 81 |
| C | Cloruro férrico | Tabla 4 | 76 |

Rangos: `Time` de 5 a 120 minutos y `Depth` de 25 a 175 cm (25, 50, 75, 100, 125, 150 y 175).
