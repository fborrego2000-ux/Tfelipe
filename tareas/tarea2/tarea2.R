# Ejercicios de sintagma 
"Hello World!"

print("Hello World")
"Hello World"

# This is a comment
"Hello World!"

# Ejercicios de variables

carName <- "volvo"

maxSpeed <- 120 

txt <- "World!"
paste("Hello", txt)

 x <- 5
 y <- 10 
 x + y
fruit1 <- fruit2 <- fruit3 <- "orange" 

# Ejercicios de tipo de datos

# myvar <- 30 es un valor numérico

x <- 10.5
class(x)
#"numeric"

# Ejercicios de matemática

min(5,10,15)
#5

sqrt(16)
#4

# Ejercicios de hilos
str <- "Hello¡"
nchar(str)
# 6

grepl("H", str)
# TRUE

str1 <- "Hello"
str2 <- "World"
paste(str1, str2)

#ejercicios de pruebas lógicas

10 < 9
# FALSE

a <- 10
b <- 9

a > b
# TRUE

a <- 10
b <- 9

a > b
# TRUE

# Ejercicios de operadores
10 * 5

10 / 5

5 == 5
# TRUE

# Ejercicios if.. else
a <- 50
b <- 10

if (a > b) {print("Hello World")}
# "Hello World"

a <- 50
b <- 50
if(a == b) {print("Hello World")}
# "Hello World"

a <- 50
b <- 50
if (b == a) {print("yes")} else {print("no")}
# "yes"

# Ejercicios de loops

i <- 1
while (i < 6) {print(i) 
  i <- i + 1
  }

i <- 1
while (i < 6) {
  print(i)
  i <- i + 1
  if (i == 4) {
    break
  }
}

i <- 0
while (i < 6) {
  i <- i + 1
  if (i == 3) {
    next
  }
  print(i)
}

for (x in 1:10) {
  print(x)
}
# Ejercicios de funciones

my_function <- function() {
  print("Hello World!")
}

my_function()
# "Hello World!"

my_function <- function(fname) {
  paste(fname, "Griffin")
}
my_function("Peter")
# "Peter Griffin"

my_function <- function(x) {
  return (5 * x)
}
print(my_function(3))
# 15

# Ejercicios de estrucutra de datos

fruits <- c("banana", "apple", "orange")
fruits
# "banana" "apple"  "orange"

length(fruits)
# 3

thislist <- list("apple", "banana", "cherry")
thislist
# "apple", "banana" +, "cherry"

thismatrix <- matrix(c("apple", "banana", "cherry", "orange"), nrow = 2, ncol = 2)

thisarray <- c(1:24)
multiarray <- array(thisarray, dim = c(4, 3, 2))

Data_Frame <- data.frame (
  Training = c("Strength", "Stamina", "Other"),
  Pulse = c(100, 150, 120),
  Duration = c(60, 30, 45)
)

music_genre <- factor(c("Jazz", "Rock", "Classic", "Classic", "Pop", "Jazz", "Rock", "Jazz"))
