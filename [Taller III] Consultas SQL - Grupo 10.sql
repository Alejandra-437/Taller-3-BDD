
USE TALLER_03_DATABANK;


/* Consultas: */

 ---- CONSULTA 1 ----

/*  1. Mostrar la lista de clientes que han contratado el plan "Premium". Ordenar el resultado con respecto al id del cliente en orden ascendente. Almacenar el resultado en una nueva tabla llamada "CLIENTES_PREMIUM”. */



 ---- CONSULTA 2 ----

/* 2. Mostrar las 2 clínicas más populares. El parámetro de popularidad se define en base al número de citas registradas por cada clínica. Mostrar el id de la clínica, el nombre, su dirección y email, además mostrar la cantidad de citas registradas. Ordenar el resultado en base a la cantidad de citas registradas. */



 ---- CONSULTA 3 Fer----

/* 3. Mostrar la información completa de cada cliente, incluir el nombre, dirección, el tipo de plan, los correos (si es que ha brindado alguno) y los teléfonos (si es que ha brindado alguno). Ordenar el resultado con respecto al id del cliente en orden ascendente.  */


SELECT c.id,c.nombre 'Nombre', c.direccion 'Dirección', planC.tipo 'Plan', email.correo 'Email Cliente', tel.telefono 'Telefono'
FROM CLIENTE c
INNER JOIN CORREO_CLIENTE email
    ON c.id =  email.id_cliente
INNER JOIN TELEFONO_CLIENTE tel
    ON c.id =  tel.id_cliente
INNER JOIN TIPO_PLAN planC
    ON c.id_tipo_plan =  planC.id
ORDER BY c.id ASC
;

---- CONSULTA 4 ----

/* 4. Identificar las consultas que han necesitado de un médico asistente, mostrar el id de la consulta, la fecha, la duración, el id del médico y el nombre del médico asistente. Ordenar el resultado con respecto al id de la consulta en orden ascendente.  */


---- CONSULTA 5 Fer ----


/* 5. ¿Cuáles son las clínicas capacitadas para atender emergencias? Mostrar el id de la clínica, el nombre, la dirección y email. */


SELECT cl.id, cl.nombre 'Nombre Clinica', cl.direccion 'Dirección Clinica', cl.email 'Cliente', cl.telefono 'Telefono'
FROM CLINICA cl
INNER JOIN EMERGENCIA em
    ON cl.id = em.id_clinica
;
---- CONSULTA 6 ----

/* 6. Calcular las ganancias de la asociación en la primera quincena de mayo. Mostrar la fecha de la consulta, el nombre del cliente atendido y el nombre del médico principal. Se debe considerar que existe la posibilidad de que haya consultas en las que no se recete ningún medicamento. Ordenar el resultado con respecto al id de la consulta en orden ascendente. Las ganancias de cada consulta se calculan de la siguiente forma: (Precio de la consulta + Suma de todos los medicamentos recetados) + 13% IVA.  */


---- CONSULTA 7 ----

/* 7. El comité de dirección planea realizar una fuerte inversión con el objetivo de establecer a la asociación como el consorcio líder a nivel nacional, para verificar la viabilidad del proyecto, el comité ha solicitado un reporte especial que consiste en mostrar las ganancias del mes de mayo de 2022 pero organizadas en base a 4 grupos de fechas. Por acuerdo del comité, los 4 grupos son los siguientes: 

                -- Semana 1:    Del 1 al 8 de mayo.     
                -- Semana 2:    Del 8 al 15 de mayo.        tal vez deberia ser del 9 al 15
                -- Semana 3:    Del 16 al 22 de mayo.       
                -- Semana 4:    Del 22 al 31 de mayo.       tal vez deberia ser del 23 al 31

Realizar una consulta que permita mostrar las ganancias distribuidas en los 4 rangos de fechas presentadas. Considerar subconsultas. Sugerencia: investigar el uso de la estructura CASE.*/
