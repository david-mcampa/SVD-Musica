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

Se extrayeron datos de 2017 canciones con atributos como *acousticness, danceability, energy, instrumentalness, key, liveness, loudness, mode, speechiness, tempo, time_signature, valence*, estos datos fueron creados por Spotify. Con estos datos se construyó la matriz de genómica $A$, es decir, se convirtió a la matriz de los datos en una matriz binaria que solo admite los valores 0 y 1. Para determinar cuál valor debe tener cada entrada se calculó la media de cada atributo y si cada entrada en la matriz era menor a la media entonces esa entrada se cambia por un 0 y si es mayor se cambia por un 1.

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

| ![Rplot1](https://user-images.githubusercontent.com/74944322/204724338-bb29a60e-f621-467e-8383-0e52731efd52.png) |
| :--: | 
| *Espacio de Estilos* |

Así obtenemos todas las canciones en este espacio de estilos.

Ahora, podemos utilizar esta representación como ya se mencionó arriba para recomendar canciones, supongamos que tienes un gusto por la canción Can't Get Enough - Pegboard Nerds Remix, la ubicamos dentro del espacio y mediante un gradiente de color resaltamos las canciones más cercanas. La distancia es la distancia euclidiana que está dada por

$$ d = \sqrt{(x_2 - x_1)^2 + (y_2 - y_1)^2} $$

Para un par de canciones con coordenadas $(x_1, y_1)$ y $(x_2, y_2)$, entonces para Can't Get Enough - Pegboard Nerds Remix obtenemos la siguiente figura:

| ![Rplot2](https://user-images.githubusercontent.com/74944322/204742563-835ae430-ec85-4868-a400-59a585b4c9a0.png) |
| :--: | 
| *Can't Get Enough - Pegboard Nerds Remix* |

Y así podemos encontrar las 5 canciones con distancias menores, que en este caso serían

| Canción  | Artista |
| ------------- | ------------- |
| Versace Python  | Riff Raff  |
| Feel The Volume  | Jauz  |
| Made Me | Snootie Wild  |
| Glad You Came  | The Wanted  |
| Flashwind - Radio Edit  | Ben Remember  |

Y así se puede hacer con cualquier canción dentro del dataset. A continuación se muestra la gráfica para 3 canciones más y sus respectivas 5 canciones con la distancia mas corta

| Master of None - Beach House| Parallel Lines - Junior Boys | Sneakin' - Drake |
| :---:         |     :---:      |          :---: |
| ![4](https://user-images.githubusercontent.com/74944322/205169482-17cc9a1b-c242-458d-8022-a5b9b8f33661.png)    | ![5](https://user-images.githubusercontent.com/74944322/205169498-6dd3f2f5-ee67-4861-9558-5bdc443b5194.png)     | ![6](https://user-images.githubusercontent.com/74944322/205171176-c05dcee3-71fb-479b-b7e6-5e0eddfa8af5.png)    |
| L$D - A$AP Rocky                              | Queen - Perfume Genius                  | Count On You - Big Time Rush            |
| The Great Gig In The Sky - Pink Floyd         | Love Wins - Love and Theft              | Satellite - SALTNPAPER                  |
| Night on Bald Mountain - Modest Mussorgsky    | Tears - Matt Hammitt                    | Beautiful Disaster - Jon McLaughlin     |
| No Woman - Whitney                            | I Don't Love You - Urban Zakapa         | From This Moment On - Shania Twain      |  
| Where We Used To Live - Esbjörn Svensson Trio | No Le Digas Que Hacer - Karina Vismara  | Imma Ride - Young Thug                  |

Y así se podría hacer para más canciones y para bases de datos más grandes. Incluso podría hacerse el mismo análisis considerando aspectos mas técnicos de la música que puedan darnos similitudes mas precisas pues este modelo depende enteramente de los datos que se tienen y de los atributos que se analizan de la música.

### Lenguaje y Librerías Utilizadas

Para este proyecto se utlizó *R* y las librerías *ggplot2* y *tidyverse* 

## Análisis de Resultados y Conclusión

De las 4 canciones que se mostraron en este proyecto se procedió a escuchar las canciones para evaluar los resultados dados por las distancias en $U$. De las 5 más cercanas para cada canción al menos 3 parecen escucharse del mismo estilo. La razón del por qué 2 parecen ser ajenas al estilo puede ser a que se necesitan tal vez más atributos a analizar y quizá atributos más técnicos de la música como armonía, melodía, ritmo, forma y timbre. El haber obtenido al menos 3 canciones parecidas nos lleva a concluir que nuestros resultados sn satisfactorios y que podrían servir para sistemas de recomendación de canciones más robustos.

En conclusión la descomposición en valores singulares SVD de nuestra matriz genómica o matriz de atributos $A$ nos permite obtener una matriz $U$ que traslada a las canciones como puntos en $U$ a un espacio de estilos. De ahí es posible calcular distancias euclidianas para obtener que canciones son más parecidas entre sí lo que nos permite proyectar un sistema de recomendación de canciones. 

Este análisis es escalable a bases de datos mas grandes y a evaluación de distintos aspectos de la música.

## Referencias

Lay, D. C. & Murrieta, J. E. M. (2007b). Algebra Lineal Y Sus Aplicaciones. Pearson Educación.
Chen, G. (s. f.). Some notes on SVD, dimensionality reduction, and clustering.
