-- BASE DE DATOS SAKILA
-- 1ºDAW
-- 25-05-2023
-- WALTER MARTIN LOPES
-- --------------------------------
USE SAKILA;

-- ***********************************************************************************
-- ***********************************PROCEDIMIENTOS**********************************
-- ***********************************************************************************
-- 1. Crea un procedimiento que visualice todas las películas cuyo coste de reemplazo (replacement_cost en la tabla FILM) sea superior a un valor que se pasará como parámetro de entrada. ¿Cuántas películas tienen un costo de reemplazo superior a 20€? NOTA: puedes ver la estructura de la tabla con la orden DESC FILM
DELIMITER //
DROP PROCEDURE IF EXISTS PROCEDIMIENTO1;
// CREATE PROCEDURE PROCEDIMIENTO1(P_COSTE DECIMAL(5,2))
BEGIN 
	SELECT * FROM FILM 
    WHERE replacement_cost > P_COSTE;
END; //
DELIMITER ;

DESC FILM;

CALL PROCEDIMIENTO1(20);

-- 2. Crea un procedimiento que visualice todas las películas cuyo coste de reemplazo (replacement_cost en la tabla FILM) esté comprendido entre dos cantidades que se pasarán como parámetros de entrada. ¿Cuántas películas tienen un coste de reemplazo entre a 20€ y 21,99 €?
DELIMITER //
DROP PROCEDURE IF EXISTS PROCEDIMIENTO2;
// CREATE PROCEDURE PROCEDIMIENTO2(P1 DECIMAL(5,2),P2 DECIMAL(5,2))
BEGIN 
	SELECT * FROM FILM 
    WHERE replacement_cost BETWEEN P1 AND P2;
END; //
DELIMITER ;

CALL PROCEDIMIENTO2(20,21.99);

-- 3. Crear un PA que usando la tabla costumer, cambie el mail de un cliente por otro que se pasará como parámetro. El PA recibirá dos parámetros, el identificador del cliente y el nuevo mail (en la tabla son los campos customer_id, email). Ejecutar el PA para cambiar: 2,'patricia@gmail.com
DELIMITER //
DROP PROCEDURE IF EXISTS PROCEDIMIENTO3;
// CREATE PROCEDURE PROCEDIMIENTO3(P_ID SMALLINT UNSIGNED,P_EMAIL VARCHAR(50))
BEGIN
	UPDATE CUSTOMER
    SET EMAIL = P_EMAIL
    WHERE CUSTOMER_ID = P_ID;
END; //
DELIMITER ;

CALL PROCEDIMIENTO3(2,'patricia@gmail.com');
SELECT * FROM CUSTOMER WHERE CUSTOMER_ID = 2;

-- 4. Crear un procedure que tenga como parámetros de entrada el nombre, apellidos y el nuevo mail de un cliente de la tabla COSTUMER, (NOTA: utiliza el procedure del ejercicio anterior para cambiar el mail.)
DELIMITER //
DROP PROCEDURE IF EXISTS PROCEDIMIENTO4;
// CREATE PROCEDURE PROCEDIMIENTO4(P_NOMBRE VARCHAR(45),P_APELLIDOS VARCHAR(45),P_EMAIL VARCHAR(50))
BEGIN
	DECLARE V_ID SMALLINT UNSIGNED;
    SELECT CUSTOMER_ID INTO V_ID FROM CUSTOMER
    WHERE FIRST_NAME = P_NOMBRE
    AND LAST_NAME = P_APELLIDOS;
    
    CALL PROCEDIMIENTO3(V_ID,P_EMAIL);
END; //
DELIMITER ;

CALL PROCEDIMIENTO4('MARY','SMITH','mary1@gmail.com');
SELECT * FROM CUSTOMER;

-- 5. Crea un procedimiento que muestre los campos TITLE, DESCRIPTION de las películas cuya categoría (comedia, drama,… se pasa como parámetro). Llama después a este procedimiento para obtener todas las películas de la categoría “Comedy”
DELIMITER //
DROP PROCEDURE IF EXISTS PROCEDIMIENTO5;
// CREATE PROCEDURE PROCEDIMIENTO5(P_CATEGORIA VARCHAR(25))
BEGIN
	SELECT F.TITLE,F.DESCRIPTION,C.NAME FROM FILM AS F
    INNER JOIN FILM_CATEGORY AS FC USING(FILM_ID)
    INNER JOIN CATEGORY AS C USING(CATEGORY_ID)
    WHERE C.NAME = P_CATEGORIA;
END; //
DELIMITER ;

CALL PROCEDIMIENTO5('COMEDY');

-- 6. Crea un procedimiento que pase dos parámetros de entrada, identificador de categoría e identificador de actor y obtenga los datos de las películas sobre esa categoría en las que ha trabajado ese actor. Utiliza las tablas FILM, FILM_ACTOR, FILM_CATEGORY (utiliza el comando DESC table para ver su estructura).
DELIMITER //
DROP PROCEDURE IF EXISTS PROCEDIMIENTO6;
// CREATE PROCEDURE PROCEDIMIENTO6(P_IDCATEGORIA TINYINT,P_IDACTOR SMALLINT)
BEGIN

    SELECT F.* FROM FILM AS F
    INNER JOIN FILM_CATEGORY AS FC USING(FILM_ID)
    WHERE FC.CATEGORY_ID = P_IDCATEGORIA
    AND F.FILM_ID IN (SELECT F.FILM_ID FROM FILM AS F
					  INNER JOIN FILM_ACTOR AS A USING(FILM_ID)
					  WHERE A.ACTOR_ID = P_IDACTOR);
END; //
DELIMITER ;

CALL PROCEDIMIENTO6(2,180);

-- ***********************************************************************************
-- *************************************FUNCIONES*************************************
-- ***********************************************************************************

-- ***********************************************************************************
-- ************************************DISPARADORES***********************************
-- ***********************************************************************************