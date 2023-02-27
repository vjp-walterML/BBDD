-- BASE DE DATOS EMPRESA
-- 1ºDAW
-- 27-02-2023
-- WALTER MARTIN LOPES
-- --------------------------------
CREATE DATABASE EMPRESA;
USE EMPRESA;

-- =====================CREACION DE TABLAS=============
CREATE TABLE DEPARTAMENTOS(
DEP_NO INT PRIMARY KEY,
DNOMBRE VARCHAR(14),
LOCALIDAD VARCHAR(10));

CREATE TABLE EMPLEADOS(
EMP_NO INT PRIMARY KEY,
APELLIDO VARCHAR(8),
OFICIO VARCHAR(10),
DIRECTOR INT,
FECHA_ALTA DATE,
SALARIO DECIMAL(6,2),
COMISION DECIMAL(6,2),
DEP_NO INT);

ALTER TABLE EMPLEADOS
ADD CONSTRAINT FK_EMP_DIRECTOR FOREIGN KEY (DIRECTOR) REFERENCES EMPLEADOS(EMP_NO) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE EMPLEADOS
ADD CONSTRAINT FK_EMP_DEP_NO FOREIGN KEY (DEP_NO) REFERENCES DEPARTAMENTOS(DEP_NO) ON DELETE CASCADE ON UPDATE CASCADE;

CREATE TABLE CLIENTES(
CLIENTE_NO INT PRIMARY KEY,
NOMBRE VARCHAR(25),
LOCALIDAD VARCHAR(14),
VENDEDOR_NO INT,
DEBE DECIMAL(9,2),
HABER DECIMAL(9,2),
LIMITE_CREDITO DECIMAL(9,2));

ALTER TABLE CLIENTES
ADD CONSTRAINT FK_CLI_EMP_NO FOREIGN KEY (VENDEDOR_NO) REFERENCES EMPLEADOS(EMP_NO) ON DELETE CASCADE ON UPDATE CASCADE;

CREATE TABLE PEDIDOS(
PEDIDO_NO INT PRIMARY KEY,
PRODUCTO_NO INT,
CLIENTE_NO INT,
UNIDADES INT,
FECHA_PEDIDO DATE);

ALTER TABLE PEDIDOS
ADD CONSTRAINT FK_PEDIDOS_PRODUCTO_NO FOREIGN KEY(PRODUCTO_NO) REFERENCES PRODUCTOS(PRODUCTO_NO) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE PEDIDOS
ADD CONSTRAINT FK_PEDIDOS_CLIENTE_NO FOREIGN KEY(CLIENTE_NO) REFERENCES CLIENTES(CLIENTE_NO) ON DELETE CASCADE ON UPDATE CASCADE;

CREATE TABLE PRODUCTOS(
PRODUCTO_NO INT PRIMARY KEY,
DESCRIPCION VARCHAR(30),
PRECIO_aCTUAL DECIMAL(8,2),
STOCK_DISPONIBLE INT);

-- ===============================CARGA DE DATOS=========================
-- DEPARTAMENTOS
INSERT INTO DEPARTAMENTOS VALUES(10, 'CONTABILIDAD', 'BARCELONA');
INSERT INTO DEPARTAMENTOS VALUES(20, 'INVESTIGACION', 'VALENCIA');
INSERT INTO DEPARTAMENTOS VALUES(30, 'VENTAS',        'MADRID'); 
INSERT INTO DEPARTAMENTOS VALUES(40, 'PRODUCCION',    'SEVILLA');

--## EMPLEADOS
INSERT INTO EMPLEADOS VALUES (7839,'REY',     'PRESIDENTE',NULL,'1981-11-17',6000,   NULL, 10);
INSERT INTO EMPLEADOS VALUES (7698,'GARRIDO', 'DIRECTOR',  7839,'1981-05-01',3850.12,NULL, 30);
INSERT INTO EMPLEADOS VALUES (7782,'MARTINEZ','DIRECTOR',  7839,'1981-06-09',2450,   NULL, 10);
INSERT INTO EMPLEADOS VALUES(7499,'ALONSO',   'VENDEDOR',  7698,'1981-02-23',1400,   400,30);
INSERT INTO EMPLEADOS VALUES (7521,'LOPEZ',   'EMPLEADO',  7782,'1981-05-08',1350.50,NULL,10);      
INSERT INTO EMPLEADOS VALUES (7654,'MARTIN',  'VENDEDOR',  7698,'1981-09-28',1500,   1600, 30);
INSERT INTO EMPLEADOS VALUES (7844,'CALVO',   'VENDEDOR',  7698,'1981-09-08',1800,   0,    30);
INSERT INTO EMPLEADOS VALUES (7876,'GIL',     'ANALISTA',  7782,'1982-05-06',3350,   NULL, 20);
INSERT INTO EMPLEADOS VALUES (7900,'JIMENEZ', 'EMPLEADO',  7782,'1983-03-24',1400,   NULL, 20);	

--## CLIENTES
INSERT INTO CLIENTES VALUES (101, 'DISTRIBUCIONES GOMEZ', 'MADRID', 7499, 0,0,5000);
INSERT INTO CLIENTES VALUES (102, 'LOGITRONICA S.L', 'BARCELONA', 7654,0,0,5000);
INSERT INTO CLIENTES VALUES (103, 'INDUSTRIAS LACTEAS S.A.', 'LAS ROZAS', 7844,0,0, 10000);
INSERT INTO CLIENTES VALUES (104, 'TALLERES ESTESO S.A.', 'SEVILLA', 7654, 0, 0, 5000);
INSERT INTO CLIENTES VALUES (105, 'EDICIONES SANZ', 'BARCELONA', 7499, 0,0,5000);
INSERT INTO CLIENTES VALUES (106, 'SIGNOLOGIC S.A.', 'MADRID', 7654,0,0,5000);
INSERT INTO CLIENTES VALUES (107, 'MARTIN Y ASOCIADOS S.L.', 'ARAVACA' , 7844,0,0, 10000);
INSERT INTO CLIENTES VALUES (108, 'MANUFACTURAS ALI S.A.', 'SEVILLA', 7654, 0, 0, 5000);

--## PRODUCTOS
INSERT INTO PRODUCTOS VALUES(10,'MESA DESPACHO MOD. GAVIOTA', 550, 50);
INSERT INTO PRODUCTOS VALUES (20, 'SILLA DIRECTOR MOD. BUFALO', 670, 25);
INSERT INTO PRODUCTOS VALUES (30, 'ARMARIO NOGAL DOS PUERTAS', 460, 20);
INSERT INTO PRODUCTOS VALUES (40, 'MESA MODELO UNIÓN',340, 15);
INSERT INTO PRODUCTOS VALUES (50, 'ARCHIVADOR CEREZO',1050, 20);
INSERT INTO PRODUCTOS VALUES (60, 'CAJA SEGURIDAD MOD B222', 280, 15);
INSERT INTO PRODUCTOS VALUES (70, 'DESTRUCTORA DE PAPEL A3',450, 25);
INSERT INTO PRODUCTOS VALUES (80, 'MODULO ORDENADOR MOD. ERGOS', 550, 25);

--## PEDIDOS

INSERT INTO PEDIDOS VALUES(1000, 20, 103, 3, '1999-10-06');
INSERT INTO PEDIDOS VALUES(1001, 50, 106, 2, '1999-10-06');
INSERT INTO PEDIDOS VALUES(1002, 10, 101, 4, '1999-10-07');
INSERT INTO PEDIDOS VALUES(1003, 20, 105, 4, '1999-10-16');
INSERT INTO PEDIDOS VALUES(1004, 40, 106, 8, '1999-10-20');
INSERT INTO PEDIDOS VALUES(1005, 30, 105, 2, '1999-10-20');
INSERT INTO PEDIDOS VALUES(1006, 70, 103, 3, '1999-11-03');
INSERT INTO PEDIDOS VALUES(1007, 50, 101, 2, '1999-11-06');
INSERT INTO PEDIDOS VALUES(1008, 10, 106, 6, '1999-11-16');
INSERT INTO PEDIDOS VALUES(1009, 20, 105, 2, '1999-11-26');
INSERT INTO PEDIDOS VALUES(1010, 40, 102, 3, '1999-12-08');
INSERT INTO PEDIDOS VALUES(1011, 30, 106, 2, '1999-12-15');
INSERT INTO PEDIDOS VALUES(1012, 10, 105, 3, '1999-12-06');
INSERT INTO PEDIDOS VALUES(1013, 30, 106, 2, '1999-12-06');
INSERT INTO PEDIDOS VALUES(1014, 20, 101, 4, '2000-01-07');
INSERT INTO PEDIDOS VALUES(1015, 70, 105, 4, '2000-01-16');
INSERT INTO PEDIDOS VALUES(1017, 20, 105, 6, '2000-01-20');


-- =====================CONSULTAS CON AGRUPAMIENTO Y FUNCIONES DE GRUPO=====================
-- 1. Obtener, para cada departamento, cuantos DIRECTORES hay en ese departamento y cuál es su salario medio.
SELECT D.DNOMBRE AS DEPARTAMENTO, COUNT(E.DIRECTOR) AS NUMERO_DIRECTORES, AVG(SALARIO) AS SALARIO_MEDIO
FROM DEPARTAMENTOS AS D INNER JOIN EMPLEADOS AS E
ON D.DEP_NO = E.DEP_NO
GROUP BY DEPARTAMENTO;
-- 2. Obtener los salarios medios por departamento, ordenados descendentemente por dicho importe, cuando dichos salarios medios sean inferiores a 3000 euros.
SELECT D.DNOMBRE AS DEPARTAMENTO,AVG(SALARIO) AS SALARIO_MEDIO
FROM DEPARTAMENTOS AS D INNER JOIN EMPLEADOS AS E
ON D.DEP_NO = E.DEP_NO
GROUP BY DEPARTAMENTO
HAVING SALARIO_MEDIO<3000
ORDER BY SALARIO_MEDIO DESC;
-- 3. Obtener el total de unidades por producto que hay entre todos los pedidos, visualizando el número de producto, la descripción y la suma.
SELECT PRO.PRODUCTO_NO AS NUMERO_PRODUCTO,PRO.DESCRIPCION,COUNT(P.PEDIDO_NO) AS UNIDADES
FROM PRODUCTOS AS PRO INNER JOIN PEDIDOS AS P
ON PRO.PRODUCTO_NO = P.PRODUCTO_NO
GROUP BY NUMERO_PRODUCTO;
-- 4. Mostrar los números de cliente que tengan más de dos pedidos (contar los pedidos), ordenado por cantidad de pedidos
SELECT C.CLIENTE_NO AS NUMERO_CLIENTE,COUNT(P.PEDIDO_NO) AS NUMERO_PEDIDOS
FROM CLIENTES AS C INNER JOIN PEDIDOS AS P
ON C.CLIENTE_NO = P.CLIENTE_NO
GROUP BY NUMERO_CLIENTE
ORDER BY NUMERO_PEDIDOS;
-- 5. Obtener las localidades en las que haya más de un cliente, visualizando cuantos clientes hay (contar).
SELECT LOCALIDAD, COUNT(CLIENTE_NO) AS NUMERO_CLIENTES
FROM CLIENTES 
GROUP BY LOCALIDAD
HAVING NUMERO_CLIENTES>1;
-- 6. Obtener Los datos de los 4 productos de los que más unidades se han vendido, visualizando el número de producto y las unidades vendidas
SELECT PRO.PRODUCTO_NO AS NUMERO_PRODUCTO,COUNT(P.PEDIDO_NO) AS UNIDADES_VENDIDAS
FROM PRODUCTOS AS PRO INNER JOIN PEDIDOS AS P
ON PRO.PRODUCTO_NO = P.PRODUCTO_NO
GROUP BY NUMERO_PRODUCTO
ORDER BY UNIDADES_VENDIDAS DESC
LIMIT 4;
-- 7. Mostrar todos los oficios y el número de empleados de la empresa que los desempeñan cada oficio.
SELECT OFICIO, COUNT(EMP_NO) AS NUMERO_EMPLEADOS
FROM EMPLEADOS
GROUP BY OFICIO;
-- 8. Visualizar todos los oficios y el número de empleados de la empresa que lo desempeñan, siempre que lo desempeñe más de un empleado.
SELECT OFICIO, COUNT(EMP_NO) AS NUMERO_EMPLEADOS
FROM EMPLEADOS
GROUP BY OFICIO
HAVING NUMERO_EMPLEADOS>1;
-- 9. Calcular la masa salarial (salario + comisión) anual de la empresa, suponiendo 14 pagas para cada empleado.
UPDATE EMPLEADOS
SET COMISION = 0
WHERE COMISION IS NULL;

SELECT (SUM(SALARIO+COMISION)*14) AS MASA FROM EMPLEADOS;
-- 10. Obtener el número de empleados de la empresa que realizan cada oficio en cada departamento
SELECT D.DNOMBRE AS DEPARTAMENTO,E.OFICIO,COUNT(E.EMP_NO) AS NUMERO_EMPLEADOS
FROM DEPARTAMENTOS AS D INNER JOIN EMPLEADOS AS E
ON D.DEP_NO = E.DEP_NO
GROUP BY DEPARTAMENTO,OFICIO;
-- 11. Calcular el número de oficios distintos que hay en el departamento 30 de la tabla de empleados
SELECT DISTINCT COUNT(OFICIO) AS NUMERO_OFICIOS, DEP_NO AS DEPARTAMENTO
FROM EMPLEADOS
WHERE DEP_NO = 30
GROUP BY DEP_NO;
-- 12. Obtener las fechas de pedido del pedido más antiguo y el más reciente de cada producto, mostrando también el número de producto correspondiente
SELECT PRODUCTO_NO AS NUMERO_PRODUCTO, MAX(FECHA_PEDIDO) AS PEDIDO_RECIENTE, MIN(FECHA_PEDIDO) AS PEDIDO_ANTIGUO
FROM PEDIDOS
GROUP BY NUMERO_PRODUCTO;
-- 13. Obtener el total de euros que hay invertidos entre todos los productos disponibles, mostrar también la descripción del producto.
-- 14. Obtener los salarios medios por departamentos de los vendedores y cuántos hay en cada departamento. Mostrar solo aquellos departamentos en los que ese salario medio sea > 1.200
-- 15. Obtener el número de departamento con mayor salario medio de sus empleados, visualizando también el valor del salario medio correspondiente.
-- 16. Mostrar las unidades totales vendidas de cada producto a cada cliente, mostrando el número de producto, el número de cliente y la suma de las unidades
-- 17. Obtener aquellos productos de los que se han realizado más de DOS pedidos y que tengan fecha de pedido anterior a 1 de enero del 2000.
-- 18. Obtener los datos de los 2 clientes clientes con mayor número de pedidos, indicando también cuantos pedidos han hecho