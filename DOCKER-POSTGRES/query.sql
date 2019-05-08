/* Crear la tabla */
CREATE TABLE mediciones_netatmo (
    id serial PRIMARY KEY,
    dispositivo_id integer,
    vivienda_id integer,
    sector boolean,
    temperatura real,
    humedad real,
    co2 real,
    ruido real,
    measured_at bigserial,
    date_measured_at timestamp without time zone
);

/* Insertar una medicion */
INSERT INTO mediciones_netatmo
(dispositivo_id, vivienda_id, sector, temperatura, humedad, co2, ruido, measured_at)
VALUES
(250, 'Anderson', 'Jane', DEFAULT);

/* OBTIENE LAS MEDICIONES CON INTERIOR Y EXTERIOR */
SELECT interior.dispositivo_id, interior.vivienda_id, interior.temperatura as temperatura_interior, interior.humedad as humedad_interior, 
interior.co2, interior.ruido, exterior.temperatura as temperatura_exterior, exterior.humedad as humedad_exterior, interior.measured_at, interior.date_measured_at
FROM mediciones_netatmo interior
INNER JOIN mediciones_netatmo exterior ON ((interior.measured_at = exterior.measured_at) AND (interior.vivienda_id = exterior.vivienda_id))
WHERE interior.sector = FALSE AND exterior.sector = TRUE
limit(10);