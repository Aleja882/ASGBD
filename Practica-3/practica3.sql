-- Asegurar el uso de la base de datos
USE tienda_informatica;

-- TAREA 1: Creación de usuarios y políticas de conexión y caducidad
-- 1.1. Creación de cuentas base:
CREATE USER 'gestor_tienda'@'localhost' IDENTIFIED BY 'Alejandro9.';

CREATE USER 'auditor_externo'@'%' IDENTIFIED BY 'Alejandro9.';

-- 1.2. Directiva de caducidad de credenciales:
ALTER USER 'auditor_externo'@'%' PASSWORD EXPIRE INTERVAL 30 DAY;

-- 1.3. Directiva de control de sesión:
ALTER USER 'gestor_tienda'@'localhost' PASSWORD_LOCK_TIME UNBOUNDED;
 
-- TAREA 2: Creación y asignación de roles
-- 1. Definición del rol operativo:

CREATE ROLE IF NOT EXISTS 'rol_consultor';

-- 2. Concesión de privilegios al rol:
GRANT SELECT ON tienda_informatica.* TO 'rol_consultor';

-- 3. Asignación del rol y configuración como rol por defecto:
GRANT 'rol_consultor' TO 'auditor_externo'@'%';
SET DEFAULT ROLE 'rol_consultor' FOR 'auditor_externo'@'%';


-- TAREA 3: Seguridad mediante Vistas y Privilegios Granulares
-- 1. Creación de la vista de enmascaramiento (ocultando salarios):
CREATE VIEW v_tecnicos_activos AS SELECT id_tecnico, nombre, especialidad FROM tecnicos;

-- 3.2. Privilegio granular:
GRANT SELECT ON tienda_informatica.v_tecnicos_activos TO 'gestor_tienda'@'localhost';

-- 3.3. Prueba de denegación (Documentación técnica):
Select * from tecnicos;
-- No deja ya que no tiene permisos el usuario activo

-- TAREA 4: Consistencia y control con WITH CHECK OPTION

-- 4.1. Vista con restricción de dominio (precio <= 50.00):
CREATE VIEW v_articulos_gama_baja AS
SELECT *
FROM articulos
WHERE precio <= 50.00
WITH CHECK OPTION;

-- 4.2. Demostración técnica:
INSERT INTO v_articulos_gama_baja (id, nombre, precio) VALUES (101, 'Ordenador', 750.00);
-- Como observamos al ser el articulo de mayor valor que el indicado no permite meterlo en la vista por que no pasa el filtro.
-- TAREA 5: Auditoría, Resolución de Incidencias y Reflexión Crítica
-- 5.1. Auditoría de privilegios efectivos:
SHOW GRANTS FOR 'auditor_externo'@'%';


-- 5.2. Reflexión sobre el Principio de Mínimo Privilegio:
-- Otorgar 'ALL PRIVILEGES' a usuarios finales o aplicaciones expone la base de datos a un riesgo crítico. Si la aplicación web sufre una vulnerabilidad de Inyección SQL (SQLi), un atacante podría aprovechar los permisos sobredimensionados para ejecutar comandos destructivos (DROP TABLE, DROP DATABASE), extraer tablas enteras o modificar configuraciones del sistema. Al aplicar privilegios estrictamente necesarios, se minimiza el radio de impacto de una brecha de seguridad.

-- 5.3. Análisis de comportamiento del CHECK OPTION:
-- Si se elimina la cláusula WITH CHECK OPTION, se permite la inserción de registros cuyos  valores queden fuera del filtro

