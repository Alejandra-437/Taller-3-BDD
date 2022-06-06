USE TALLER_03_DATABANK;

/* Consultas: */

 ---- CONSULTA 1 ----

/*  1. Mostrar la lista de clientes que han contratado el plan "Premium". Ordenar el resultado con respecto al id del cliente en orden ascendente. Almacenar el resultado en una nueva tabla llamada "CLIENTES_PREMIUM�. */

SELECT C.id, C.nombre, C.direccion, TP.tipo
INTO CLIENTES_PREMIUM
FROM CLIENTE C
INNER JOIN TIPO_PLAN TP
ON C.id_tipo_plan = TP.id
WHERE TP.tipo = 'Premium'
ORDER BY C.id ASC;

 ---- CONSULTA 2 ----

/* 2. Mostrar las 2 cl�nicas m�s populares. El par�metro de popularidad se define en base al n�mero de citas registradas por cada cl�nica. Mostrar el id de la cl�nica, el nombre, su direcci�n y email, adem�s mostrar la cantidad de citas registradas. Ordenar el resultado en base a la cantidad de citas registradas. */
SELECT TOP 2 CL.id, CL.nombre CLinica, CL.direccion Direccion, CL.email Correo_Electronico, COUNT(CI.id) 'Citas'  FROM Clinica CL
INNER JOIN cita CI
ON CI.id_clinica = CL.id
GROUP BY CL.id, CL.nombre, CL.direccion,CL.email
ORDER BY COUNT(CI.id) DESC;


 ---- CONSULTA 3 ----

/* 3. Mostrar la informaci�n completa de cada cliente, incluir el nombre, direcci�n, el tipo de plan, los correos (si es que ha brindado alguno) y los tel�fonos (si es que ha brindado alguno). Ordenar el resultado con respecto al id del cliente en orden ascendente.  */
SELECT c.id,c.nombre 'Nombre', c.direccion 'Direcci�n', planC.tipo 'Plan', email.correo 'Email Cliente', tel.telefono 'Telefono'
FROM CLIENTE c
LEFT JOIN CORREO_CLIENTE email
    ON c.id =  email.id_cliente
LEFT JOIN TELEFONO_CLIENTE tel
    ON c.id =  tel.id_cliente
inner JOIN TIPO_PLAN planC
    ON c.id_tipo_plan =  planC.id
ORDER BY c.id ASC
;

---- CONSULTA 4 ----

/* 4. Identificar las consultas que han necesitado de un m�dico asistente, mostrar el id de la consulta, la fecha, la duraci�n, el id del m�dico y el nombre del m�dico asistente. Ordenar el resultado con respecto al id de la consulta en orden ascendente.  */
SELECT C.id 'id_consulta', C.fecha, C.duracion, M.id 'id_m�dico', M.nombre 'm�dico_asistente' FROM CONSULTA C
INNER JOIN MEDICOXCONSULTA MC
ON C.id = MC.id_consulta
INNER JOIN MEDICO M
ON MC.id_medico = M.id
WHERE MC.rol = 0
ORDER BY C.id ASC;
---- CONSULTA 5 ----


/* 5. �Cu�les son las cl�nicas capacitadas para atender emergencias? Mostrar el id de la cl�nica, el nombre, la direcci�n y email. */
SELECT DISTINCT cl.id, cl.nombre 'Nombre Clinica', cl.direccion 'Direcci�n Clinica', cl.email 'Cliente', cl.telefono 'Telefono'
FROM CLINICA cl
inner JOIN EMERGENCIA em
    ON em.id_clinica = cl.id
;

---- CONSULTA 6 ----

/* 6. Calcular las ganancias de la asociaci�n en la primera quincena de mayo. Mostrar la fecha de la consulta, el nombre del cliente atendido y el nombre del m�dico principal. Se debe considerar que existe la posibilidad de que haya consultas en las que no se recete ning�n medicamento. Ordenar el resultado con respecto al id de la consulta en orden ascendente. Las ganancias de cada consulta se calculan de la siguiente forma: (Precio de la consulta + Suma de todos los medicamentos recetados) + 13% IVA.  */
SELECT CO.fecha, CL.nombre, ME.nombre, ISNULL(SUM(MD.precio),0) 'subtotal_medicamentos', CO.precio 'precio_consulta', 
CAST(ROUND(((CO.precio + ISNULL(SUM(MD.precio),0))*0.13 + (CO.precio + ISNULL(SUM(MD.precio),0))),2) AS DECIMAL(8,2)) 'total_consulta'
FROM CONSULTA CO
INNER JOIN CLIENTE CL
ON CO.id_cliente = CL.id
INNER JOIN MEDICOXCONSULTA MC
ON MC.id_consulta = CO.id
INNER JOIN MEDICO ME
ON MC.id_medico = ME.id
LEFT JOIN RECETA RE
ON RE.id_consulta = CO.id
LEFT JOIN MEDICAMENTO MD
ON RE.id_medicamento = MD.id
WHERE MC.rol = 1 AND ((MONTH(CO.fecha) = 5) AND (YEAR(CO.fecha) = 2022) AND (DAY(CO.fecha) BETWEEN 1 AND 15))
GROUP BY CO.id, CO.fecha, ME.nombre, CL.nombre,CO.precio
ORDER BY CO.id ASC;


---- CONSULTA 7 ----

/* 7. El comit� de direcci�n planea realizar una fuerte inversi�n con el objetivo de establecer a la asociaci�n como el consorcio l�der a nivel nacional, para verificar la viabilidad del proyecto, el comit� ha solicitado un reporte especial que consiste en mostrar las ganancias del mes de mayo de 2022 pero organizadas en base a 4 grupos de fechas. Por acuerdo del comit�, los 4 grupos son los siguientes: 
                -- Semana 1:    Del 1 al 8 de mayo.     
                -- Semana 2:    Del 8 al 15 de mayo.        tal vez deberia ser del 9 al 15
                -- Semana 3:    Del 16 al 22 de mayo.       
                -- Semana 4:    Del 22 al 31 de mayo.       tal vez deberia ser del 23 al 31*/

SELECT CO.fecha  semana ,CAST(ROUND(((CO.precio + ISNULL(SUM(MD.precio),0))*0.13 + (CO.precio + ISNULL(SUM(MD.precio),0))),2) AS DECIMAL(8,2))  ganancia_semanal FROM consulta CO
INNER JOIN CLIENTE CL
ON CO.id_cliente = CL.id
INNER JOIN RECETA RE
ON RE.id_consulta = CO.id
INNER JOIN MEDICAMENTO MD
ON RE.id_medicamento = MD.id
GROUP BY CO.id, CO.fecha,CO.precio
WHERE case when ((MONTH(CO.fecha) = 5) AND (YEAR(CO.fecha) = 2022) AND (DAY(CO.fecha) BETWEEN 1 AND 15))THEN 'Semana 1'
ORDER BY CO.id asc;