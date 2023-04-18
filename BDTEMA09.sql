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
CASE 
WHEN P1 = 1 THEN SELECT 'LUNES' AS RESULTADO;
WHEN P1 = 2 THEN SELECT 'MARTES' AS RESULTADO;
WHEN P1 = 3 THEN SELECT 'MIERCOLES' AS RESULTADO;
WHEN P1 = 4 THEN SELECT 'JUEVES' AS RESULTADO;
WHEN P1 = 5 THEN SELECT 'VIERNES' AS RESULTADO;
WHEN P1 = 6 THEN SELECT 'SÁBADO' AS RESULTADO;
WHEN P1 = 7 THEN SELECT 'DOMINGO' AS RESULTADO;
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

END; //
DELIMITER ;

CALL PROCEDIMIENTO3(10);

-- 4. Crea un procedimiento que muestre dos cadenas pasadas como parámetros concatenadas.

-- 5. Escribe un procedimiento que reciba un número real de entrada y muestre un mensaje indicando si el número es positivo, negativo o cero.

-- 6. Modifica el procedimiento del ejercicio anterior para que tenga un parámetro de entrada (IN) con el valor de un número real (FLOAT), y un parámetro de salida (OUT) de tipo cadena de caracteres. Este parámetro indica en letras si el número es positivo, negativo o cero.

-- 7. Escribe un procedimiento que reciba un número real de entrada, que representa el valor de la nota de un alumno, y muestre un mensaje indicando qué nota ha obtenido teniendo en cuenta las siguientes condiciones: Utiliza estructuras condicionales
-- ● De 0 a 5 = Insuficiente
-- ● 5 = Aprobado
-- ● 6 = Bien
-- ● 7, 8 = Notable
-- ● 9, 10 = Sobresaliente
-- ● En cualquier otro caso la nota no será válida.
