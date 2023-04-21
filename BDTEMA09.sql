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