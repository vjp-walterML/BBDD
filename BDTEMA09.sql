-- BASE DE DATOS BDTEMA09
-- 1ºDAW
-- 18-04-2023
-- WALTER MARTIN LOPES
-- --------------------------------
CREATE DATABASE BDTEMA09;
USE BDTEMA09;

-- 1. Crea un procedimiento almacenado que reciba como parámetros dos números enteros A y B y compruebe si A es divisible por B (utiliza la función MOD(), que devuelve el resto de la división entre dos números.
DELIMITER //
DROP PROCEDURE IF EXISTS PROCEDIMIENTO1
 //CREATE PROCEDURE PROCEDIMIENTO1(P1 INT, P2 INT)
 BEGIN
 IF MOD(P1,P2) = 0 THEN SELECT 'ES DIVISIBLE' AS RESULTADO;
 ELSE SELECT 'NO ES DIVISIBLE' AS RESULTADO;
 END IF;
 END; //
DELIMITER ;

CALL PROCEDIMIENTO1(4,2);

-- 2. Crea un procedimiento almacenado que al pasarle un número por parámetro, devuelve el día de la semana: si le pasamos el 1, mostrará lunes, si le pasamos el 2, martes, etc. Utiliza instrucciones condicionales.
DELIMITER //
DROP PROCEDURE IF EXISTS PROCEDIMIENTO2
//CREATE PROCEDURE PROCEDIMIENTO2(P1 INT)
BEGIN
CASE P1
WHEN 1 THEN SELECT 'LUNES' AS RESULTADO;
WHEN 2 THEN SELECT 'MARTES' AS RESULTADO;
WHEN 3 THEN SELECT 'MIERCOLES' AS RESULTADO;
WHEN 4 THEN SELECT 'JUEVES' AS RESULTADO;
WHEN 5 THEN SELECT 'VIERNES' AS RESULTADO;
WHEN 6 THEN SELECT 'SÁBADO' AS RESULTADO;
WHEN 7 THEN SELECT 'DOMINGO' AS RESULTADO;
ELSE SELECT 'ERROR: INTRODUCE UN DÍA VÁLIDO' AS RESULTADO;
END CASE;
END; //
DELIMITER ;

CALL PROCEDIMIENTO2(10);

-- 3. Crea un procedimiento que muestre la suma de los primeros n números enteros, siendo n un parámetro de entrada. Utiliza instrucciones repetitivas.
DELIMITER //
DROP PROCEDURE IF EXISTS PROCEDIMIENTO3
//CREATE PROCEDURE PROCEDIMIENTO3(P1 INT)
BEGIN
	DECLARE I INT DEFAULT 1;
	DECLARE SUMA INT DEFAULT 0;
    WHILE I<=P1 DO
		SET SUMA = SUMA + I;
        SET I = I+1;
	END WHILE;
    SELECT SUMA AS RESULTADO;
END; //
DELIMITER ;

CALL PROCEDIMIENTO3(5);

-- 4. Crea un procedimiento que muestre dos cadenas pasadas como parámetros concatenadas.
DELIMITER //
DROP PROCEDURE IF EXISTS PROCEDIMIENTO4
//CREATE PROCEDURE PROCEDIMIENTO4(C1 VARCHAR(50), C2 VARCHAR(50))
BEGIN
SELECT CONCAT_WS(' ',C1,C2) AS RESULTADO;
END;//
DELIMITER ;

CALL PROCEDIMIENTO4('HOLA','QUE TAL');

-- 5. Escribe un procedimiento que reciba un número real de entrada y muestre un mensaje indicando si el número es positivo, negativo o cero.
DELIMITER //
DROP PROCEDURE IF EXISTS PROCEDIMIENTO5
//CREATE PROCEDURE PROCEDIMIENTO5(P1 INT)
BEGIN
IF P1>0 THEN
SELECT 'ES UN NÚMERO POSITIVO' AS RESULTADO;
ELSEIF P1 = 0 THEN 
SELECT 'ES UN CERO' AS RESULTADO;
ELSE SELECT 'ES UN NÚMERO NEGATIVO' AS RESULTADO;
END IF;
END;//
DELIMITER ;

CALL PROCEDIMIENTO5(-1);

-- 6. Modifica el procedimiento del ejercicio anterior para que tenga un parámetro de entrada (IN) con el valor de un número real (FLOAT), y un parámetro de salida (OUT) de tipo cadena de caracteres. Este parámetro indica en letras si el número es positivo, negativo o cero.
DELIMITER //
DROP PROCEDURE IF EXISTS PROCEDIMIENTO6
//CREATE PROCEDURE PROCEDIMIENTO6(IN P1 INT, OUT RESULTADO VARCHAR(50))
BEGIN
IF P1>0 THEN
SET RESULTADO = 'ES UN NÚMERO POSITIVO';
ELSEIF P1 = 0 THEN 
SET RESULTADO = 'ES UN CERO';
ELSE SET RESULTADO = 'ES UN NÚMERO NEGATIVO';
END IF;
END;//
DELIMITER ;

CALL PROCEDIMIENTO6(10,@RESULTADO);
SELECT @RESULTADO;

-- 7. Escribe un procedimiento que reciba un número real de entrada, que representa el valor de la nota de un alumno, y muestre un mensaje indicando qué nota ha obtenido teniendo en cuenta las siguientes condiciones: Utiliza estructuras condicionales
-- ● De 0 a 5 = Insuficiente
-- ● 5 = Aprobado
-- ● 6 = Bien
-- ● 7, 8 = Notable
-- ● 9, 10 = Sobresaliente
-- ● En cualquier otro caso la nota no será válida.
DELIMITER //
DROP PROCEDURE IF EXISTS PROCEDIMIENTO7;
// CREATE PROCEDURE PROCEDIMIENTO7(NOTA FLOAT)
BEGIN
	IF nota >= 0 AND nota < 5 THEN
        SELECT 'Suspenso' AS RESULTADO;
    ELSEIF nota = 5 THEN 
        SELECT 'Suficiente' AS RESULTADO;
    ELSEIF nota = 6 THEN 
        SELECT 'Bien' AS RESULTADO;
    ELSEIF nota = 7 OR nota = 8 THEN 
        SELECT 'Notable' AS RESULTADO;
    ELSEIF nota = 9 OR nota = 10 THEN 
        SELECT 'Sobresaliente' AS RESULTADO;
    ELSE 
        SELECT 'Nota no válida' AS RESULTADO;
    END IF;
END;//
DELIMITER ;

CALL PROCEDIMIENTO7(10);

-- ==========================================================================
-- =====================FUNCIONES SENCILLAS SEGÚN PUERTO=====================
-- ==========================================================================
-- 1. Utilizando la BD VIDEOTECA, crear una función que recibe como parámetro una cadena de caracteres y devuelve el nº de actores cuyo nombre o apellidos coinciden con la cadena que le hemos pasado. La función retorna un número entero.
USE VIDEOTECA;
DELIMITER //
DROP FUNCTION IF EXISTS FUNCION1;
// CREATE FUNCTION FUNCION1(CADENA VARCHAR(30)) RETURNS INT
DETERMINISTIC
BEGIN
	DECLARE NUMERO_ACTORES INT;
    SELECT COUNT(*) INTO NUMERO_ACTORES FROM ACTOR
    WHERE NOMBRE LIKE CONCAT(CADENA,'%')
    OR APELLIDOS LIKE CONCAT(CADENA,'%');
    
    RETURN NUMERO_ACTORES;
END;//
DELIMITER ;

SELECT FUNCION1('CRO') AS RESULTADO;
USE BDTEMA09;

-- 2. Crear una función TIPO_SUELDO que recibe un número entero como parámetro y en función del valor de ese parámetro devuelve un mensaje:
-- Si sueldo<=1500 entonces devuelve el mensaje "BAJO"
-- Si sueldo >1500 Y <2500 entonces devuelve el mensaje "MEDIO"
-- Si sueldo >=2500 entonces devuelve el mensaje "ALTO"
DELIMITER //
DROP FUNCTION IF EXISTS FUNCION2_TIPO_SUELDO;
// CREATE FUNCTION FUNCION2_TIPO_SUELDO(SUELDO INT) RETURNS VARCHAR(10)
DETERMINISTIC
BEGIN
	DECLARE BAJO VARCHAR(10);
    DECLARE MEDIO VARCHAR(10);
    DECLARE ALTO VARCHAR(10);
    
    SET BAJO = 'BAJO';
    SET MEDIO = 'MEDIO';
    SET ALTO = 'ALTO';
    
    IF SUELDO <=1500 THEN RETURN BAJO;
    ELSEIF SUELDO > 1500 AND SUELDO < 2500 THEN RETURN MEDIO;
    ELSEIF SUELDO >=2500 THEN RETURN ALTO;
    END IF;
    
END;//
DELIMITER ;

SELECT FUNCION2_TIPO_SUELDO(2500) AS RESULTADO;

-- 3. Crear una función que calcule el factorial de un número que le pasamos por parámetro.
DELIMITER //
DROP FUNCTION IF EXISTS FUNCION3;
// CREATE FUNCTION FUNCION3(NUMERO INT) RETURNS INT
DETERMINISTIC
BEGIN
	DECLARE FACTORIAL INT;
    DECLARE CONTADOR INT;
    
    SET CONTADOR = 1;
    SET FACTORIAL = 1;
    
    WHILE CONTADOR < NUMERO DO
		SET FACTORIAL = FACTORIAL * (CONTADOR + 1);
        SET CONTADOR = CONTADOR + 1;
	END WHILE;
    
    RETURN FACTORIAL;
END;//
DELIMITER ;

SELECT FUNCION3(5) AS FACTORIAL;

-- 4. Crear una función que determine si una cadena de longitud 1 que pasamos por parámetro es o no vocal. Utiliza REGEXP (expresión regular) para crear un patrón de búsqueda para todas las vocales. (Las expresiones regulares sirven para la búsqueda de datos que coinciden con criterios complejos. REGEXP siempre devuelve 0 si no hay coincidencia con el patrón y 1 si hay coincidencia).
DELIMITER //
DROP FUNCTION IF EXISTS FUNCION4;
//CREATE FUNCTION FUNCION4(LETRA CHAR) RETURNS VARCHAR(50)
DETERMINISTIC
BEGIN
	DECLARE ESVOCAL VARCHAR(50);
    DECLARE NOESVOCAL VARCHAR(50);
    DECLARE PATRON VARCHAR(30);
    
    SET ESVOCAL = CONCAT('LA LETRA ',LETRA,' ES UNA VOCAL.');
    SET NOESVOCAL = CONCAT('LA LETRA ',LETRA,' NO ES UNA VOCAL.');
    SET PATRON = '[AEIOUaeiou]';
    
    IF LETRA RLIKE PATRON = 1 THEN RETURN ESVOCAL;
    ELSE RETURN NOESVOCAL;
    END IF;
END;//
DELIMITER ;

SELECT FUNCION4('W') AS RESULTADO;

DELIMITER //
DROP FUNCTION IF EXISTS ESVOCAL;
//CREATE FUNCTION ESVOCAL(LETRA CHAR) RETURNS INT 
DETERMINISTIC
BEGIN
    DECLARE PATRON VARCHAR(30);
    SET PATRON = '[AEIOUaeiou]';
    
    IF LETRA RLIKE PATRON = 1 THEN RETURN 1;
    ELSE RETURN 0;
    END IF;
END;//
DELIMITER ;

SELECT ESVOCAL('A') AS RESULTADO;

-- 5. Crear una función que cuente las vocales de una cadena utilizando la función esvocal que se creó en el ejercicio anterior.
DELIMITER //
DROP FUNCTION IF EXISTS FUNCION5;
//CREATE FUNCTION FUNCION5(CADENA VARCHAR(50)) RETURNS INT
DETERMINISTIC
BEGIN 
	DECLARE NUMERO_VOCALES INT;
    DECLARE CONTADOR INT;
    SET NUMERO_VOCALES = 0;
    SET CONTADOR = 0;
    
    WHILE CONTADOR <= LENGTH(CADENA) DO
		IF ESVOCAL(SUBSTRING(CADENA,CONTADOR,1)) = 1 THEN
        SET NUMERO_VOCALES = NUMERO_VOCALES + 1;
        END IF;
        SET CONTADOR = CONTADOR +1;
	END WHILE;
    
    RETURN NUMERO_VOCALES;
END; //
DELIMITER ;

SELECT FUNCION5('ESTO ES UNA PRUEBA') AS NUMERO_VOCALES;

-- 6. Crear una función que tome una cadena como parámetro y devuelva otra cadena donde las vocales aparezcan en mayúsculas y el resto en minúsculas. Utiliza la función esvocal. Por ejemplo, si le pasamos la cadena ‘holamundo’, devuelve:
DELIMITER //
DROP FUNCTION IF EXISTS FUNCION6;
//CREATE FUNCTION FUNCION6(CADENA VARCHAR(50)) RETURNS VARCHAR(50)
DETERMINISTIC
BEGIN
	 DECLARE CONTADOR INT;
     DECLARE LETRA CHAR;
     DECLARE CADENA_TRANSFORMADA VARCHAR(50);
     SET CONTADOR = 0;
     SET CADENA_TRANSFORMADA = '';
     
     WHILE CONTADOR <= LENGTH(CADENA) DO
		IF ESVOCAL(SUBSTRING(CADENA,CONTADOR,1)) = 1 THEN
			SET LETRA = UPPER(SUBSTRING(CADENA,CONTADOR,1));
            SET CADENA_TRANSFORMADA = CONCAT(CADENA_TRANSFORMADA,LETRA);
		ELSE
			SET CADENA_TRANSFORMADA = CONCAT(CADENA_TRANSFORMADA,SUBSTRING(CADENA,CONTADOR,1));
		END IF;
        SET CONTADOR = CONTADOR + 1;
     END WHILE;
     
	RETURN CADENA_TRANSFORMADA;
END; //
DELIMITER ;

-- LA OTRA A PETADO
DELIMITER //
DROP FUNCTION IF EXISTS FUNCION61;
//CREATE FUNCTION FUNCION61(CADENA VARCHAR(50)) RETURNS VARCHAR(50)
DETERMINISTIC
BEGIN
	 DECLARE CONTADOR INT;
     DECLARE LETRA CHAR;
     DECLARE CADENA_TRANSFORMADA VARCHAR(50);
     SET CONTADOR = 0;
     SET CADENA_TRANSFORMADA = '';
     
     WHILE CONTADOR <= LENGTH(CADENA) DO
		IF ESVOCAL(SUBSTRING(CADENA,CONTADOR,1)) = 1 THEN
			SET LETRA = UPPER(SUBSTRING(CADENA,CONTADOR,1));
            SET CADENA_TRANSFORMADA = CONCAT(CADENA_TRANSFORMADA,LETRA);
		ELSE
			SET CADENA_TRANSFORMADA = CONCAT(CADENA_TRANSFORMADA,SUBSTRING(CADENA,CONTADOR,1));
		END IF;
        SET CONTADOR = CONTADOR + 1;
     END WHILE;
     
	RETURN CADENA_TRANSFORMADA;
END; //
DELIMITER ;

SELECT FUNCION61('hola mundo') AS RESULTADO;


-- 7. Crear una función de manera que reciba una cantidad de euros y devuelva el valor expresado en dólares (1 € =1,08 dólar)
DELIMITER //
DROP FUNCTION IF EXISTS FUNCION7;
// CREATE FUNCTION FUNCION7(EUROS DECIMAL(10,2)) RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
	DECLARE DOLARES DECIMAL(10,2);
    
    SET DOLARES = EUROS * 1.08;
    
    RETURN DOLARES;
END; //
DELIMITER ;

SELECT FUNCION7(200) AS CAMBIO_EUR_DOLAR;

-- =======================================================================
-- ================================TIGRES ================================
-- =======================================================================
CREATE TABLE ALUMNOS (
ID INT PRIMARY KEY,
ALUMNO VARCHAR(50));

CREATE TABLE REPLICA_ALUMNOS(
ID INT PRIMARY KEY,
ALUMNO VARCHAR(50));
-- ------------------------------------
-- TIGRE1
DELIMITER //
DROP TRIGGER IF EXISTS TRIGGER1//
CREATE TRIGGER TRIGGER1
BEFORE INSERT ON ALUMNOS
FOR EACH ROW
BEGIN
INSERT INTO REPLICA_ALUMNOS VALUES(NEW.ID,NEW.ALUMNO);
END;//
DELIMITER ;

INSERT INTO ALUMNOS VALUES
(1,'ALUMNO1'),
(2,'ALUMNO2');

SELECT * FROM ALUMNOS;
SELECT * FROM REPLICA_ALUMNOS;

-- ------------------------------------------
-- TIGRE2 DE AUDITORIA
CREATE TABLE CAMBIOS(
MENSAJE VARCHAR(200));

DELIMITER //
DROP TRIGGER IF EXISTS TRIGGER2//
CREATE TRIGGER TRIGGER2
AFTER UPDATE ON ALUMNOS
FOR EACH ROW
BEGIN
	INSERT INTO CAMBIOS
    VALUES (concat_ws('**','MODIFICACION REALIZADA POR:',USER(),'FECHA',CURRENT_DATE(),'VALOR ANTES:',OLD.ID,OLD.ALUMNO,'VALOR DESPUES',NEW.ID,NEW.ALUMNO));
END;//
DELIMITER ;

-- Prueba
SELECT * FROM ALUMNOS;

UPDATE ALUMNOS SET ALUMNO='NUEVO NOMBRE'
WHERE ID=2;

SELECT * FROM CAMBIOS;

-- ------------------------------------------
-- TIGRE3 DE VALIDACION, COMO UN CHECK PERO ESTO PERMITE QUE HAGA VALIDACION CON CAMPOS DE TABLAS DIFERENTES
DELIMITER //
DROP TRIGGER IF EXISTS TRIGGER3//
CREATE TRIGGER TRIGGER3
BEFORE INSERT ON ALUMNOS
FOR EACH ROW
BEGIN
	DECLARE ERR_ID CONDITION FOR SQLSTATE '45000';
    IF NEW.ID <=0 THEN
    SIGNAL ERR_ID
    SET MESSAGE_TEXT='IDENTIFICADOR NO VALIDO';
    END IF;
END;//
DELIMITER ;

INSERT INTO ALUMNOS VALUES (20,'DFDFDS');
SELECT * FROM ALUMNOS;
INSERT INTO ALUMNOS VALUES (0,'DFDFDS');


-- TIGRE4 CAMPOS CALCULADOS
ALTER TABLE ALUMNOS ADD FECHA_NAC DATE,ADD EDAD INT;

DELIMITER //
DROP TRIGGER IF EXISTS TRIGGER4
//
CREATE TRIGGER TRIGGER4
BEFORE INSERT ON ALUMNOS
FOR EACH ROW
BEGIN
	IF NEW.FECHA_NAC IS NOT NULL THEN
    SET NEW.EDAD=YEAR(CURRENT_DATE())-YEAR(NEW.FECHA_NAC);
    END IF;
END;//
DELIMITER ;

SELECT * FROM ALUMNOS;

INSERT INTO ALUMNOS (ID,ALUMNO,FECHA_NAC)
VALUES (25,'NACHO','1997-12-04');

SELECT * FROM ALUMNOS;
