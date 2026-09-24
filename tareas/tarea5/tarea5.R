library(tidyverse)
library(tidytext)
library(janeaustenr)
library(dplyr)
library(stringr)
library(topicmodels)
library(reshape2)
library(ggplot2)
library(textdata)


# EL CORPUS ------------------------------------------------------------------

'''

Los artículos contenidos en este corpus exploran distintos desafíos y situaciones
que experimenta la llamada "generación Z" (Personas nacidas entre 1997 y 2012)
en áreas como el trabajo, la educación, la vida en sociedad, etc. Los documentos sí
puden ser comparados dado que usan la misma terminología para referirse a la generación z
y las cuestiones que atraviesa (pese a que los artículos hablan de diferentes temas).

El corpus destaca por el uso excesivo de la expresión gen z, que abrevia generación Z,
y en el énfasis de los escritores en explorar los nuevos paradigmas sociales y 
psicológicos que afectan a la juventud. El corpus también está muy ordenado en base 
a los artículos que tiene y su contenido, casi no necesita que se realicen cambios para 
leerlos en R correctamente

'''
# Antes que nada cargamos los datos del corpus como un dataset

referencias <- read_csv("DATA-T9-mckinsey-mind-the-gap-articles-20251020.csv")
referencias


# SENTIMIENTOS ------------------------------------------------------------


'''

Realizamos el análisis de sentimientos empleando diccionarios binarios y de
graduaciones

'''
# Primero ordenamos el texto de los artículos para que sea interpretable por las funciones

referencias_o <- referencias %>%
  group_by(title) %>%
  mutate(
    linenumber = row_number(),
    title = cumsum(str_detect(article_text, 
                              regex("^chapter [\\divxlc]", 
                                    ignore_case = TRUE)))) %>%
  ungroup() %>%
  unnest_tokens(word, article_text)

referencias_o
# Análisis con modelos binarios

# Sentimientos positivos

 sent_positivo <- get_sentiments("bing") |> filter(sentiment == "positive")
 
 # Sentimientos negativos
 
 sent_negativo <- get_sentiments("bing") |> filter(sentiment == "negative")

 # Ahora hacemos el recuento de las palabras positivas y negativas
 # Positivas
 
 referencias_o |> semi_join(sent_positivo) |> count(word, sort = TRUE)
 
 # Negativas
 
 referencias_o |> semi_join(sent_negativo) |> count(word, sort = TRUE)

 # Análisis de sentimientos hechos con modelos de valuación
 
 nrc_resultados <- referencias_o |> inner_join(get_sentiments("nrc"), by = "word") 
 

# TÓPICOS -----------------------------------------------------------------

 
'''
realizamos el análisis de tópicos. Antes que nada es necesario convertir el dataset
en una matriz de documentos para posteriormente buscar los tópicos
'''
'''
 Primero, buscamos en los artículos si aparecen stopwords que no
 aportan al estudio de tópicos para luego eliminarlas
'''
ref_tokens <- referencias %>%
  mutate(documento = row_number()) %>%
  unnest_tokens(palabra, article_text) %>%
  anti_join(stop_words, by = c("palabra" = "word"))

 
frecuencia_docs <- ref_tokens %>%
  distinct(documento, palabra) %>%
  count(palabra, name = "n_documentos") %>%
  mutate(
    porcentaje = n_documentos / n_distinct(ref_tokens$documento)
  ) %>%
  arrange(desc(porcentaje))

# Filtramos las palabras que se repiten un 70% o más en los artículos

palabras_repetidas <- frecuencia_docs %>%
  filter(porcentaje > 0.7) %>%
  pull(palabra)

# Creamos las referencias sin las palabras repetidas

ref_tokens_limpios <- ref_tokens %>%
  filter(!palabra %in% palabras_repetidas)

ref_dtm <- ref_tokens_limpios %>%
  count(documento, palabra) %>%
  cast_dtm(documento, palabra, n)

# Análisis de tópicos con k = 10
 
ref_lda_10 <- LDA(
   ref_dtm,
   k = 10,
   control = list(seed = 1234))
 

topicos_10 <- tidy(ref_lda_10, matrix = "beta") 
topicos_10 

#Filtramos las 10 palabras más usadas dentro de los tópicos

topicos_10_top <- topicos_10 %>%
  group_by(topic) %>%
  slice_max(beta, n = 10) %>% 
  ungroup() %>%
  arrange(topic, -beta)

# Graficamos
topicos_10_top %>%
  mutate(term = reorder_within(term, beta, topic)) %>%
  ggplot(aes(beta, term, fill = factor(topic))) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~ topic, scales = "free") +
  scale_y_reordered()
 
 
# Análisis de tópicos con k = 15

ref_lda_15 <- LDA(
  ref_dtm,
  k = 15,
  control = list(seed = 1234))


topicos_15 <- tidy(ref_lda_15, matrix = "beta") 

topicos_15 

#Filtramos las 10 palabras más usadas dentro de los tópicos
topicos_15_top <- topicos_15 %>%
  group_by(topic) %>%
  slice_max(beta, n = 10) %>% 
  ungroup() %>%
  arrange(topic, -beta)

# Graficamos
topicos_15_top %>%
  mutate(term = reorder_within(term, beta, topic)) %>%
  ggplot(aes(beta, term, fill = factor(topic))) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~ topic, scales = "free") +
  scale_y_reordered()


 
 
 
 
 