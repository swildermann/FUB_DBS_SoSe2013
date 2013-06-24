CREATE OR REPLACE FUNCTION shortest_distance() RETURNS VOID AS '

DECLARE
BEGIN

	FOR i in 1..61832 LOOP
 	-- for all the data
		INSERT INTO shortest_distance (select wetterstation.s_id, wetterstation.standort, 
		locations.id,locations.name, "distance"(locations.lat,locations.lon,
		wetterstation.geo_breite,wetterstation.geo_laenge) 
		as Distanz from locations, wetterstation where
		locations.id=i ORDER BY Distanz LIMIT 1);

	END LOOP;


END;'
LANGUAGE 'plpgsql';
