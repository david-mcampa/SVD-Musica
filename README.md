# Descomposición de Valores Singulares (SVD) para análisis de Genómica de la Música y posibles Sistemas de Recomendación de Canciones 

## Introducción 

La Genómica de la Música ha sido un esfuerzo por estudiar matemáticamente las relaciones que existen entre varias canciones. Para este proyecto se construye una matriz binaria en donde cada columna representa un atributo musical y cada renglón una canción. Así cada atributo haría referencia a un gen y su valor 0 o 1 indica que tal canción (o gen) posee esa característica (o el gen está expresado). 

Con esta matriz se puede calcular su Descomposición en Valores SIngulares (SVD) tomando los dos eigenvalores mas grandes para poder hacer un graficado que nos muestre que canciones en base a su distancia están mas relacionadas, en este caso, que canciones tienen atributos mas parecidos.

Este proyecto busca obtener tal información y sentar una forma sencilla de recomendar canciones, pues si tienes gusto por una canción en particular, es probable que una canción que tenga atributos simulares también sea de tu agrado y que por el contrario una canción completamente diferente no lo sea.

## Marco Teórico

### Descomposición en valores singulares

Sea $A$ una matriz de $m \times n$ con rango $r$. Entonces existe una matriz $\Sigma$ de $m \times n$ para la cual las entradas diagonales en $D$ son los primeros $r$ valores singulares de $A$, $\sigma_1 \geq \sigma_2 \geq \cdot \cdot \cdot \geq \sigma_r > 0$, y existen una matriz ortogonal $U$ de $m \times m$ y una matriz ortogonal $V$ de $n \times n$ tales que

$$ A =  U\Sigma V^T $$

Cualquier factorización $A =  U\sigma V^T$ con $U$ y $V$ ortogonales y entradas positivas en $D$, se llama descomposición en valores singulares de $A$. Las matrices $U$ y $V$ no están determiandas de forma única por $A$, pero las entradas diagonales en $D$ son necesariamente los valores singulares de $A$. 


## Metodología y Aplicación a la Matriz de Genómica de la Música





### Tecnologías Utilizadas

## Conclusión


## Referencias



