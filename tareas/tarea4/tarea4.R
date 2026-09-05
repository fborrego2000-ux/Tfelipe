install.packages("tidyverse")
install.packages("nycflights13")
library(nycflights13)
library(tidyverse)
glimpse(flights)
?flights
# Parte 3: transformación de datos ----------------------------------------

## Ejercicios 3.2.5--------------------------------------------------------

# 1.
#Had an arrival delay of two or more hours
flights |> filter("dep_delay" >= 120)

#Flew to Houston (IAH or HOU)
flights |> filter(dest == "IAH" | dest == "HOU")

#Were operated by United, American, or Delta
flights |> filter(carrier == "DL" | carrier == "UA" | carrier=="AA")

#Departed in summer (July, August, and September)
flights |> filter(month == 7 | carrier == 8 | carrier== 9)

#Arrived more than two hours late but didn’t leave late
flights |> filter(arr_delay > 120 & dep_delay <= 0)

#Were delayed by at least an hour, but made up over 30 minutes in flight
flights |> filter(air_time  & dep_delay >= 60 )

# 2.
flights |> arrange(desc(dep_delay) & dep_time <= 9)

# 3
flights |> arrange(desc(air_time))
                   
# 4.
flights |> distinct(year == 2013, month, day)
# Según la data sí hubo vuelo en cada día del 2013

#5.
# vuelos que recorrieron la mayor distancia
flights |> arrange(desc(distance))

# vuelos que recorrieron la menor distancia
flights |> arrange((distance))

#6. El orden en el que se usan las funciones no importa si se decide usarlas en
# simultáneo, ya que si se decide usar primero filter, las filas que no cumplan con los 
# criterios establecidos quedarán eliminadas o invisibilizadas en la consulta, cosa que 
# también pasaría si primero se usara la función arrange, ya que esta solo cambia el orden de las filas,
# que luego serán filtradas por filter.

## Ejercicios 3.3.5------------------------------------------------------------

#1: En cuanto a la relación de las variables dep_time, sched_dep_time, y dep_delay, se espera 
# que dep_delay sea el resultado de la diferencia entre sched_dep_time y dep_time. Esto es así
# porque la  diferencia entre el tiempo programado de salida y el tiempo de salida da como 
# resultado el atraso o adelanto del tiempo de salida final.

#2.
#manera 1
flights |> select(dep_time, dep_delay, arr_time, arr_time)

#manera 2:
flights |> select(contains("dep"),contains("arr"))

#manera 3:
flights |> select(dep_time : arr_time)

#3. Si se especifica el nombre de una misma variable varias veces, la consulta solo
# la devolverá una vez
flights |> select(year, year, year)

#4.
variables <- c("year", "month", "day", "dep_delay", "arr_delay")


#5. Resulta sorpendente que al ejecutar la consulta, devuelve todas las columnas que
#contengan time. Para cambiar este resultado es anidando dentro de la cosnsulta select
# otra subconsulta contains que especifique el dato específico que quiero ver.
flights |> select(contains("TIME"))

#6.
flights |> rename(air_time_min = air_time)
flights |> relocate(air_time_min)

#7.
flights |> 
select(tailnum) |> 
  arrange(arr_delay)
# El error se puede dar por el tipo de comandos que se emplean en la consulta.
# El comando select intenta actuar sobre el área de las columnas de flights, mientras
# que el comando arrange intenta al mismo tiempo ordenar los valores de las filas
# sobre los datos contenidos en columnas que están siendo ignoradas por select.




# Ejercicios 3.5.7 --------------------------------------------------------

# 1.
flights |> group_by(carrier, dest) |> summarize(n())
#Ahora realizamos la consulta correspondiente

flights |> group_by(carrier, dest) |> summarize(avg_delay = mean(dep_delay, na.rm = TRUE), n = n())

#2. 
flights |> group_by(dest, flight) |> slice_max(dep_delay, n = 1) |> relocate(dest, flight)


#3.

#4
flights |> 
  group_by(dest, flight) |> 
  slice_min(arr_delay, n = -1) |>
  relocate(dest, flight)
# Ahora, al tener un n = -1, no hay cambios notables en la operatividad de la consulta,
# ya que sigue ordenando las filas por los valores más bajos de arr_delay, pero ahora muestra 
# todas las filas

#5. la función de count es, como su nombre lo sugiere, la de contar valores dados que cumplan con
# las especificaciones que se le hagan. El argumento sort lo que hace es ordenar la base de datos
# según un criterio establecido y a su vez hace que el comando count  cuente los datos que fueron
# separados dados los criterios previos

#6.
df <- tibble(
  x = 1:5,
  y = c("a", "b", "a", "a", "b"),
  z = c("K", "K", "L", "L", "K")
)

#analisis 1: lo que hará este comando es agrupar los valores según sus posiciones de fila, dado el comando
#de agrupar

df |>
  group_by(y)

#analisis 2:lo que hará el comando es agrupar nuevamente los valores, pero ahora que se usa el arrange,
#los valores se ordenan por orden alfabético.

df |>
  arrange(y)

#analisis 3: el comando agrupará los valores en base a los valores contenidos en y,luego hará un resumen
# de la media de los valores en x

df |>
  group_by(y) |>
  summarize(mean_x = mean(x))


#analisis 4: el comando agrupará los valores en base a los valores contenidos en z y en y, luego hará un resumen
# de la media de los valores en x. 

df |>
  group_by(y, z) |>
  summarize(mean_x = mean(x))

# El resultado fue n poco diferente al esperado, porque a pesar de que agrupó los valores de la manera
# prevista, estos tienen una correspondencia específica los unos a los otros. Es decir que cierto valores
# de y se asocian con ciertos valores de z.

#analisis 5:el comando agrupará los valores en base a los valores contenidos en z y en y, luego hará un resumen
# de la media de los valores en x. Ahora va a ignorar valores que se repitan dentro del esquema de z e y.

df |>
  group_by(y, z) |>
  summarize(mean_x = mean(x), .groups = "drop")

#Ambos output son iguales

#analisis 6:
#primera consulta: el comando agrupará los valores en base a los valores contenidos en z y en y, luego hará un resumen
# de la media de los valores en x.

df |>
  group_by(y, z) |>
  summarize(mean_x = mean(x))

#segunda consulta: el comando agrupará los valores en base a los valores contenidos en z y en y, luego
# creará una nueva columna que contenga los valores medios de x.

df |>
  group_by(y, z) |>
  mutate(mean_x = mean(x))


# Parte 19: joins ---------------------------------------------------------

## Ejercicios 19.2.4-------------------------------------------------------

#1. la relación entre weather y airport está en el conjunto de datos de destination
# ya que no sólo importa el clima del aeropuerto de salida, sino también el de destino
# en el diagrama, parte de airport, la variable dest sirve como clave foránea; mientras
# que en la rama de weather esta será una rama primaria

# 2.Ahora con los datos de todos los aeropuertos, la relación entre airport y weather también se dará
# por medio de la variable dest

# 3.


# 4. Para representar los días festivos se podría crear un data frame "season", donde las variables
# de esta estén en formato de texto e indiquen si la fecha corresponde a una semana festiva o no
# (ej. navidad, año nuevo, día de gracias, día de san patricio, etc.). La clave primaria o las claves primarias
# corresponderían a las variables month y day.


#5.

install.packages("Lahman")
library(Lahman)

ggplot()


# Ejrcicios 19.3.4 --------------------------------------------------------

# No pude hacer los ejercicios de esta parte. No se me ocurre cómo hacerlos
