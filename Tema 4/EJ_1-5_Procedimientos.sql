USE videojuegos;

-- Ejercicios -- 
-- Ejercicio 1. Crear un procedimiento que obtenga los videojuegos que pertenecen al género MOBA.--
DROP PROCEDURE IF EXISTS obtenerMOBA;
DELIMITER $
CREATE PROCEDURE obtenerMOBA ()
BEGIN
	SELECT nombre_juego	
    FROM juego j
    INNER JOIN genero g on g.id_genero = j.id_genero
    WHERE UPPER(nombre_genero) = 'MOBA';
END $
DELIMITER ;
-- Ejercicio 2. Crear un procedimiento que obtenga los videojuegos desarrollados por Supercell.--
DROP PROCEDURE IF EXISTS juegoSupercell;
DELIMITER $
CREATE PROCEDURE juegoSupercell ()
BEGIN
	SELECT nombre_juego	
    FROM juego j
    INNER JOIN genero g on g.id_genero = j.id_genero
    WHERE UPPER(nombre_genero) = 'MOBA';
END $
DELIMITER ;
-- Ejercicio 3. Crear un procedimiento que obtenga el nombre de los videojuegos y el género de los juegos publicados en la plataforma ‘PlayStation’--

-- Ejercicio 4. Crear un procedimiento que obtenga el número de videojuegos lanzados en el año 2022.--

-- Ejercicio 5. Crear un procedimiento que obtenga el porcentaje de videojuegos lanzados en 2022 llamando al ejercicio 4 dentro del procedimiento y utilizando el resultado que devuelve para hacer el cálculo. (Damos por hecho que cada juego solo se lanza una vez, independientemente de que se lance en tres plataformas diferentes)--
