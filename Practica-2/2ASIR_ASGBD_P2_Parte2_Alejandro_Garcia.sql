##2ASIR_ASGBD_P2_Parte2_Alejandro_Garcia## 

Batería de Consultas 1:

1. Muestra el nombre y el precio de aquellos artículos que sean, exactamente, el
artículo más caro de su respectivo fabricante.

SELECT nombre, precio 
FROM articulos a1
WHERE precio = (
	SELECT MAX(precio)
	FROM articulos a2
	WHERE a2.fabricante_id = a1.fabricante_id)

--> Cual quiera de las dos que pongo aqui funciona<--

SELECT nombre, precio 
FROM articulos
WHERE precio IN (
	SELECT MAX(precio)
	FROM articulos 
    GROUP BY fabricante_id)
	

	
2. Muestra el nombre de los fabricantes que no tienen ningún artículo con un precio
inferior o igual a la media general de precios de toda la tienda.

SELECT nombre
FROM fabricantes 
WHERE id IN (
	SELECT fabricante_id 
	FROM articulos
	WHERE precio > (
		SELECT AVG (precio)
        FROM articulos))

3. Muestra la descripción y el coste de aquellas reparaciones cuyo coste sea
estrictamente superior a la media de las reparaciones realizadas por su propio
técnico.

SELECT descripcion_averia, coste_reparacion
FROM reparaciones r1
WHERE coste_reparacion > (
	SELECT AVG(coste_reparacion)
	FROM reparaciones r2 
	WHERE r2.tecnico_id = r1.tecnico_id)

4. Muestra el identificador y la especialidad de los técnicos cuya suma total del coste de
las reparaciones que han realizado supere el doble de su propio salario.


SELECT id, especialidad
FROM tecnicos t
WHERE (salario * 2) < (
	SELECT SUM(coste_reparacion)
    FROM reparaciones r
    WHERE t.id = r.tecnico_id
    GROUP BY tecnico_id)

5. Muestra el nombre del fabricante (o fabricantes) que posee el mayor número de
artículos registrados en la base de datos.

6. Muestra el nombre de los técnicos que han realizado alguna reparación, pero que
nunca han realizado ninguna reparación cuyo coste haya superado los 100.00 euros.2

SELECT nombre
FROM tecnicos
WHERE id NOT in (SELECT tecnico_id 
				FROM reparaciones
				WHERE coste_reparacion > 100.00
				group by tecnico_id)

Administración de Sistemas Gestores de Bases de Datos
7. Muestra el nombre y el salario de los técnicos cuyo salario sea inferior a la media
salarial de su propia especialidad.
8. Muestra el nombre de los fabricantes cuyo país coincide con el país del fabricante
que produce el artículo más caro de toda la tienda.
9. Muestra el nombre y el precio del artículo más barato de entre todos los fabricantes
que son originarios de 'Estados Unidos'.
10. Muestra el identificador del técnico (tecnico_id) que ha acumulado el mayor
coste total en reparaciones.


Batería de Consultas 2:

1. Muestra el nombre de cada artículo junto con el nombre de su fabricante, pero
únicamente para aquellos artículos cuyo precio sea superior a 100.00 euros.

SELECT a.nombre, f.nombre 
FROM articulos a 
INNER JOIN fabricantes f on a.fabricante_id = f.id
WHERE a.precio > 100.00;

2. Muestra el nombre de todos los fabricantes de la base de datos y, al lado, el nombre
de sus artículos. Asegúrate de que aparezcan los fabricantes que no tienen ningún
artículo registrado.

SELECT a.nombre, f.nombre 
FROM fabricantes f  
INNER JOIN articulos a ON f.id = a.fabricante_id

3. Muestra el nombre del fabricante y la media de los precios de sus artículos, pero solo
para aquellos fabricantes cuya media de precios supere los 150.00 euros.

SELECT f.nombre, AVG(a.precio)
FROM fabricantes f 
INNER JOIN articulos a ON f.id = a.fabricante_id
HAVING AVG(a.precio) > 150.00 

4. Muestra la descripción de la avería, el coste de la reparación y el nombre del técnico
que la ha llevado a cabo, ordenado por el coste de mayor a menor.

SELECT r.descripcion_averia, r.coste_reparacion, t.nombre
FROM reparaciones r 
INNER JOIN tecnicos t ON t.id = r.tecnico_id
ORDER BY r.coste_reparacion DESC

5. Muestra el nombre de aquellos técnicos que no han realizado ninguna reparación,
utilizando obligatoriamente un cruce externo de tablas.

SELECT t.nombre
FROM tecnicos t 
INNER JOIN reparaciones r ON t.id = r.tecnico_id				
WHERE r.id IS NULL 

6. Muestra el nombre del técnico y la suma total del dinero recaudado con sus
reparaciones, filtrando únicamente aquellos técnicos cuya recaudación total supere
los 100.00 euros.

SELECT t.nombre, SUM(r.coste_reparacion)
FROM tecnicos t
INNER JOIN reparaciones r ON r.tecnico_id = t.id
HAVING SUM(r.coste_reparacion) > 100.00 

7. Muestra el nombre de los artículos y el nombre de su respectivo fabricante, pero
filtrando exclusivamente aquellos artículos cuyos fabricantes sean originarios de
'Estados Unidos' o 'Taiwán' .

SELECT a.nombre, f.nombre
FROM articulos a 
INNER JOIN fabricantes f ON f.id = a.fabricante_id
WHERE f.pais IN ('Estados Unidos', 'Taiwán') 

8. Muestra el nombre de todos los técnicos y, al lado, el número total de reparaciones
que ha realizado cada uno de ellos.

SELECT t.nombre, SUM(r.id)
FROM tecnicos t 
INNER JOIN reparaciones r ON r.tecnico_id = t.id
GROUP BY t.id, t.nombre 

9. Muestra el nombre del fabricante y el número total de artículos que produce, pero
solo de aquellos fabricantes que tengan un número de artículos mayor o igual a 2.

SELECT f.nombre, COUNT(a.id) 
FROM fabricantes f 
INNER JOIN articulos a ON f.id = a.fabricante_id 
GROUP BY f.id, f.nombre 
HAVING COUNT(a.id) >= 2;

10. Muestra el nombre del técnico, su especialidad y la descripción de la reparación más
costosa que ha realizado cada uno de ellos.

SELECT t.nombre, t.especialidad, r.descripcion_averia 
FROM tecnicos t 
INNER JOIN reparaciones r ON t.id = r.tecnico_id 
WHERE r.coste_reparacion = (
    SELECT MAX(r2.coste_reparacion) 
    FROM reparaciones r2 
    WHERE r2.tecnico_id = t.id)
