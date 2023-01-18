-- BASE DE DATOS ORGANIZACION
-- 1º DAW
-- 17-01-2023
-- WALTER MARTIN LOPES
-- -------------------------------------------------------
-- CREACION DE LA BBDD MUSICA
CREATE DATABASE ORGANIZACION;
USE ORGANIZACION;

-- CREACION DE LAS TABLAS
CREATE TABLE EMPLEADOS(
NUM_EMPLEADO INT PRIMARY KEY,
APELLIDO VARCHAR(50),
OFICIO VARCHAR(50),
DIRECCION VARCHAR(50),
FECHA_ALTA DATE,
SALARIO DECIMAL(10,2),
COMISION DECIMAL(4,2),
NUM_DPTO INT);

DESCRIBE EMPLEADOS;

CREATE TABLE DEPARTAMENTO(
NUM_DPTO INT PRIMARY KEY,
NOMBRE VARCHAR(50),
LOCALIDAD VARCHAR(50));

DESCRIBE DEPARTAMENTO;

-- MODIFICACIONES DE LAS TABLAS
ALTER TABLE EMPLEADOS
MODIFY APELLIDO VARCHAR(50) NOT NULL,
MODIFY OFICIO VARCHAR(50) NOT NULL,
MODIFY SALARIO DECIMAL(10,2) NOT NULL,
MODIFY NUM_DPTO INT NOT NULL;

ALTER TABLE EMPLEADOS
MODIFY APELLIDO VARCHAR(50) NOT NULL UNIQUE;

ALTER TABLE EMPLEADOS
ADD CONSTRAINT CHECK(SALARIO>0); 

ALTER TABLE EMPLEADOS
ADD CONSTRAINT CMS CHECK(COMISION>1 AND COMISION<16);

ALTER TABLE EMPLEADOS
DROP INDEX APELLIDO;

ALTER TABLE EMPLEADOS
ADD CONSTRAINT EMP_FK FOREIGN KEY(NUM_DPTO) REFERENCES DEPARTAMENTO(NUM_DPTO) ON UPDATE CASCADE ON DELETE CASCADE;

-- INSERTO DATOS
INSERT INTO DEPARTAMENTO
VALUES (10,'CONTABILIDAD','SEVILLA'),
		(20,'INVESTIGACION','MADRID'),
        (30,'VENTAS','BARCELONA'),
        (40,'PRODUCCION','BILBAO');
        
SELECT * FROM DEPARTAMENTO;

INSERT INTO EMPLEADOS 
VALUES (1,'SERRANO','AUXILIAR','CALLE1','2018/1/1',150.3,2.5,10),
		(2,'LOPEZ','VENDEDOR','CALLE2','2018/1/1',150.3,2.5,30),
        (3,'MARTIN','OPERADOR','CALLE3','2018/1/1',150.3,2.5,40),
        (4,'GOMEZ','ADMINISTRATIVO','CALLE4','2018/1/1',150.3,2.5,20),
        (5,'LOPES','CONTABLE','CALLE5','2018/1/1',150.3,2.5,10);
        
SELECT * FROM EMPLEADOS;

-- MODIFICACIONES DE LAS TABLAS 2
ALTER TABLE EMPLEADOS
MODIFY COMISION DECIMAL(4,2) DEFAULT '10.0';

ALTER TABLE DEPARTAMENTO
ADD CONSTRAINT LOCALIDAD
CHECK(LOCALIDAD IN ('SEVILLA','MADRID','BARCELONA','BILBAO'));

INSERT INTO DEPARTAMENTO 
VALUES (100,'PRUEBAS','SEVILLA');

SELECT * FROM DEPARTAMENTO;


-- CREAR TABLA TIENDA

CREATE TABLE TIENDAS (
NIF varchar(10), 
NOMBRE varchar(20), 
DIRECCION varchar(20), 
POBLACION varchar(20), 
PROVINCIA varchar(20), 
CODPOSTAL char(5));

DESCRIBE TIENDAS;

ALTER TABLE tiendas ADD CONSTRAINT Tien_PK PRIMARY KEY (NIF);

ALTER TABLE TIENDAS
MODIFY NOMBRE VARCHAR(30) NOT NULL;

ALTER TABLE TIENDAS
MODIFY PROVINCIA VARCHAR(20) DEFAULT('CACERES');

ALTER TABLE TIENDAS
MODIFY CODPOSTAL CHAR(5) NOT NULL;

INSERT INTO TIENDAS VALUES
('111111111A','ANA','CALLE 1','PLASENCIA','CACERES','10600'),
('111111112B','MARIA','CALLE 2','PLASENCIA','CACERES','10600'),
('111111123C','JUAN','CALLE 3','NAVALMORAL','CACERES','10300'),
('11111D112B','MARIA','CALLE 2','PLASENCIA','CACERES','10600'),
('11111F123C','JUAN','CALLE 3','NAVALMORAL','CACERES','10300');

SELECT * FROM TIENDAS;

UPDATE TIENDAS SET CODPOSTAL='10000';

DELETE FROM TIENDAS WHERE NOMBRE='ANA';

DESCRIBE TIENDAS;

ALTER TABLE TIENDAS
DROP COLUMN DIRECCION;

CREATE INDEX I_empleados_apellido ON EMPLEADOS(APELLIDO);
