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

# Expresión de Genes
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
U <- as.data.frame(U)
V <- A.svd$v
sing_val <- A.svd$d
Sigma <- sing_val * diag(length(sing_val))[,1:length(sing_val)]



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


# Esta función grafica todas las canciones pero agrega un gradiente de color
# para las cancicones mas lejanas al punto que queramos
graficado_grad <- function(punto){
  U$distancia <- dists(punto)
  ggplot(U) + geom_point(aes(x=U$V1, y=U$V2, fill=U$distancia), pch=21, size=3) +
    geom_point(aes(x=U[punto,1], y=U[punto,2]), size=3, colour="red") + 
    scale_fill_gradient(low = "cyan",high = "darkblue") +
    labs(x = "Ux", y ="Uy", 
         title = "Descomposición en Valores Singulares: Music Genomics",
         fill = "Distancia")
}

graficado()
graficado_grad(2000)






