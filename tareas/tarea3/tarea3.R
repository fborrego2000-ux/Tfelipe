#tarea n°3

# Ejercicios de la sección primeros pasos

## ejercicio 1: para comprobar el número de filas y columnas, primero se instala
# el paquete palmerpenguins (junto con el resto de paquetes necesarios) y luego se carga la vista previa del archivo 
# penguins
install.packages("palmerpenguins")
install.packages("tidyverse")
install.packages("ggthemes")

library(palmerpenguins)
library(ggthemes)
library(tidyverse)
penguins
# A tibble: 344 × 8
species island    bill_length_mm bill_depth_mm flipper_length_mm body_mass_g sex     year
<fct>   <fct>              <dbl>         <dbl>             <int>       <int> <fct>  <int>
  1 Adelie  Torgersen           39.1          18.7               181        3750 male    2007
2 Adelie  Torgersen           39.5          17.4               186        3800 female  2007
3 Adelie  Torgersen           40.3          18                 195        3250 female  2007
4 Adelie  Torgersen           NA            NA                  NA          NA NA      2007
5 Adelie  Torgersen           36.7          19.3               193        3450 female  2007
6 Adelie  Torgersen           39.3          20.6               190        3650 male    2007
7 Adelie  Torgersen           38.9          17.8               181        3625 female  2007
8 Adelie  Torgersen           39.2          19.6               195        4675 male    2007
9 Adelie  Torgersen           34.1          18.1               193        3475 NA      2007
10 Adelie  Torgersen           42            20.2               190        4250 NA      2007 
# ℹ 334 more rows
# ℹ Use `print(n = ...)` to see more rows

# se observa que hay 8 columnas y 344 filas.

# Punto 2: para ver la descripción de la variable bill_depth_mm, se emplea el comando help
help("penguins")
#bill_depth_mm
#a number denoting bill depth (millimeters)
# Denota profundidad en milímetros.

#Punto 3: creamos el diagrama usando las variables especificadas.

ggplot(
  data = penguins,
  mapping = aes(x = bill_length_mm, y = bill_depth_mm)
) +
  geom_point()

# Punto 4: creamos el diagrama usando las variables especificadas.

ggplot(
  data = penguins,
  mapping = aes(x = species, y = bill_depth_mm)
) +
  geom_point()
# Se observa que la especie adelie tiene la mayor profundidad y que gentoo tiene la menor
# El geom que mejor se acoplaría a este diagrama es el de líneas o geom_line
 
ggplot(
  data = penguins,
  mapping = aes(x = species, y = bill_depth_mm)
) +
  geom_line()


# Punto 5: analizamos el error

ggplot(data = penguins) + 
  geom_point()

# El error se da porque faltan los ejes x e y, para solucionarlo simplemente se
# especifican dichos ejes


# punto 6: no pude resolverlo

# punto 7:

# Punto 8: recreación

ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g)
) +  geom_point(mapping = aes(colour =  bill_depth_mm)) + geom_smooth(se = FALSE)

# Punto 9:Mi predicción para el código es qu este va a crear un diagrama de dispersión
# con ejes x flipper_length_m y eje y body_mass cuyo difernciador será la isla 
# donde se realizó el muestreo (diferenciado por medio de colores).
ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g, color = island)
) +
  geom_point() +
  geom_smooth(se = FALSE)

# Punto 10: ambos gráficos se ven igual, a pesar de que su código está distribuido
# de manera diferente (siguen teniendo el mismo código).

# Gráfico 1
ggplot(
  data = penguins,
  mapping = ggplot(diamonds, aes(x = carat)) + geom_histogram(binwidth = 20)
) +
  geom_point() +
  geom_smooth()

# Gráfico 2
ggplot() +
  geom_point(
    data = penguins,
    mapping = aes(x = flipper_length_mm, y = body_mass_g)
  ) +
  geom_smooth(
    data = penguins,
    mapping = aes(x = flipper_length_mm, y = body_mass_g)
  )
  

# Sección de visualización de variables 

# Punto 1:
ggplot(penguins, aes(y = species)) + geom_bar()
# Ahora las barras se muestras en horizontal, pero mantienen sus valores intactos

# Punto 2: ejecutamos los códigos provistos

ggplot(penguins, aes(x = species)) +
  geom_bar(color = "red")

ggplot(penguins, aes(x = species)) +
  geom_bar(fill = "red")

# La estética "fill" es la mejor para colorear las barras, ya que "color" sólo
# pinta los bordes pero no el interior de las mismas.

# punto 3: el argumento "bin" sirve para ajustar y adaptar las barras de un histograma
# a un valor de interés. Lo que permite que los distintos valores observados dentro de un histograma
#  se agrupen de manera más o menos espaciada.

# Punto 4: creamos los histogramas

ggplot(diamonds, aes(x = carat)) + geom_histogram(binwidth = 1)

ggplot(diamonds, aes(x = carat)) + geom_histogram(binwidth = 100)

ggplot(diamonds, aes(x = carat)) + geom_histogram(binwidth = 1000)

ggplot(diamonds, aes(x = carat)) + geom_histogram(binwidth = 100000)

ggplot(diamonds, aes(x = carat)) + geom_histogram(binwidth = 100000000)

# El histograma cuyo rango nos ofrece una observación más clara es el que tiene
# un bin igual a 1.

# Sección visualización de relaciones:

# Punto 1:
# Variables numéricas: year, displ, cyl, cty y hwy. 
# Variables categóricas: manufacturer, model, trans, drv, fl y class
#
?mpg
library(mpg)

# Punto 2:
 
ggplot(mpg, aes (x = hwy , y = displ)) + geom_point()
# No pude resolverlo

# Punto 3:

# Punto 4:

#Punto 5: 

ggplot(penguins, aes(x = bill_depth_mm, y = bill_length_mm, colour = species)) +
  geom_point()
# agregar colores por especie permite apreciar que las 3 especies disponibles en la base de datos
# se juntan o congregan alrededor de una zona de la gráfica, donde no suelen entrar otras especies.
# Evidencia tendencias de las especies a presentar características físicas comunes.


# Punto 6: 

ggplot(
  data = penguins,
  mapping = aes(
    x = bill_length_mm, y = bill_depth_mm, 
    color = species, shape = species
  )
) +
  geom_point() +
  labs(color = "Species")
# Para solucionar el inconveniente de las leyendas se elimina el comando de labs
# el cual nombraba de manera única al coloreado por especie. Ahora los comandos
# de color y shape se unifican

ggplot(
  data = penguins,
  mapping = aes(
    x = bill_length_mm, y = bill_depth_mm, 
    color = species, shape = species
  )
) +
  geom_point() 

# Punto 7:

ggplot(penguins, aes(x = island, fill = species)) +
  geom_bar(position = "fill")

ggplot(penguins, aes(x = species, fill = island)) +
  geom_bar(position = "fill")

# Con el primer gráfico se puede averiguar que proporción de cada una de las islas
# está habitada por cada especie de pingûino.
# Con el segundo gráfico se puede averiguar la distribución de las especies de pinguinos
# en cada una de las islas dentro del muestrario.


# Sección de guardado:

# Punto 1: 
ggplot(mpg, aes(x = class)) +
  geom_bar()

ggplot(mpg, aes(x = cty, y = hwy)) +
  geom_point()

ggsave("mpg-plot.png")

# El segundo gráfico será el que se guardará en el equipo, ya que fue el último
# en generarse.

# Punto 2: para averiguar cómo pasar el gráfico a pdf se puede emplear el comando de ayuda
?ggsave

# Si se quiere pasar a PDF
file <- tempfile()
ggsave(file, device = "pdf")
unlink(file)

# Los archivos compatibles con ggsave se pueden encontrar en la saving section de su pestaña de ayuda