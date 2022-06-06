USE TALLER_03_DATABANK;

/* Consultas: */

 ---- CONSULTA 1 ----

/*  1. Mostrar la lista de clientes que han contratado el plan "Premium". Ordenar el resultado con respecto al id del cliente en orden ascendente. Almacenar el resultado en una nueva tabla llamada "CLIENTES_PREMIUM”. */



 ---- CONSULTA 2 ----

/* 2. Mostrar las 2 clínicas más populares. El parámetro de popularidad se define en base al número de citas registradas por cada clínica. Mostrar el id de la clínica, el nombre, su dirección y email, además mostrar la cantidad de citas registradas. Ordenar el resultado en base a la cantidad de citas registradas. */
SELECT TOP 2 CL.id, CL.nombre CLinica, CL.direccion Direccion, CL.email Correo_Electronico, COUNT(CI.id) 'Citas'  FROM Clinica CL
INNER JOIN cita CI
ON CI.id_clinica = CL.id
GROUP BY CL.id, CL.nombre, CL.direccion,CL.email
ORDER BY COUNT(CI.id) DESC;


 ---- CONSULTA 3 ----

/* 3. Mostrar la información completa de cada cliente, incluir el nombre, dirección, el tipo de plan, los correos (si es que ha brindado alguno) y los teléfonos (si es que ha brindado alguno). Ordenar el resultado con respecto al id del cliente en orden ascendente.  */


---- CONSULTA 4 ----

/* 4. Identificar las consultas que han necesitado de un médico asistente, mostrar el id de la consulta, la fecha, la duración, el id del médico y el nombre del médico asistente. Ordenar el resultado con respecto al id de la consulta en orden ascendente.  */

---- CONSULTA 5 ----


/* 5. ¿Cuáles son las clínicas capacitadas para atender emergencias? Mostrar el id de la clínica, el nombre, la dirección y email. */


---- CONSULTA 6 ----

/* 6. Calcular las ganancias de la asociación en la primera quincena de mayo. Mostrar la fecha de la consulta, el nombre del cliente atendido y el nombre del médico principal. Se debe considerar que existe la posibilidad de que haya consultas en las que no se recete ningún medicamento. Ordenar el resultado con respecto al id de la consulta en orden ascendente. Las ganancias de cada consulta se calculan de la siguiente forma: (Precio de la consulta + Suma de todos los medicamentos recetados) + 13% IVA.  */
SELECT Co.id id_consulta, CO.fecha Fecha, CLI.nombre nombre_cliente, MED.nombre nombre_medico, SUM(ME.precio)subtotal_medicamento, CO.precio precio_consulta, CO.precio+SUM(ME.precio)+0.13 total_consulta FROM consulta CO
INNER JOIN cliente CLI
	ON CLI.id = CO.id
INNER JOIN MEDICOXCONSULTA MC
	ON MC.id_consulta = CO.id
INNER JOIN MEDICO MED
	ON  MED.id = MC.id_medico 
INNER JOIN RECETA RE
	ON RE.id_consulta= Co.id
INNER JOIN MEDICAMENTO ME
	ON ME.id= RE.id_medicamento
WHERE MC.rol = 1 AND CO.fecha BETWEEN '2022-05-01 9:00:00:000'AND'2022-05-15 9:00:00:000'
GROUP BY CO.fecha,CLI.nombre, MED.nombre, CO.id, CO.precio
ORDER BY CO.id ASC;
 
 



---- CONSULTA 7 ----

/* 7. El comité de dirección planea realizar una fuerte inversión con el objetivo de establecer a la asociación como el consorcio líder a nivel nacional, para verificar la viabilidad del proyecto, el comité ha solicitado un reporte especial que consiste en mostrar las ganancias del mes de mayo de 2022 pero organizadas en base a 4 grupos de fechas. Por acuerdo del comité, los 4 grupos son los siguientes: 
                -- Semana 1:    Del 1 al 8 de mayo.     
                -- Semana 2:    Del 8 al 15 de mayo.        tal vez deberia ser del 9 al 15
                -- Semana 3:    Del 16 al 22 de mayo.       
                -- Semana 4:    Del 22 al 31 de mayo.       tal vez deberia ser del 23 al 31*/

SELECT CO.fecha Fecha,CO.precio + SUM(ME.id)+ 0.13 Ganancias FROM consulta CO
INNER JOIN RECETA RE
	ON RE.id_consulta= Co.id
INNER JOIN MEDICAMENTO ME
	ON ME.id= RE.id_consulta
WHERE  CO.fecha BETWEEN '2022-05-01 9:00:00:000'AND'2022-05-15 9:00:00:000'
GROUP BY CO.fecha, CO.id, CO.precio
ORDER BY Co.id ASC;

Select*from consulta
WHERE  fecha BETWEEN '2022-05-01 9:00:00:000'AND'2022-05-15 9:00:00:000';
 
 
 select*from medicamento;
 select*from receta;