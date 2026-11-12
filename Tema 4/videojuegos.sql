DROP DATABASE IF EXISTS videojuegos;
CREATE DATABASE videojuegos;
USE videojuegos;

CREATE TABLE genero (
    id_genero INT PRIMARY KEY,
    nombre_genero VARCHAR(50)    
);

CREATE TABLE plataforma (
    id_plataforma INT PRIMARY KEY,
    nombre_plataforma VARCHAR(50)
); 

CREATE TABLE desarrollador (
    id_desarrollador INT PRIMARY KEY,
    nombre_desarrollador VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE juego (
    id_juego INT  PRIMARY KEY,
    id_genero INT,
    nombre_juego VARCHAR(100),
    FOREIGN KEY (id_genero) REFERENCES genero(id_genero)
);


CREATE TABLE desarrollador_juego (
    id_des_juego INT PRIMARY KEY,
    id_juego INT,
    id_desarrollador INT,
    FOREIGN KEY (id_juego) REFERENCES juego(id_juego),
	FOREIGN KEY (id_desarrollador) REFERENCES desarrollador(id_desarrollador)

);

CREATE TABLE plataforma_juego (
    id_plat_juego INT PRIMARY KEY,
    id_desarrollador_juego INT,
    id_plataforma INT,
    anio_lanzamiento INT,
	FOREIGN KEY (id_desarrollador_juego) REFERENCES desarrollador_juego(id_des_juego),
	FOREIGN KEY (id_plataforma) REFERENCES plataforma(id_plataforma)

);

INSERT INTO `genero` VALUES (1,'Estrategia'),(2,'MOBA'),(3,'ARPG'),(4,'Mundo abierto');

INSERT INTO `desarrollador` VALUES 
	(1,'Blizzard'),(2,'Supercell'),(3,'Riot Games'),(4,'FromSoftware'),(5, 'Guerrilla Games'), (6, 'Nintendo EPD'), (7, 'Monolith Soft');


INSERT INTO `plataforma` VALUES 
	(1, 'PC'), (2, 'PlayStation'), (3, 'Xbox'), (4, 'Mobile'), (5, 'Nintendo');


INSERT INTO `juego` VALUES 
	(1,1, 'Hearthstone'),(2,1,'Clash Royale'),
	(3,2, 'League of Legends'),(4,2,'Brawl Stars'),
    (5,3, 'Elden Ring'),(6,3,'Sekiro: Shadows Die Twice'),
    (7,4, 'Horizon Forbidden West'),(8,4,'The legend of Zelda: Breath of the wild');




INSERT INTO `desarrollador_juego` VALUES 
	(1, 1, 1), (2, 2, 2), (3, 3, 3), (4, 4, 2), (5, 5, 4), (6, 6, 4), (7, 7, 5), (8, 8, 6);




INSERT INTO `plataforma_juego` VALUES 
	(1, 1, 1, 2014), (2, 1, 4, 2015), (3, 2, 4, 2016), (4, 3, 1, 2009),
    (5, 4, 4, 2017), (6, 5, 3, 2022), (7, 5, 1, 2022), (8, 5, 2, 2022),
    (9, 6, 3, 2019), (10, 6, 1, 2019), (11, 6, 2, 2019),
    (12, 7, 2, 2022), (13, 8, 5, 2017);
    

