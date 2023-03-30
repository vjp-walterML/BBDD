-- --------------------------------------------------------------------------------
-- BASE DE DATOS NUEVAEMPRESA2020Actualizada
-- 1º DAW
-- 14-03-2023
-- WALTER MARTIN LOPES
-- ------------------------------------------------------------------------------
USE NUEVAEMPRESA2020;

-- CONSULTAS PARA MODIFICAR TABLAS USANDO SUBCONSULTAS | CREACIÓN DE VISTAS.

-- 1. Añadir 100 euros de comisión a los empleados tengan una comisión menor de 500 euros o nula
UPDATE EMPLEADOS
SET COMISION = COALESCE(COMISION,0) + 100
WHERE EMP_NO IN (SELECT * FROM(SELECT EMP_NO FROM EMPLEADOS
				 WHERE COMISION < 500 
				 OR COMISION IS NULL) AS TABLA);

-- 2. Borrar al empleado MARTINEZ . Antes, en otra sentencia aparte ejecutada anteriormente modifica aquellos empleados de los que sea jefe MARTINEZ poniéndoles como jefe a GARRIDO (CODIGO 7698). (UTILIZA SUBCONSULTA PARA AVERIGUAR EL CODIGO DE MARTINEZ ). Después, borra a Martínez.
UPDATE EMPLEADOS
SET DIRECTOR = 7698
WHERE DIRECTOR = (SELECT * FROM (SELECT EMP_NO FROM EMPLEADOS
				  WHERE APELLIDO = 'MARTINEZ')AS TABLA);
                  
DELETE FROM EMPLEADOS
WHERE APELLIDO = 'MARTINEZ';

-- 3. Crear la vista EMPLEADOS_GARRIDO que incluirá los datos: empleado_no, apellido, salario_anual de los empleados cuyo jefe es GARRIDO (salario_anual se calcula multiplicando salario * 14)
CREATE VIEW EMPLEADOS_GARRIDO AS
SELECT EMP_NO,APELLIDO,(SALARIO*14) AS SALARIO_ANUAL FROM EMPLEADOS
WHERE DIRECTOR = (SELECT EMP_NO FROM EMPLEADOS WHERE APELLIDO ='GARRIDO');

SELECT * FROM EMPLEADOS_GARRIDO;

-- 4. Crear una vista RESUMEN_DEP de los departamentos, incluyendo todos los departamentos hasta los que no tengan ningún empleado. La información que se pide es:
-- · Nombre del departamento--> esta columna se llamará departamento
-- · Número de empleados-->esta columna se llamará empleados
-- · Suma de sus salario-->esta columna se llamará salarios
-- · Suma de sus comisiones-->esta columna se llamará comisiones
