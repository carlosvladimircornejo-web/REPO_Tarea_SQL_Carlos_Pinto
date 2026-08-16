select * from owners
-- Tarea Prof Carlos Pinto 

-- CONSULTA 1    INSERTANDO PRPIETARIO    
INSERT INTO owners
VALUES (23,'carlos', 
'Cornejo',
'INBEFIC', 
'ztetwo@gmail.com',
'7839 9232',
'CP-1970',
'Cumbres San Bartolo',
'casa 26',
'Ilopango',
'San Salvador',
'El Salvador',
'00001',
'2026-08-15 01:23:25.356206',
'2026-04-15 01:23:25.356206')

select * from accommodations
-- CONSULTA 2               crear alojamiento

INSERT INTO accommodations
VALUES (23,20,2,20,
'Villa Cornejo',
'Al fin estoy haciendo la tarea :,', 
4,3,1,200.53,'USD','12:00:00','10:00:00','true',
'2026-04-15 01:23:25.356206',
'2026-04-15 01:23:25.356206')

select * from guests
-- CONSULTA 3          insertar huesped y reserva

INSERT INTO guests       
VALUES (101,'Carlos','Cornejo','depinto@gmail.com',
'2253 4830','1970-10-06','Salvadoreño','ES102010','Adela de Cornejo',
'7124 5649','2026-04-15 23:25.356206','2026-04-15 23:25.356206')


select * from payments
-- CONSULTA 4         insertar pago

INSERT INTO payments
VALUES (91,44,'2026-04-15 01:23:25.356206',300.12,'EFECTIVO','Completo',
'82fc443e-27d4-4051-972d-eea25d71c644','No dejo propina',
'2026-04-15 01:23:25.356226')

select * from accommodations
--CONSULTA 5             filtrar alojamientos activos 
SELECT * FROM accommodations where is_active = true


select * from guests
--CONSULTA 6             filtrar huespedes por nacionalidad

SELECT * FROM guests 
WHERE nationality = 'Mexico' OR nationality = 'Salvadoreño'


--Tarea Prof Carlos Pinto
select * from bookings
--CONSULTA 7            entre fechas de reserva

SELECT * 
FROM bookings
WHERE check_in_date BETWEEN '2025-09-17' AND '2025-10-15'

SELECT * FROM accommodations
--Tarea Prof Carlos Pinto

--CONSULTA 8          modificar precio
UPDATE accommodations
SET base_price_per_night = 150.00 
WHERE accommodation_id = 23;

 
SELECT * FROM accommodations
--Tarea Prof Carlos Pinto
--CONSULTA 9             actualizar reserva

UPDATE accommodations
SET is_active = false 
WHERE accommodation_id = 23;


SELECT * FROM reviews
--Tarea Prof Carlos Pinto
--CONSULTA 10               eliminar reseeña

DELETE FROM reviews
WHERE review_id = 58


--CONSULTA 11                 Reserva + huesped
SELECT a.booking_id,a.room_id,a.check_in_date,a.check_out_date,
       b.first_name,b.last_name,b.email,b.phone,
	   b.first_name AS RESERVA
FROM bookings AS a JOIN guests AS b
 ON a.guest_id = b.guest_id



 -- consulta 14         sin reseñas
SELECT 
    a.accommodation_id,
    a.name
FROM accommodations AS a
LEFT JOIN reviews AS r 
    ON a.accommodation_id = r.accommodation_id
WHERE r.review_id IS NULL

--consulta 15                 sin reservas
SELECT 
    g.guest_id,
    g.first_name,
    g.last_name
FROM guests AS g
LEFT JOIN bookings AS b 
    ON g.guest_id = b.guest_id
WHERE b.booking_id IS NULL


 --CONSULTA 16               total ingresos
 SELECT SUM(amount) AS Total_ingresos FROM payments

  
 --CONSULTA 17               Promedio ratings
 SELECT AVG(rating) AS promedio_ratings
FROM reviews
--consulta 18               Top de alojamientos
ELECT 
    a.name,
    ROUND(AVG(r.rating), 1) AS rating_promedio,
    COUNT(r.review_id) AS total_resenas
FROM accommodations AS a
INNER JOIN reviews AS r 
    ON a.accommodation_id = r.accommodation_id
GROUP BY 
    a.accommodation_id, 
    a.name
ORDER BY rating_promedio DESC
LIMIT 5

--consulta 19          mas de 3 reservas

SELECT 
    g.first_name,
    g.last_name,
    COUNT(r.booking_id) AS total_bookings
FROM guests AS g
INNER JOIN bookings AS r 
    ON g.guest_id = r.guest_id
GROUP BY 
    g.guest_id, 
    g.first_name,
    g.last_name
HAVING COUNT(r.booking_id) > 3
ORDER BY total_bookings DESC


-- consulta 20    Alojamiento mas caro
SELECT 
    a.accommodation_id,
    a.name, 
    a.base_price_per_night
FROM accommodations AS a
INNER JOIN (
    SELECT MAX(base_price_per_night) AS max_price
    FROM accommodations
) AS subq 
    ON a.base_price_per_night = subq.max_price



