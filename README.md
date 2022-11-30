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

Se extrayeron datos de 2017 canciones con atributos como \textit{acousticness, danceability, energy, instrumentalness, key, liveness, loudness, mode, speechiness, tempo, time_signature, valence}, estos datos fueron creados por Spotify. Con estos datos se construyó la matriz de genómica $A$, es decir, se convirtió a la matriz de los datos en una matriz binaria que solo admite los valores 0 y 1. Para determinar cuál valor debe tener cada entrada se calculó la media de cada atributo y si cada entrada en la matriz era menor a la media entonces esa entrada se cambia por un 0 y si es mayor se cambia por un 1.

Posteriormente se le aplica SVD a esta matriz $A$ de tal manera que tenemos $A = U\Sigma V^T $. Analicemos que significan estas matrices.

La matriz $A$ tiene como renglones a cada una de las 2017 canciones y cada columna son los aributos que mencionamos, ahora, es lógico pensar que cada canción tiene un esilo musical y que cada estilo musical está asociado con sus atributos. Entonces la idea es que canciones simlares tienen estilos parecidos, para ello queremos reprsentar las canciones en el "espacio de estilos", matemáticamente queremos "partir" a la matriz $A$ enuna matriz $P$ que contenga la interacción canción-estilo y otra matriz $Q$ que contiene la interacción estilo-atributo

$$A = PQ^T$$

Y eso es lo que SVD hace

$$A = U\Sigma V^T $$

Entonces
$$U \rightarrow P$$
$$\Sigma V^T \rightarrow Q^T$$

Así cada renglón de $U$ en la descomposición de valores singulares es una canción y cada columna es el peso que cada estilo contribuye a cada canción entonces podemos usar $U$ para comparar estilos de las canciones, así, dos canciones que se encuentren cerca en el espacio de estilos son canciones que son similares y según nuestra hipótesis si una canción te gusta entonces las más cercanas a ellas es probable que sean de tu agrado.

Para graficar estas canciones en un plano solo consideramos los 2 valores singulares mas grandes. Al graficar obtenemos 

![Rplot1](https://user-images.githubusercontent.com/74944322/204724338-bb29a60e-f621-467e-8383-0e52731efd52.png)>

Así obtenemos todas las canciones en este espacio de estilos.

Ahora, podemos utilizar esta representación como ya se mencionó arriba para recomendar canciones, supongamos que tienes un gusto por la canción Can't Get Enough - Pegboard Nerds Remix, la ubicamos dentro del espacio y mediante un gradiente de color resaltamos las canciones mas cercanas

![Rplot2](https://user-images.githubusercontent.com/74944322/204742563-835ae430-ec85-4868-a400-59a585b4c9a0.png)



### Tecnologías Utilizadas

## Conclusión


## Referencias



