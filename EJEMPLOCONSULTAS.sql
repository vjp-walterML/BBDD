-- BASE DE DATOS EJEMPLOCONSULTAS
-- 1º DAW
-- 19-01-2023
-- WALTER MARTIN LOPES
-- -------------------------------------------------------
CREATE DATABASE EJEMPLOCONSULTAS;
USE EJEMPLOCONSULTAS;

-- CREAMOS TABLA ALUMNO
CREATE TABLE ALUMNO(
ID INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
NOMBRE VARCHAR(100) NOT NULL,
APELLIDO1 VARCHAR(100) NOT NULL,
APELLIDO2 VARCHAR(100),
FECHA_NACIMIENTO DATE NOT NULL,
ES_REPETIDOR ENUM('sí', 'no') NOT NULL,
TELEFONO VARCHAR(9));

INSERT INTO ALUMNO VALUES (1, 'María', 'Sánchez', 'Pérez', '1990/12/01', 'no', NULL),
(2, 'Juan', 'Sáez', 'Vega', '1998/04/02', 'no', 618253876),
(3, 'Pepe', 'Ramírez', 'Gea', '1988/01/03', 'no', NULL),
(4, 'Lucía', 'Sánchez', 'Ortega', '1993/06/13', 'sí', 678516294),
(5, 'Paco', 'Martínez', 'López', '1995/11/24', 'no', 692735409),
(6, 'Irene', 'Gutiérrez', 'Sánchez', '1991/03/28', 'sí', NULL),
(7, 'Cristina', 'Fernández', 'Ramírez', '1996/09/17', 'no', 628349590),
(8, 'Antonio', 'Carretero', 'Ortega', '1994/05/20', 'sí', 612345633),
(9, 'Manuel', 'Domínguez', 'Hernández', '1999/07/08', 'no', NULL),
(10, 'Daniel', 'Moreno', 'Ruiz', '1998/02/03', 'no', NULL);

SELECT * FROM ALUMNO;

SELECT APELLIDO1 AS 'PRIMER APELLIDO',APELLIDO2,NOMBRE
FROM ALUMNO;

SELECT * FROM ALUMNO
WHERE ES_REPETIDOR='SI'
AND APELLIDO1='SÁNCHEZ'
AND FECHA_NACIMIENTO<'1990-01-01';

SELECT APELLIDO1, APELLIDO2, NOMBRE, ES_REPETIDOR
FROM ALUMNO
WHERE (NOMBRE='MANUEL' OR NOMBRE='MARIA')
AND ES_REPETIDOR='NO';

SELECT * FROM ALUMNO
WHERE FECHA_NACIMIENTO BETWEEN '1990-01-01' AND '1995-12-31';

SELECT * FROM ALUMNO
WHERE FECHA_NACIMIENTO NOT BETWEEN '1990-01-01' AND '1995-12-31';

SELECT * FROM ALUMNO
WHERE FECHA_NACIMIENTO >= '1990-01-01' AND FECHA_NACIMIENTO <='1995-12-31';

SELECT NOMBRE, APELLIDO1,APELLIDO2
FROM ALUMNO
WHERE NOMBRE IN('MARIA','PACO','ANTONIO');

SELECT NOMBRE, APELLIDO1,APELLIDO2
FROM ALUMNO
WHERE NOMBRE NOT IN('MARIA','PACO','ANTONIO');

SELECT NOMBRE, APELLIDO1,APELLIDO2
FROM ALUMNO
WHERE APELLIDO1 LIKE '%Z';

SELECT NOMBRE, APELLIDO1,APELLIDO2
FROM ALUMNO
WHERE APELLIDO1 LIKE 'S%Z';

SELECT NOMBRE, APELLIDO1,APELLIDO2
FROM ALUMNO
WHERE NOMBRE LIKE '____';

SELECT NOMBRE, APELLIDO1,APELLIDO2 , TELEFONO
FROM ALUMNO
WHERE TELEFONO IS NULL;

SELECT NOMBRE, APELLIDO1,APELLIDO2 , TELEFONO
FROM ALUMNO
WHERE TELEFONO IS NOT NULL;

-- ------------------- ESTAS CONSULTAS SON IGUALES
SELECT NOMBRE, APELLIDO1,APELLIDO2 , TELEFONO
FROM ALUMNO
ORDER BY APELLIDO1, NOMBRE DESC;

SELECT NOMBRE, APELLIDO1,APELLIDO2 , TELEFONO
FROM ALUMNO
ORDER BY 2, 1 DESC;
-- --------------- UNA POR NOMBRE DE CAMPO Y OTRA POR ORDEN DEL CAMPO

SELECT NOMBRE, APELLIDO1,APELLIDO2 , TELEFONO
FROM ALUMNO
ORDER BY 2, 1 DESC
LIMIT 2,2;

-- EL PRIMER NUMERO DEL LIMIT LIMITA EL NUMERO DE REGISTROS MOSTRADOS Y EL SEGUNDO NUMERO 
-- LIMITA DESDE QUE POSICION EMPIEZA A MOSTRAR

