INSERT INTO zi p_ c oo rd in a te s ( zc_loc_id , zc_zip , zc_location_name , zc_lat , zc_lon )
	SELECT gl.loc_id, plz.text_val1 as plz, name.text_val1 as name, vorwahl.text_val1 as vorwahl, einw.int_val as einwohner, 
		flaeche.float_val as flaeche, amt.text_val1 as amt, kz.text_val1 as kz, coord.lat,coord.lon
	FROM geodb_textdata plz
	LEFT JOIN geodb_textdata name ON plz.loc_id = name.loc_id
	LEFT OUTER JOIN geodb_textdata vorwahl ON (plz.loc_id = vorwahl.loc_id AND vorwahl.text_type = 500400000)
	LEFT OUTER JOIN geodb_floatdata flaeche ON (plz.loc_id = flaeche.loc_id AND flaeche.float_type = 610000000)
	LEFT OUTER JOIN geodb_intdata einw ON (plz.loc_id = einw.loc_id AND einw.int_type = 600700000)
	LEFT OUTER JOIN geodb_textdata amt ON (plz.loc_id = amt.loc_id AND amt.text_type = 500700000)
	LEFT OUTER JOIN geodb_textdata kz ON (plz.loc_id = kz.loc_id AND kz.text_type = 500500000)
	LEFT OUTER JOIN geodb_locations gl ON (plz.loc_id = gl.loc_id AND gl.loc_type IN (100600000 ,100700000))
	LEFT OUTER JOIN geodb_coordinates coord ON plz.loc_id = coord.loc_id
	WHERE plz.text_type = 500300000
	AND name.text_type = 500100000 ORDER by name, plz;