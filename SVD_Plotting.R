
# Instalamos y cargamos librerias
install.packages("tidyverse")
library(tidyverse)
library(ggplot2)

# Cargamos los Datos
data <- read.csv("data.csv")

# Escogemos los atributos que vamos a usar para hacer los cálculos
atributos <- data[, c("acousticness", "danceability", "energy", 
                      "instrumentalness", "key", "liveness",
                      "loudness", "mode", "speechiness", "tempo", 
                      "time_signature", "valence")]

# Calculamos las Medias de Cada Atributo de las Canciones
medias <- c()
for( i in 1:12){
  medias[i] <- mean(atributos[,i])
}

# Expresión de Genes: Si attr < media -> attr = 0, attr > media -> attr = 1
for(i in 1:12){
  for(j in 1:2017){
    if(atributos[j,i] < medias[i]){
      atributos[j,i] <- 0
    }else{
      atributos[j,i] <- 1
    }
  }
}

# Descomposición por Valores Singulares
atributos <- head(atributos, 2017)
A <- as.matrix(atributos)
A.svd <- svd(A, nu=2)
U <- A.svd$u            
U <- as.data.frame(U)   # Convertimos en dataframe
V <- A.svd$v
sing_val <- A.svd$d     # Valores singulares
Sigma <- sing_val * diag(length(sing_val))[,1:length(sing_val)] # Matriz Sigma



# Calculamos Distancias Euclidianas respescto a un punto i
euc.dist <- function(i, j) sqrt((U[i,1]-U[j,1])^2 + (U[i,2]-U[j,2])^2)
# Almacenamos las distancias de ese punto i con respecto a todos los demas 
dists <- function(i){
  distancias <- c()
  for(k in 1:nrow(atributos)){
    distancias[k] <- euc.dist(i,k)
  }
  return(distancias)
}


# Función de Graficado Simple para observar la cercanía de todas las canciones
graficado <- function(){
  ggplot(U) + geom_point(aes(x=U$V1, y=U$V2), pch=19, size=3) +
    labs(x = "Ux", y ="Uy", title = "Descomposición en Valores Singulares: Music Genomics")
}



# Función para agregar la columna de distanicas a U
dist_punto <- function(punto){
  U$distancia <- dists(punto)
  return(U)
}


# Esta función grafica todas las canciones pero agrega un gradiente de color
# para las cancicones mas lejanas al punto que queramos
graficado_grad <- function(U, punto){
  ggplot(U) + geom_point(aes(x=U$V1, y=U$V2, fill=U$distancia), pch=21, size=3) +
    geom_point(aes(x=U[punto,1], y=U[punto,2]), size=3, colour="red") + 
    scale_fill_gradient(low = "cyan",high = "darkblue") +
    labs(x = "Ux", y ="Uy", 
         title = "Descomposición en Valores Singulares: Music Genomics",
         fill = "Distancia")
}

# Graficamos
graficado()
U <- dist_punto(4)      # Aqui calculamos respecto a la cancion 5 del archivo data.csv      
graficado_grad(U, 4)    # Para calcular respecto a otra cancion se cambia el 5 por otro numero de 1 a 2017

# Ahora encontramos las 5 canciones mas cercanas a una, para ello agregamos la columna del nombre
# a nuestra matriz U
Sim <- cbind(U, data$song_title, data$artist)
canciones_similares <- head(Sim[order(U$distancia),], 6) # 6 porque esta incluida la misma canción
data.frame(canciones_similares$`data$song_title`, canciones_similares$`data$artist`)  # Mostramos las canciones







