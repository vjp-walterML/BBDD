-- BASE DE DATOS EMPRESA_PROG
-- 1ºDAW
-- 05-05-2023
-- WALTER MARTIN LOPES
-- --------------------------------
CREATE DATABASE EMPRESA_PROG;
USE EMPRESA_PROG;

CREATE TABLE DPTO(
N_DPTO INT PRIMARY KEY,
NOM_DPTO VARCHAR(50),
LOCALIDAD VARCHAR(50));

CREATE TABLE EMP(
N_EMP INT PRIMARY KEY,
APELLIDO VARCHAR(50),
OFICIO VARCHAR(50),
DIRECTOR INT,
FECHA_ALT DATE,
SALARIO DECIMAL(9,2),
COMISION DECIMAL(9,2),
N_DPTO INT);

ALTER TABLE EMP 
ADD CONSTRAINT N_DPTO_FK FOREIGN KEY (N_DPTO) REFERENCES DPTO (N_DPTO) ON UPDATE CASCADE ON DELETE CASCADE;

-- CARGA DE DATOS EN TABLA DPTO
INSERT INTO Dpto VALUES(10,'CONTABILIDAD','ELCHE');
INSERT INTO Dpto VALUES(20,'INVESTIGACIÓN','MADRID');
INSERT INTO Dpto VALUES(30,'COMPRAS','BARCELONA');
INSERT INTO Dpto VALUES(40,'FARMACIA','SALAMANCA');
-- --CARGA DE DATOS EN TABLA EMP
INSERT INTO Emp( N_Emp, Apellido, Oficio, Director, Fecha_Alt, Salario, Comision, N_Dpto)
VALUES
(7369,'SANCHEZ','MEDICO',7902,'1980/12/17/',10400,0,20),
(7499,'ARROYO','TRAUMATOLOGO',7698,'1981/02/22',208000,39000,20),
(7521,'SALA','ANESTESISTA',689,'1981/02/22',162500,65000,20),
(7566,'JIMENEZ','ANESTESISTA',7839,'1981/04/22',386750,0,20),
(7654,'MARTIN','ADMINISTRATIVO',7698,'1981/02/25',182000,182000,30),
(7698,'NEGRO','FARMACEUTICO',7839,'1981/05/22',370500,0,40),
(7782,'CEREZO','MEDICO',7839,'1981/02/22',318500,0,20),
(7788,'NINO','ENFERMERO',7566,'1987/03/19',390000,0,20),
(7839,'REY','JEFE ENFERMERO',0,'1981/02/22',650000,0,20),
(7844,'TOVAR','MEDICO',7698,'1982/02/22',195000,0,40),
(7876,'ALONSO','OFTALMOLOGO',7788,'1987/03/09',143000,0,20),
(7900,'JIMENO','TRAUMATOLOGO',7698,'1987/04/19',123500,0,20),
(7902,'FERNANDEZ','TRAUMATOLOGO',7566,'1985/03/19',390000,0,NULL),
(7934,'MUÑOZ','TRAUMATOLOGO',7782,'1982/03/10',169000,0,40),
(7119,'SERRA','DIRECTOR',7839,'1983/03/19',225000,39000,NULL),
(7322,'GARCIA','CONTABLE',7119,'1985/08/19',129000,0,10);

-- ********************************************************************************
-- *****************************PROCEDIMIENTOS SIMPLES*****************************
-- ********************************************************************************

-- 1) Crear un procedimiento que muestre a los empleados que se dieron de alta entre una determinada fecha inicial y fecha final en un departamento. Le pasaremos como parámetros esas fechas y el nº de departamento.
DELIMITER //
DROP PROCEDURE IF EXISTS PROCEDIMIENTO1;
// CREATE PROCEDURE PROCEDIMIENTO1(FECHA1 DATE,FECHA2 DATE,NUM_DEP INT)
BEGIN
	SELECT * FROM EMP 
    WHERE FECHA_ALT BETWEEN FECHA1 AND FECHA2
    AND N_DPTO = NUM_DEP;
END; //
DELIMITER ;

CALL PROCEDIMIENTO1('1980-12-16','1981-02-23',20);

-- 2) Crear procedimiento que inserte un empleado y liste la tabla con el nuevo empleado ya insertado.
-- Llama al procedimiento para insertar al empleado:
-- 7896,'SUAREZ','EMPLEADO',0,'2015/05/20',16000,0,20
DELIMITER //
DROP PROCEDURE IF EXISTS PROCEDIMIENTO2;
// CREATE PROCEDURE PROCEDIMIENTO2(P1 INT,P2 VARCHAR(50),P3 VARCHAR(50),P4 INT,P5 DATE,P6 DECIMAL(9,2),P7 DECIMAL(9,2),P8 INT)
BEGIN
	INSERT INTO EMP VALUES(P1,P2,P3,P4,P5,P6,P7,P8);
    SELECT * FROM EMP;
END; //
DELIMITER ;

CALL PROCEDIMIENTO2(7896,'SUAREZ','EMPLEADO',0,'2015/05/20',16000,0,20);

-- 3) Crear un procedimiento que nos muestre el nombre del departamento, número del departamento y el número de empleados que tiene ese departamento (pasamos como parámetro el número de departamento).
DELIMITER //
DROP PROCEDURE IF EXISTS PROCEDIMIENTO3;
// CREATE PROCEDURE PROCEDIMIENTO3(NUM_DEP INT)
BEGIN
	SELECT D.NOM_DPTO,D.N_DPTO,COUNT(E.N_EMP)
    FROM DPTO AS D INNER JOIN EMP AS E
    ON D.N_DPTO = E.N_DPTO
    GROUP BY D.N_DPTO
    HAVING D.N_DPTO = NUM_DEP;
END; //
DELIMITER ;

CALL PROCEDIMIENTO3(20);

-- 4) Crear un procedimiento para devolver los campos salario, oficio y comisión de un empleado, pasándole el apellido como parámetro.
	-- Ejecuta el procedimiento
	-- ● para el empleado 'GARCIA'.
	-- ● para todos los empleados.
DELIMITER //
DROP PROCEDURE IF EXISTS PROCEDIMIENTO4;
// CREATE PROCEDURE PROCEDIMIENTO4(APE VARCHAR(50))
BEGIN
	SELECT SALARIO,OFICIO,COMISION FROM EMP 
    WHERE APELLIDO = APE;
END; //
DELIMITER ;

CALL PROCEDIMIENTO4('GARCIA');

-- 5. Procedimiento que muestre nombre, apellidos,oficio y departamento de todos los empleados aunque no tengan asignado departamento.
-- NOTA: UTILIZAD LA FUNCIÓN IFNULL(nombre_campo,'mensaje') para comprobar si un campo contiene datos o contiene valor null, en este caso devuelve el mensaje que le pasemos como parámetro.
DELIMITER //
DROP PROCEDURE IF EXISTS PROCEDIMIENTO5;
// CREATE PROCEDURE PROCEDIMIENTO5(MENSAJE VARCHAR(100))
BEGIN
	SELECT N_EMP AS NOMBRE,APELLIDO,OFICIO,IFNULL(N_DPTO,MENSAJE) AS DEPARTAMENTO 
    FROM EMP;
END; //
DELIMITER ;

CALL PROCEDIMIENTO5();

-- ********************************************************************************
-- *******************************FUNCIONES SIMPLES********************************
-- ********************************************************************************

-- 1. Crear una función que calcule la suma de los sueldos de todos los empleados de un departamento cuyo número le pasamos como parámetro.
DELIMITER //
DROP FUNCTION IF EXISTS FUNCION1;
//CREATE FUNCTION FUNCION1(DEPARTAMENTO INT) RETURNS DECIMAL (10,2)
DETERMINISTIC 
BEGIN
	DECLARE SUMA DECIMAL(10,2) DEFAULT 0;
    SELECT SUM(COALESCE(SALARIO,0)) INTO SUMA FROM EMP
    WHERE N_DPTO = DEPARTAMENTO;
    RETURN SUMA;
END; //
DELIMITER ;

SELECT FUNCION1(40) AS SUMA;

-- 2. Función que cuente cuántos departamentos hay en la empresa.
DELIMITER //
DROP FUNCTION IF EXISTS FUNCION2;
//CREATE FUNCTION FUNCION2() RETURNS INT
DETERMINISTIC 
BEGIN
	DECLARE NUMERO_DEPARTAMENTOS INT DEFAULT 0;
    SELECT COUNT(N_DPTO) INTO NUMERO_DEPARTAMENTOS FROM DPTO;
    RETURN NUMERO_DEPARTAMENTOS;
END; //
DELIMITER ;

SELECT FUNCION2() AS 'NUMERO DE DEPARTAMENTOS';

-- 3. Función que devuelva un mensaje si el número empleados de un departamento es igual o mayor de 3:
-- 		"'3 O MÁS DE TRES EMPLEADOS'+'EN EL DPTO'+'—’NÚMERO DE DPTO’
-- 		y otro mensaje en caso contrario:" 'MENOS DE TRES EMPLEADOS'+'EN EL DPTO'+'--. El 	-- 		número de departamento se le pasa como parámetro. Usar la función CONCAT.
DELIMITER //
DROP FUNCTION IF EXISTS FUNCION3;
//CREATE FUNCTION FUNCION3(DEPARTAMENTO INT) RETURNS VARCHAR (100)
DETERMINISTIC 
BEGIN
	DECLARE MENSAJE VARCHAR (100);
    DECLARE NUMERO_EMP INT DEFAULT 0;
    
    SELECT COUNT(N_EMP) INTO NUMERO_EMP FROM EMP 
    GROUP BY N_DPTO
    HAVING N_DPTO = DEPARTAMENTO;
    
    IF (NUMERO_EMP >= 3) THEN
		SET MENSAJE = CONCAT('3 O MAS EMPLEADOS EN EL DEPARTAMENTO ',DEPARTAMENTO);
	ELSE
		SET MENSAJE = CONCAT('MENOS DE TRES EMPLEADOS EN EL DEPARTAMENTO ',DEPARTAMENTO);
	END IF;
    
    RETURN MENSAJE;
END; //
DELIMITER ;

SELECT FUNCION3(10) AS '¿CUANTOS EMPLEADOS?';

-- 4. Crea una función a la que le pasemos como parámetro el nombre de un departamento y devuelva el valor del sueldo más alto.
DELIMITER //
DROP FUNCTION IF EXISTS FUNCION4;
//CREATE FUNCTION FUNCION4(NOMBRE VARCHAR(50)) RETURNS DECIMAL(9,2)
DETERMINISTIC 
BEGIN
	DECLARE SUELDO_MAS_ALTO DECIMAL(9,2) DEFAULT 0;
    
    SELECT MAX(SALARIO) INTO SUELDO_MAS_ALTO FROM EMP
    WHERE N_DPTO = (SELECT N_DPTO FROM DPTO WHERE NOM_DPTO = NOMBRE);
    
    RETURN SUELDO_MAS_ALTO;
END; //
DELIMITER ;

SELECT FUNCION4('FARMACIA') AS 'SUELDO MAS ALTO';

-- 5. Utilizando la función que has hecho en el ejercicio anterior, resuelve las siguientes consultas:
	-- A. Mostrar los datos de los empleados que tienen un sueldo inferior al máximo sueldo del departamento "FARMACIA".
SELECT * FROM EMP
WHERE SALARIO < FUNCION4('FARMACIA');
    
	-- B. Mostrar los salarios máximos de departamentos ventas e investigación. La salida 	de la consulta será algo similar a:
SELECT CONCAT_WS('-----',FUNCION4('COMPRAS'),FUNCION4('INVESTIGACIÓN')) AS MAXIMOS_SALARIOS;

-- *********************************************************************************
-- ************************************TRIGGERS*************************************
-- *********************************************************************************
-- 1. Crea un trigger que cada vez que borremos un registro de la tabla EMPLEADOS, lo inserte en la tabla DESPEDIDOS. Para ello primero crea la tabla DESPEDIDOS con las columnas N_EMPLEADO Y APELLIDO.
CREATE TABLE DESPEDIDOS(
N_EMPLEADO INT,
APELLIDO VARCHAR(50));

DELIMITER //
DROP TRIGGER IF EXISTS TIGRE1;
// CREATE TRIGGER TIGRE1
AFTER DELETE ON EMP
FOR EACH ROW
BEGIN
	INSERT INTO DESPEDIDOS VALUES(OLD.N_EMP,OLD.APELLIDO);
END; //
DELIMITER ;

INSERT INTO EMP VALUES (0101,'MARTIN','PROGRAMADOR',7902,'1980/12/17',10400,0,20);

SELECT * FROM EMP;

DELETE FROM EMP 
WHERE OFICIO = 'PROGRAMADOR';
-- 2. Crea un trigger que almacene en una tabla los cambios que se vayan realizando en la tabla EMPLEADOS sobre el campo SALARIO. Para ello crea una nueva tabla CAMBIOS con los campos:
-- USUARIO, DATO_ANTIGUO, DATO_NUEVO, FECHA_CAMBIO.
CREATE TABLE CAMBIOS_SALARIO(
USUARIO INT,
DATO_ANTIGUO DECIMAL(9,2),
DATO_NUEVO DECIMAL(9,2),
FECHA_CAMBIO DATE);

DELIMITER //
DROP TRIGGER IF EXISTS TIGRE2;
// CREATE TRIGGER TIGRE2
AFTER UPDATE ON EMP
FOR EACH ROW
BEGIN
	IF (OLD.SALARIO != NEW.SALARIO) THEN 
		INSERT INTO CAMBIOS_SALARIO VALUES(NEW.N_EMP,OLD.SALARIO,NEW.SALARIO, 	current_date());
    END IF;
END; //
DELIMITER ;

INSERT INTO EMP VALUES (0101,'MARTIN','PROGRAMADOR',7902,'1980/12/17',10400,0,20);

SELECT * FROM EMP;

UPDATE EMP 
SET APELLIDO = 'LOPES'
WHERE N_EMP = 0101;

SELECT * FROM CAMBIOS_SALARIO;

UPDATE EMP 
SET SALARIO = 50000
WHERE N_EMP = 0101;

-- 3. Crea un trigger que cada vez que se inserte un nuevo departamento, inserte su nombre en una nueva tabla NUEVOS_DPTOS. Debes insertar el nombre del departamento, su número, la fecha de inserción y una breve descripción del departamento.
CREATE TABLE NUEVOS_DPTOS(
NOM_DPTO VARCHAR(50),
N_DPTO INT,
FECHA_INSERCION DATE,
DESCRIPCION VARCHAR(200));

DELIMITER //
DROP TRIGGER IF EXISTS TIGRE3;
// CREATE TRIGGER TIGRE3
AFTER INSERT ON DPTO
FOR EACH ROW
BEGIN
	INSERT INTO NUEVOS_DPTOS VALUES(NEW.NOM_DPTO,NEW.N_DPTO,current_date(),'ESTO ES UN MENSAJE PORQUE LO HA DICHO PUERTO');
END; //
DELIMITER ;

INSERT INTO DPTO VALUES(123456,'JORGE','VIÑAROCK');

SELECT * FROM NUEVOS_DPTOS;

-- *********************************************************************************
-- ************************************CURSORES*************************************
-- *********************************************************************************
-- 1. Crear un procedimiento que utilizando un cursor lea toda la tabla EMP e inserte los datos de los empleados en tablas independientes según su especialidad. Dentro del procedimiento se crearán las siguientes tablas:
-- ● TRAUMA, para insertar los empleados con OFICIO=TRAUMATOLOGO
-- ● OFTALMOLOGIA, para insertar los empleados con OFICIO=OFTALMOLOGO
-- ● ANESTESISTA, para insertar los empleados con OFICIO=ANESTESISTA
-- ● FARMACIA para insertar los empleados con OFICIO=FARMACEUTICO
-- ● GENERAL para insertar los empleados con cualquier otro valor en el campo OFICIO.
DELIMITER //
DROP PROCEDURE IF EXISTS CURSORES1;
// CREATE PROCEDURE CURSORES1()
BEGIN
	-- DECLARO VARIABLES
	DECLARE ULTIMAFILA BOOLEAN DEFAULT FALSE; 
    DECLARE NUM_EMP INT;
    DECLARE APE VARCHAR(50);
    DECLARE OFI VARCHAR(50);
    DECLARE DIREC INT;
    DECLARE FECHA DATE;
    DECLARE SAL DECIMAL(9,2);
    DECLARE COMIS DECIMAL(9,2);
    DECLARE NUM_DPTO INT;
    -- DECLARO CURSOR
    DECLARE C CURSOR FOR SELECT N_EMP,APELLIDO,OFICIO,DIRECTOR,FECHA_ALT,SALARIO,COMISION,N_DPTO FROM EMP;
    
    -- DECLARO HANDLER NECESARIO PARA PARAR EL CURSOR
    DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET ULTIMAFILA = TRUE;
    
    -- CREO TABLAS NECESARIAS
    DROP TABLE IF EXISTS TRAUMATOLOGO;
    CREATE TABLE TRAUMATOLOGO(
    N_EMP INT PRIMARY KEY,
	APELLIDO VARCHAR(50),
	OFICIO VARCHAR(50),
	DIRECTOR INT,
	FECHA_ALT DATE,
	SALARIO DECIMAL(9,2),
	COMISION DECIMAL(9,2),
	N_DPTO INT);
    
    DROP TABLE IF EXISTS OFTALMOLOGO;
    CREATE TABLE OFTALMOLOGO(
    N_EMP INT PRIMARY KEY,
	APELLIDO VARCHAR(50),
	OFICIO VARCHAR(50),
	DIRECTOR INT,
	FECHA_ALT DATE,
	SALARIO DECIMAL(9,2),
	COMISION DECIMAL(9,2),
	N_DPTO INT);
    
    DROP TABLE IF EXISTS ANESTESISTA;
    CREATE TABLE ANESTESISTA(
    N_EMP INT PRIMARY KEY,
	APELLIDO VARCHAR(50),
	OFICIO VARCHAR(50),
	DIRECTOR INT,
	FECHA_ALT DATE,
	SALARIO DECIMAL(9,2),
	COMISION DECIMAL(9,2),
	N_DPTO INT);
    
    DROP TABLE IF EXISTS FARMACEUTICO;
    CREATE TABLE FARMACEUTICO(
    N_EMP INT PRIMARY KEY,
	APELLIDO VARCHAR(50),
	OFICIO VARCHAR(50),
	DIRECTOR INT,
	FECHA_ALT DATE,
	SALARIO DECIMAL(9,2),
	COMISION DECIMAL(9,2),
	N_DPTO INT);
    
    DROP TABLE IF EXISTS GENERALL;
    CREATE TABLE GENERALL(
    N_EMP INT PRIMARY KEY,
	APELLIDO VARCHAR(50),
	OFICIO VARCHAR(50),
	DIRECTOR INT,
	FECHA_ALT DATE,
	SALARIO DECIMAL(9,2),
	COMISION DECIMAL(9,2),
	N_DPTO INT);
    
    -- ABRO CURSOR
    OPEN C;
		WHILE NOT ULTIMAFILA DO
			-- CARGO LAS VARIABLES LOCALES
			FETCH  C INTO NUM_EMP,APE,OFI,DIREC,FECHA,SAL,COMIS,NUM_DPTO;
            IF NOT ULTIMAFILA THEN
				IF OFI = 'TRAUMATOLOGO' THEN
					INSERT INTO TRAUMATOLOGO VALUES(NUM_EMP,APE,OFI,DIREC,FECHA,SAL,COMIS,NUM_DPTO);
				ELSEIF OFI = 'OFTALMOLOGO' THEN 
					INSERT INTO OFTALMOLOGO VALUES(NUM_EMP,APE,OFI,DIREC,FECHA,SAL,COMIS,NUM_DPTO);
				ELSEIF OFI = 'ANESTESISTA' THEN
					INSERT INTO ANESTESISTA VALUES(NUM_EMP,APE,OFI,DIREC,FECHA,SAL,COMIS,NUM_DPTO);
				ELSEIF OFI = 'FARMACEUTICO' THEN
					INSERT INTO FARMACEUTICO VALUES(NUM_EMP,APE,OFI,DIREC,FECHA,SAL,COMIS,NUM_DPTO);
				ELSE
					INSERT INTO GENERALL VALUES(NUM_EMP,APE,OFI,DIREC,FECHA,SAL,COMIS,NUM_DPTO);
				END IF;
			END IF;
        END WHILE;
    -- CIERRO CURSOR
    CLOSE C;
END; //
DELIMITER ;

SELECT * FROM EMP;
SELECT * FROM TRAUMATOLOGO;
SELECT * FROM OFTALMOLOGO;
SELECT * FROM FARMACEUTICO;
SELECT * FROM ANESTESISTA;
SELECT * FROM GENERALL;

CALL CURSORES1();

-- 2. Escribir un procedimiento que muestre el nombre de cada departamento y el número de empleados que tiene ese departamento. Debes declarar un cursor para hacer esa operación y mostrar la salida en el siguiente formato

DELIMITER //
DROP FUNCTION IF EXISTS NUM_EMPLEADOS_DEPARTAMENTO;
//CREATE FUNCTION NUM_EMPLEADOS_DEPARTAMENTO(DEPARTAMENTO INT) RETURNS INT
DETERMINISTIC 
BEGIN
    DECLARE NUMERO_EMP INT DEFAULT 0;
    
    SELECT COUNT(N_EMP) INTO NUMERO_EMP FROM EMP 
    GROUP BY N_DPTO
    HAVING N_DPTO = DEPARTAMENTO;
    
    RETURN NUMERO_EMP;
END; //
    
DELIMITER //
DROP PROCEDURE IF EXISTS CURSORES2;
// CREATE PROCEDURE CURSORES2()
BEGIN
	DECLARE ULTIMAFILA  BOOLEAN DEFAULT FALSE;
    DECLARE NOMBRE_DEP VARCHAR(50);
    DECLARE NUM_EMPLEADOS INT DEFAULT 0;
    -- DECLARO CURSOR
    DECLARE C CURSOR FOR SELECT D.NOM_DPTO,NUM_EMPLEADOS_DEPARTAMENTO(D.N_DPTO) FROM DPTO AS D;
    
    -- DECLARO HANDLER NECESARIO PARA PARAR EL CURSOR
    DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET ULTIMAFILA = TRUE;
    
    DROP TABLE IF EXISTS INFORME;
    CREATE TABLE INFORME (DEPARTAMENTOS VARCHAR(100));
    
    -- ABRO CURSOR
    OPEN C;
		WHILE NOT ULTIMAFILA DO
			FETCH  C INTO NOMBRE_DEP,NUM_EMPLEADOS;
			IF NOT ULTIMAFILA THEN 
				INSERT INTO INFORME VALUES(CONCAT_WS('--->',NOMBRE_DEP,NUM_EMPLEADOS));
			END IF;
       END WHILE;
    -- CIERRO CURSOR
    CLOSE C;
    
    SELECT DEPARTAMENTOS AS 'DEPARTAMENTOS Y TOTAL DE EMPLEADOS' FROM INFORME;
END; //
DELIMITER ;

CALL CURSORES2();
