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

CREATE TABLE mediciones_netatmo_unificadas (
    id serial PRIMARY KEY,
    dispositivo_id integer,
    vivienda_id integer,
    temperatura_interior real,
    humedad_interior real,
    co2 real,
    ruido real,
    temperatura_exterior real,
    humedad_exterior real,
    measured_at bigserial,
    date_measured_at timestamp without time zone
);

/* Insertar una medicion */
INSERT INTO mediciones_netatmo
(dispositivo_id, vivienda_id, sector, temperatura, humedad, co2, ruido, measured_at)
VALUES
(250, 'Anderson', 'Jane', DEFAULT);

/* OBTIENE LAS MEDICIONES CON INTERIOR Y EXTERIOR */
/* Nota: hay unos registros que solo registraron el ruido al interior de la casa, entonces por eso se filtra que la temp interior no sea nula para que esos no aparezcan*/
INSERT into "mediciones_netatmo_unificadas" (dispositivo_id, vivienda_id, temperatura_interior, humedad_interior, co2, ruido, temperatura_exterior, humedad_exterior, measured_at, date_measured_at)
SELECT interior.dispositivo_id, interior.vivienda_id, interior.temperatura as temperatura_interior, interior.humedad as humedad_interior, 
interior.co2, interior.ruido, exterior.temperatura as temperatura_exterior, exterior.humedad as humedad_exterior, interior.measured_at, interior.date_measured_at
FROM mediciones_netatmo interior
INNER JOIN mediciones_netatmo exterior ON ((interior.measured_at = exterior.measured_at) AND (interior.vivienda_id = exterior.vivienda_id))
WHERE interior.sector = FALSE AND exterior.sector = TRUE AND interior.temperatura is not NULL
ORDER BY date_measured_at ASC;