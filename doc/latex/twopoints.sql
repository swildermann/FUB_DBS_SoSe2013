CREATE OR REPLACE FUNCTION distance (Lat1 IN double precision,
                                     Lon1 IN double precision,
                                     Lat2 IN double precision,
                                     Lon2 IN double precision,
                                     Radius IN double precision DEFAULT 6387.7) 
									 RETURNS double precision AS '

DECLARE
		DEGTORAD double precision := 57.29577951;
BEGIN
		RETURN(COALESCE(Radius,0) * ACOS((sin(COALESCE(Lat1,0) / DEGTORAD) * 
		SIN(COALESCE(Lat2,0) / DEGTORAD)) +
        (COS(COALESCE(Lat1,0) / DEGTORAD) * COS(COALESCE(Lat2,0) / DEGTORAD) *
         COS(COALESCE(Lon2,0) / DEGTORAD - COALESCE(Lon1,0)/ DEGTORAD))));
END;'
LANGUAGE 'plpgsql';

