-- BASE DE DATOS LIBRERIA
-- 1ºDAW
-- 21-04-2023
-- WALTER MARTIN LOPES
-- --------------------------------
CREATE DATABASE LIBRERIA;
USE LIBRERIA;

-- =====================CREACION DE TABLAS=============
CREATE TABLE CLIENTES(
COD_CLIENTE INT PRIMARY KEY,
NOMBRE VARCHAR(15) NOT NULL,
APELLIDOS VARCHAR(30) NOT NULL,
DIRECCION VARCHAR(30) NOT NULL,
POBLACION VARCHAR(25) NOT NULL,
CODIGO_POSTAL CHAR(5) NOT NULL);

CREATE TABLE LIBROS(
COD_LIBRO INT PRIMARY KEY,
GENERO_LITERARIO VARCHAR(30),
TITULO VARCHAR(30) NOT NULL,
EDITORIAL VARCHAR(25) NOT NULL,
NUMERO_PAGINAS INT CHECK(NUMERO_PAGINAS>1 AND NUMERO_PAGINAS<5000),
PRECIO DECIMAL(7,2) NOT NULL,
DESCUENTO DECIMAL(7,2));

CREATE TABLE EMPLEADOS(
COD_EMPLEADO INT PRIMARY KEY,
NOMBRE VARCHAR(15) NOT NULL,
APELLIDOS VARCHAR(30) NOT NULL,
SALARIO DECIMAL(10,2) NOT NULL,
COMISION DECIMAL(10,2));

CREATE TABLE VENTAS(
COD_VENTAS INT PRIMARY KEY,
COD_LIBRO INT NOT NULL,
COD_CLIENTE INT NOT NULL,
COD_EMPLEADO INT NOT NULL,
FECHA_VENTA DATE NOT NULL,
FOREIGN KEY COD_LIBRO_FK (COD_LIBRO) REFERENCES LIBROS(COD_LIBRO) ON UPDATE CASCADE ON DELETE CASCADE,
FOREIGN KEY COD_CLIENTE_FK (COD_CLIENTE) REFERENCES CLIENTES(COD_CLIENTE) ON UPDATE CASCADE ON DELETE CASCADE,
FOREIGN KEY COD_EMPLEADO_FK (COD_EMPLEADO) REFERENCES EMPLEADOS(COD_EMPLEADO) ON UPDATE CASCADE ON DELETE CASCADE);


#CARGA DE DATOS

/* CARGA DE DATOS EN LA TABLA CLIENTES */
INSERT INTO CLIENTES (
Cod_CLIENTE, nombre, Apellidos, Direccion, Poblacion,Codigo_postal) VALUES
(1,'ANA','GARCIA','c SOL','PLASENCIA','10600'),
(2,'LUIS','SANCHEZ','c PALMERAS','PLASENCIA','10600'),
(3,'ANTONIO','GARCIA','c LUNA','PLASENCIA','10600'),
(4,'MARIA','SÁNCHEZ','c MAYOR','PLASENCIA','10600');

/* CARGA DE DATOS EN LA TABLA LIBROS */
INSERT INTO LIBROS( cod_libro, Genero_literario , Titulo , Editorial,
Numero_paginas,precio ) VALUES
(1,'JUVENIL','AY DEL QUE SE RIA','ANAYA',125,20.25),
(2,'JUVENIL','TODO CONTROLADO','ANAYA',200,15.2),
(3,'TEATRO','LA DAMA DUENDE','PLANETA',150,14),
(4,'NOVELA','OLVIDADO REY GUDU','DESTINO',460,20),
(5,'POESIA','20 POEMAS DE AMOR','CATEDRA',150,15.00);

/* CARGA DE DATOS EN LA TABLA EMPLEADOS */
INSERT INTO EMPLEADOS (
Cod_empleado, nombre, Apellidos, salario,comision) VALUES
(1,'JOSE','GARCIA',1500.50,NULL),
(2,'LUIS','MARTINEZ',1500,2),
(3,'MARIA','RODRIGUEZ',2050,1.5);

/*CARGA DE DATOS EN LA TABLA ventas */
INSERT INTO VENTAS(
cod_ventas,cod_libro,cod_cliente,cod_empleado,FECHA_venta) VALUES
(1,3,1,1,'2018/02/15'),
(2,1,2,2,'2018/03/02'),
(3,2,1,3,'2018/03/03'),
(4,4,4,1,'2018/03/07'),
(5,5,3,2,'2018/03/15'),
(6,1,4,3,'2018/03/15');

-- ---------------------------------------------------------
-- ======================PROCEDIMIENTOS======================
-- 1. Crea un procedimiento almacenado que inserte en la tabla EMPLEADOS cualquier registro cuyos datos le pasemos por parámetros. Comprueba que funciona insertando el registro:
DELIMITER //
DROP PROCEDURE IF EXISTS PROCEDIMIENTO1;
//CREATE PROCEDURE PROCEDIMIENTO1(CODIGO INT, NOM VARCHAR(15), APE VARCHAR(30),SAL DECIMAL(10,2),COM DECIMAL(10,2))
BEGIN
INSERT INTO EMPLEADOS VALUES(CODIGO,NOM,APE,SAL,COM);
END;//
DELIMITER ;

CALL PROCEDIMIENTO1(4,'DIEGO','GUTIERREZ',2000,30);
SELECT * FROM EMPLEADOS;

-- 2. Crea un procedimiento que incremente un 3% el sueldo de todos los empleados que NO tengan COMISIÓN. Utiliza estructuras condicionales para comprobar si el empleado tiene el campo comisión a NULL, a 0 o a cualquier otro valor.
DELIMITER //
DROP PROCEDURE IF EXISTS PROCEDIMIENTO2;
//CREATE PROCEDURE PROCEDIMIENTO2()
BEGIN
UPDATE EMPLEADOS
SET SALARIO = SALARIO * 1.03
WHERE COMISION IS NULL OR COMISION = 0;
END;//
DELIMITER ;

CALL PROCEDIMIENTO2();
SELECT * FROM EMPLEADOS;

-- 3. Crea un procedimiento que borre de la tabla los empleados cuyo apellido comience por una letra que le pasaremos como parámetro.
DELIMITER //
DROP PROCEDURE IF EXISTS PROCEDIMIENTO3
//CREATE PROCEDURE PROCEDIMIENTO3(LETRA CHAR)
BEGIN
DELETE FROM EMPLEADOS
WHERE APELLIDOS LIKE CONCAT(LETRA,'%');
END;//
DELIMITER ;

CALL PROCEDIMIENTO3('R');

-- 4. Crea una función que calcule el sueldo neto que cobrará un empleado, cuyo apellido se introduce como parámetro. El sueldo neto se calcula: salario (descontándole el 18% de IRPF)+comisiones(descontándole el 2% de IRPF), por tanto:
-- salario neto= salario- salario*18/100)+comision-(comision*2/100)
-- Ejecuta la función para el trabajador “GUTIERREZ”
DELIMITER //
CREATE FUNCTION SueldoNeto(apellido_empleado VARCHAR(30))
RETURNS DECIMAL(10,2)
BEGIN
  DECLARE salario_bruto DECIMAL(10,2);
  DECLARE comision_bruto DECIMAL(10,2);
  DECLARE salario_neto DECIMAL(10,2);

  SELECT SALARIO, COMISION
  INTO salario_bruto, comision_bruto
  FROM EMPLEADOS
  WHERE APELLIDOS = apellido_empleado;

  SET salario_neto = (salario_bruto - (salario_bruto * 18 / 100)) + (comision_bruto - (comision_bruto * 2 / 100));

  RETURN salario_neto;
END //
DELIMITER ;

SELECT SueldoNeto('GUTIERREZ') AS Salario_Neto;

-- 5. Crear un procedimiento que calcula la media del sueldo de los empleados que tienen comisión superior al 15%.
DELIMITER //
DROP PROCEDURE IF EXISTS PROCEDIMIENTO5
//CREATE PROCEDURE PROCEDIMIENTO5()
BEGIN
SELECT AVG(SALARIO) AS MEDIA_SUELDO_MAS15 FROM EMPLEADOS WHERE COMISION > 15;
END;//
DELIMITER ;

CALL PROCEDIMIENTO5();

DELIMITER //
DROP FUNCTION IF EXISTS FUNCION5
//CREATE FUNCTION FUNCION5() RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
	DECLARE RESULTADO DECIMAL (10,2);
    
	SELECT AVG(SALARIO) INTO RESULTADO FROM EMPLEADOS  WHERE COMISION > 15;
    RETURN RESULTADO;
END;//
DELIMITER ;

SELECT FUNCION5() AS RESULTADO;

-- 6.Escribir una función para calcular la media del sueldo de los empleados que viven en una determinada ciudad que pasamos por parámetro.
-- NO SE PUEDE HACER

-- 7. Crea una función que cuente el número total de libros de un determinado género literario cuyo nombre le pasamos como parámetro.
DELIMITER //
DROP FUNCTION IF EXISTS FUNCION7;
// CREATE FUNCTION FUNCION7(P_GENERO VARCHAR(30)) RETURNS INT
DETERMINISTIC
BEGIN
	DECLARE TOTAL_LIBROS INT;
    
    SELECT COUNT(*) INTO TOTAL_LIBROS FROM LIBROS 
    WHERE GENERO_LITERARIO = P_GENERO;
    
    RETURN TOTAL_LIBROS;
END;//
DELIMITER ;

SELECT * FROM LIBROS;

SELECT FUNCION7('JUVENIL') AS RESULTADO;

-- 8. Crea una función que cuenta el número de ventas que se han realizado en una determinada fecha que le pasemos por parámetro.
DELIMITER //
DROP FUNCTION IF EXISTS FUNCION8;
// CREATE FUNCTION FUNCION8(P_FECHA DATE) RETURNS INT
DETERMINISTIC
BEGIN
	DECLARE NUMERO_VENTAS INT;
    SELECT COUNT(*) INTO NUMERO_VENTAS FROM VENTAS 
    WHERE FECHA_VENTA = P_FECHA;
    
    RETURN NUMERO_VENTAS;
END;//
DELIMITER ;

SELECT * FROM VENTAS;

SELECT FUNCION8('2018-02-15') AS RESULTADO;

-- 9. Crea primero un procedimiento que muestre el libro más caro que tenemos en nuestra librería y después una función que realice la misma operación.
DELIMITER //
DROP PROCEDURE IF EXISTS PROCEDIMIENTO9
//CREATE PROCEDURE PROCEDIMIENTO9()
BEGIN
SELECT MAX(PRECIO) AS RESULTADO FROM LIBROS;
END;//
DELIMITER ;

CALL PROCEDIMIENTO9();

DELIMITER //
DROP FUNCTION IF EXISTS FUNCION9
//CREATE FUNCTION FUNCION9() RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
DECLARE RESULTADO DECIMAL(10,2);
SELECT MAX(PRECIO) INTO RESULTADO FROM LIBROS;
RETURN RESULTADO;
END;//
DELIMITER ;

SELECT FUNCION9();



-- *****************************************************************************************
-- *****************************************************************************************
-- ***************************MANEJO DE ERRORES-CURSORES-TRIGGERS***************************
-- *****************************************************************************************
-- *****************************************************************************************

-- ##################################################################################################################################################
-- ##################################################################################################################################################
-- CONSULTAS
-- ##################################################################################################################################################
-- ##################################################################################################################################################
-- 1
SELECT CLIENTES.NOMBRE, CLIENTES.APELLIDOS, CLIENTES.DIRECCION, CLIENTES.CODIGO_POSTAL FROM CLIENTES INNER JOIN VENTAS
ON CLIENTES.COD_CLIENTE = VENTAS.COD_CLIENTE
	INNER JOIN EMPLEADOS
    ON VENTAS.COD_EMPLEADO = EMPLEADOS.COD_EMPLEADO
    WHERE CLIENTES.APELLIDOS LIKE 'G%' AND EMPLEADOS.NOMBRE LIKE 'M%';

-- 2
SELECT LIBROS.* FROM LIBROS INNER JOIN VENTAS
ON LIBROS.COD_LIBRO = VENTAS.COD_LIBRO
	INNER JOIN CLIENTES
	ON VENTAS.COD_CLIENTE = CLIENTES.COD_CLIENTE
	WHERE GENERO_LITERARIO != 'NOVELA' AND CLIENTES.POBLACION = 'PLASENCIA';

-- 3
SELECT CLIENTES.*, LIBROS.TITULO, LIBROS.EDITORIAL, EMPLEADOS.NOMBRE FROM CLIENTES INNER JOIN VENTAS
ON CLIENTES.COD_CLIENTE = VENTAS.COD_CLIENTE
	INNER JOIN EMPLEADOS
    ON VENTAS.COD_EMPLEADO = EMPLEADOS.COD_EMPLEADO
		INNER JOIN LIBROS
        ON LIBROS.COD_LIBRO = VENTAS.COD_LIBRO
		WHERE EMPLEADOS.COD_EMPLEADO = 2
		ORDER BY LIBROS.EDITORIAL;
        
-- 4
SELECT DISTINCT POBLACION FROM CLIENTES;

-- ##################################################################################################################################################
-- ##################################################################################################################################################
-- PROCEDIMIENTOS Y FUNCIONES
-- ##################################################################################################################################################
-- ##################################################################################################################################################
-- 1
DELIMITER //
DROP PROCEDURE IF EXISTS EJERCICIO1//
CREATE PROCEDURE EJERCICIO1(PA_COD_LIBRO INT, PA_GENERO_LITERARIO VARCHAR(30), PA_TITULO VARCHAR(30), PA_EDITORIAL VARCHAR(25), PA_NUMERO_PAGINAS INT, PA_PRECIO DECIMAL(7.2), PA_DESCUENTO DECIMAL(7.2))
BEGIN
	-- DECLARO LOS ERRORES
	DECLARE ERROR BOOLEAN DEFAULT FALSE; -- DECLARO UNA VARIABLE PARA CHEQUEAR EL POSIBLE ERROR
    DECLARE ERROR2 BOOLEAN DEFAULT FALSE; -- DECLARO UNA VARIABLE PARA CHEQUEAR EL POSIBLE ERROR
    DECLARE CONTINUE HANDLER FOR 1146 -- ES EL ERROR LA TABLA REFERIDA NO EXISTE
	
	BEGIN
		SET ERROR = TRUE; -- SI OCURRE SE CAPTURA Y LA VARIABLE ERROR TOMA EL VALOR TRUE
	END;
    
    DECLARE CONTINUE HANDLER FOR 1062 -- ES EL ERROR CUANDO INTENTO INSERTAR UNA VALOR DE CLAVE YA EXISTENTE
    
    BEGIN
		SET ERROR2 = TRUE; -- SI OCURRE SE CAPTURA Y LA VARIABLE ERROR TOMA EL VALOR TRUE
	END;
    -- INSERTO LOS DATOS PASADOS POR PARAMETRO EN LA TABLA
    INSERT INTO LIBROS VALUES
    (PA_COD_LIBRO, PA_GENERO_LITERARIO, PA_TITULO, PA_EDITORIAL, PA_NUMERO_PAGINAS, PA_PRECIO, PA_DESCUENTO );
    
    IF ERROR THEN 
		SELECT 'LA TALBA LIBROS NO EXISTE EN LA BASE DE DATOS' AS MENSAJE;
    ELSE
		IF ERROR2 THEN SELECT CONCAT('CLAVE DUPLICADA') AS MENSAJE;
        ELSE SELECT 'FILA AÑADIDA' AS MENSAJE;
        END IF;
    END IF;
END; //
DELIMITER ;

CALL EJERCICIO1(20, 'NOVELA', 'PATRIA', 'PLANETA', '400', '23.50', '10');
SELECT * FROM LIBROS;

-- 2
DELIMITER //
DROP PROCEDURE IF EXISTS EJERCICIO2//
CREATE PROCEDURE EJERCICIO2()
BEGIN
	-- DECLARO VARIABLES
    DECLARE A INT;
    DECLARE B VARCHAR(35);
    DECLARE C DECIMAL(7.2);
    DECLARE ULTIMAFILA  BOOLEAN DEFAULT FALSE; -- ESTA VARIABLE CONTROLA EK FIN DE LA TABLA
    DECLARE C CURSOR FOR SELECT COD_LIBRO, GENERO_LITERARIO, PRECIO FROM LIBROS;
    
    -- CURSOR PARA LEER LOS DATOS
    DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET ULTIMAFILA = TRUE;
    OPEN C; -- ABRO EL CURSOR
    
    REPEAT -- BUCLE DE LA LECETURA DEL CURSOR
		FETCH  C INTO A,B,C; -- GUARDAR CADA DATO EN CADA FILA EN LAS VARIABLES LOCALES
        IF NOT ULTIMAFILA THEN 
			IF B = 'NOVELA' THEN UPDATE LIBROS SET PRECIO  = '28'
								 WHERE COD_LIBRO = A;
			ELSE
				IF B = 'JUVENIL' THEN UPDATE LIBROS SET PRECIO  = '18'
								WHERE COD_LIBRO = A;
				ELSE
					IF C = 'POESIA' THEN 
                    IF C > 10 THEN UPDATE LIBROS SET PRECIO= PRECIO + PRECIO * '0.25'
									WHERE COD_LIBRO = A;
					END IF;
                    END IF;
				END IF;
			END IF;
		END IF;
        UNTIL ULTIMAFILA
        END REPEAT;
		CLOSE C;
END; //
DELIMITER ;

CALL EJERCICIO2();

-- 3
-- AÑADO EL CAMPO STOCK A LA TABLA LIBROS
ALTER TABLE LIBROS
ADD COLUMN STOCK INT;

-- AÑADO EL CAMPO CANTIDAD A LA TABLA VENTAS
ALTER TABLE VENTAS
ADD COLUMN CANTIDAD INT;
-- UPDATE
UPDATE LIBROS SET STOCK=10;

DELIMITER //
DROP TRIGGER IF EXISTS TRIGGER3//
CREATE TRIGGER TRIGGER3
	AFTER INSERT ON VENTAS
    FOR EACH ROW
BEGIN
	UPDATE LIBROS 
    SET STOCK = (STOCK - NEW.CANTIDAD)
    WHERE COD_LIBRO = NEW.COD_LIBRO;
END; //
DELIMITER ;

SELECT * FROM LIBROS;

INSERT INTO VENTAS VALUES(12,3,1,1,'2023/05/03',2);

-- TIGRE 4
DELIMITER //
DROP TRIGGER IF EXISTS TRIGGER4//
CREATE TRIGGER TRIGGER4
	AFTER DELETE ON VENTAS
    FOR EACH ROW
BEGIN
	UPDATE LIBROS 
    SET STOCK = (STOCK + OLD.CANTIDAD)
    WHERE COD_LIBRO = OLD.COD_LIBRO;
END; //
DELIMITER ;

DELETE FROM VENTAS
WHERE COD_VENTAS=11;

-- TIGRE 5
CREATE TABLE NUEVOS_CLIENTES(
 NUM_REGISTRO INT AUTO_INCREMENT PRIMARY KEY,
 REGISTRO VARCHAR(200));
 

DELIMITER //
DROP TRIGGER IF EXISTS TRIGGER5//
CREATE TRIGGER TRIGGER5
BEFORE INSERT ON CLIENTES
FOR EACH ROW
BEGIN
	INSERT INTO NUEVOS_CLIENTES (REGISTRO)
    VALUES(concat_ws(' ','ALTA REALIZADA POR:',USER(),'FECHA: ',CURRENT_DATE(),CURRENT_TIME(),'NUEVO CLIENTE:',NEW.NOMBRE,NEW.APELLIDOS,NEW.POBLACION));
END;//
DELIMITER ;

INSERT INTO CLIENTES  VALUES(20,'WALTER','MARTIN','ASDFASDF','PLASENCIA','10600');

SELECT * FROM NUEVOS_CLIENTES;