install.packages("edgar")
library(edgar)
library(tidyverse)
library(httr)
library(jsonlite)
library(dplyr)
library(rvest)
library(stringr)
library(rvest)

# Carga de archivos -------------------------------------------------------

#primero usamos el paquete edgar para cargar los informes anuales de YPF,
# Telecom argentina y el banco patagonia desde el año 2020 al 2025

empresas_argentinas <- tibble(
  empresa = c("YPF", "Telecom Argentina", "Banco patagonia"),
  ticker  = c("ypf", "tlc", "bcp"),
  cik     = c(0000904851, 0000932470, 0001477721)
)

ciks <- empresas_argentinas$cik

user_agent <- "Felipe f.borrego2000@gmail.com"

reportes <- getFilings(
  cik.no = ciks,
  form.type = "20-F",
  filing.year = 2020:2025,
  quarter = 1:4,
  downl.permit = "y",
  useragent = user_agent
)

glimpse(reportes)

# Ahora limpiamos el texto para su posterior analisis

getwd()

list.files(
  "edgar_Filings",
  recursive = TRUE
)


list.files(
  "edgar_Filings",
  recursive = TRUE,
  full.names = TRUE
) |> head(20)



archivos <- list.files(
  "edgar_Filings",
  recursive = TRUE,
  full.names = TRUE
)

length(archivos)
head(archivos)


extraer_texto <- function(archivo) {
  
  tryCatch({
    
    pagina <- read_html(archivo)
    
    texto <- pagina |>
      html_element("body") |>
      html_text2()
return(texto) }, error = function(e) {
     return(NA_character_)})}

textos_filings <- tibble(
  archivo = archivos
) |>
  mutate(
    texto = map_chr(archivo, extraer_texto)
  )

# Tengo problemas con la ram de mi pc que se queda corta para cargar los datos
# ¿Hay alguna manera de optimizar espacio?