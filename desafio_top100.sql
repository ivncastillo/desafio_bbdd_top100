------------------------------------
--------- DESAFIO TOP 100 ----------
------------------------------------

--1. Crear base de datos llamada películas (1 punto)
CREATE DATABASE peliculas;

--2. Revisar los archivos peliculas.csv y reparto.csv para crear las tablas correspondientes,determinando la relación entre ambas tablas. (2 puntos)
CREATE TABLE peliculas(
id INT
,pelicula VARCHAR(255)
,ano_estreno SMALLINT
,director VARCHAR(255)
, PRIMARY KEY (id)
);

CREATE TABLE reparto(
id INT
, actor VARCHAR(255)
, FOREIGN KEY (id) REFERENCES
peliculas(id)
);

--3. Cargar ambos archivos a su tabla correspondiente (1 punto)
\copy peliculas FROM 'C:\Users\icasl\OneDrive\DesafioLatam\desafio_bbdd\desafio_top100/peliculas.csv' csv header;
\copy reparto FROM 'C:\Users\icasl\OneDrive\DesafioLatam\desafio_bbdd\desafio_top100/reparto.csv' csv header;

--4. Listar todos los actores que aparecen en la película "Titanic", indicando el título de la película,año de estreno, director y todo el reparto. (0.5 puntos)
SELECT a.pelicula
, a.ano_estreno
, a.director
, b.actor
FROM peliculas a
INNER JOIN reparto b on a.id=b.id
WHERE a.pelicula='Titanic'
;
   
--5. Listar los titulos de las películas donde actúe Harrison Ford.(0.5 puntos)
SELECT a.pelicula
FROM peliculas a
INNER JOIN reparto b on a.id=b.id
WHERE b.actor='Harrison Ford'
;

--6. Listar los 10 directores mas populares, indicando su nombre y cuántas películas aparecen en eltop 100.(1 puntos)
SELECT a.director
, count(a.id) as n_peliculas
FROM peliculas a
GROUP BY a.director 
ORDER BY count(a.id) desc
LIMIT 10
;

--7. Indicar cuantos actores distintos hay (1 puntos)
SELECT count(distinct a.actor) as n_actores
FROM reparto a
;

--8. Indicar las películas estrenadas entre los años 1990 y 1999 (ambos incluidos) ordenadas portítulo de manera ascendente.(1 punto)
SELECT a.pelicula
, ano_estreno
FROM peliculas a
WHERE a.ano_estreno between 1990 and 1999
ORDER BY a.pelicula ASC
;
--9. Listar el reparto de las películas lanzadas el año 2001 (1 punto)
SELECT a.pelicula
, a.ano_estreno
, b.actor
FROM peliculas a
LEFT JOIN reparto b on a.id=b.id
WHERE a.ano_estreno=2001
;

--10. Listar los actores de la película más nueva (1 punto)
SELECT a.pelicula
, ano_estreno
, b.actor
FROM peliculas a
LEFT JOIN reparto b on a.id=b.id
WHERE a.ano_estreno=(select Max(ano_estreno) from peliculas)
;
