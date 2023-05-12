-- BASE DE DATOS BIBLIOTECA
-- 1ºDAW
-- 11-05-2023
-- WALTER MARTIN LOPES
-- --------------------------------
CREATE DATABASE BIBLIOTECA;
USE BIBLIOTECA;

-- CREATE TABLE 
CREATE TABLE LIBROS(
CODLIB INT PRIMARY KEY,
TITULO VARCHAR(50),
AUTORES VARCHAR(60),
TEMATICA VARCHAR(20) CHECK( TEMATICA IN('Fisica','Optica','Mecanica','Electricidad')));

CREATE TABLE SOCIOS(
CODSOCIO INT PRIMARY KEY,
NOMBRE VARCHAR(40),
DIR VARCHAR(60),
POBLACION VARCHAR(5),
TEL VARCHAR(9),
TOTALPRES INT DEFAULT 0);

CREATE TABLE PRESTAMOS(
CODLIB INT,
CODSOCIO INT,
FECHAPRES DATE,
FECHADEV DATE DEFAULT NULL,
PRIMARY KEY(CODLIB,FECHAPRES),
FOREIGN KEY CODLIB_FK (CODLIB) REFERENCES LIBROS (CODLIB) ON UPDATE CASCADE ON DELETE CASCADE,
FOREIGN KEY CODSOCIO_FK (CODSOCIO) REFERENCES SOCIOS (CODSOCIO) ON UPDATE CASCADE ON DELETE CASCADE,
CONSTRAINT FECHAPRES_CHK CHECK (FECHAPRES < FECHADEV));

-- INSERTO DATOS
INSERT INTO SOCIOS  (CODSOCIO,NOMBRE,DIR,POBLACION,CODPOSTAL,TEL)
VALUES 
(1,'ANA GARCIA','c SOL ','PLASENCIA','10600','927000001'),
(2,'LUIS SANCHEZ','c PALMERAS','PLASENCIA','10600','927000002'),
(3,'ANTONIO GARCIA','c LUNA','PLASENCIA','10600','927000003'),
(4,'MARIA SÁNCHEZ','c MAYOR','PLASENCIA','10600','927000004');



INSERT INTO LIBROS( CODLIB, TITULO , AUTORES ,TEMATICA) VALUES
(1,'Fundamentos de física','Andrew Rex y Richard Wolfson','Fisica' ),
(2,'Breves respuestas a las grandes preguntas','Stephen Hawking','Fisica'),
(3,'Física para dummies','Steven Holzner','Fisica'),
(4,'El fascinante mundo de la física','Pablo Vaz','Fisica'),
(5,'Óptica Básica','Daniel Malacara','Optica'),
(6,'Óptica','R. W. Ditchburn','Optica'),
(7,'Fundamentos de óptica','Bruno Rossi','Optica'),
(8,'Manual de Automóviles','Arias Paz','Mecanica'),
(9,'Vehículos eléctricos e híbridos','Oscar Barrera Doblado','Mecanica'),
(10,'Tecnología del automóvil','Manuel Orovio Astudillo','Mecanica'),
(11,'Manual de electricidad básica','Miguel D’Addario','Electricidad'),
(12,'Instalaciones eléctricas y automatismos','Luis Miguel Cerdá Filiu','Electricidad');


INSERT INTO PRESTAMOS (codlib, codsocio,fechapres) VALUES
(1,3,'2020/1/1'),
(2,1,'2020/1/1'),
(3,2,'2020/1/2'),
(4,4,'2020/1/2'),
(1,3,'2020/1/3'),
(6,1,'2020/1/5'),
(5,2,'2020/1/5'),
(8,1,'2020/1/10'),
(12,3,'2020/1/15'),
(3,4,'2020/1/15');

-- **********************************************************************
-- ****************************PROCEDIMIENTOS****************************
-- **********************************************************************
-- 1. Crea un procedimiento para insertar un nuevo registro en la tabla LIBROS. controlando que la tabla existe y que el código del libro a insertar no está duplicado. Los parámetros de entrada al procedimiento serán sólamente el título, autores y temática. Todos los datos del libro entrarán como parámetros del procedimiento.

DELIMITER //
DROP PROCEDURE IF EXISTS PROCEDIMIENTO1;
// CREATE PROCEDURE PROCEDIMIENTO1(P_TITULO VARCHAR(50),P_AUTORES VARCHAR(50),P_TEMATICA VARCHAR(20))
BEGIN
	DECLARE  NOENCONTRADO BOOLEAN DEFAULT FALSE;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET NOENCONTRADO = TRUE;
END; //
DELIMITER ;




-- 2. Crea un procedimiento con un cursor, que inserte los libros de cada temática en tablas independientes. Para ello se creará dentro del procedimiento una tabla para cada temática, todas ellas con los campos CODLIB,TITULO Y AUTORES. El cursor recorre la tabla libros e inserta en las tablas auxiliares según la temática del libro. (NOTA: haz que las tablas auxiliares se borren y creen de nuevo cada vez que se ejecute el procedimiento)

-- **********************************************************************
-- ******************************FUNCIONES*******************************
-- **********************************************************************
-- 1. Crear una función que tome como parámetros una fecha y el código de un socio y cuente los préstamos realizados a ese socio desde el día de la fecha hasta hoy. El resultado a mostrar será una cadena de caracteres donde aparecerá el nombre del socio, la fecha y el número de préstamos que tiene.

-- 2. Crear una función que tome como parámetros un socio y una temática y devuelva un número entero con el número de libros que se han prestado a ese socio de esa temática.

-- **********************************************************************
-- ******************************TIGRETONES******************************
-- **********************************************************************
-- 1. Crea un trigger para controlar la inserción de nuevos préstamos. El trigger se dispara cuando se inserta un nuevo préstamo (la fecha de devolución está a null) y añade UNA UNIDAD AL CAMPO TOTALPRES DEL SOCIO AL QUE SE PRESTA EL LIBRO.

-- 2. Crea un trigger para controlar la modificación del atributo “fechadev” de préstamos, es decir, cuando se devuelve o se modifica a prestado un libro)

-- 3. Crea un trigger para controlar la modificación del atributo CODSOCIO en la tabla PRÉSTAMOS CUANDO SE LE ASIGNA UN PRÉSTAMO A OTRO SOCIO.

-- 4. Crear un disparador para controlar que el número de préstamos sea siempre 0 cuando se inserta un nuevo socio. NOTA: usar signal sqlstate '45000' set message_text = 'Mensaje error' . (El estado 45000 es un estado genérico que representa una "excepción definida por el usuario no controlada).

-- 5. Crear un trigger que controle el borrado de préstamos, restando una unidad cuando al campo totalpres de la tabla SOCIOS cuando el libro haya sido devuelto(sólo se puede hacer si el libro se ha devuelto). El trigger se declarará AFTER DELETE ON PRESTAMOS