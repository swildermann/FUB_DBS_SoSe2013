CREATE TABLE geodb_coordinates (
    loc_id integer NOT NULL,
    coord_type integer NOT NULL,
    lat numeric(10,8),
    lon numeric(11,8),
    coord_subtype integer,
    valid_since integer,
    data_type_since integer,
    valid_until date NOT NULL,
    date_type_until integer NOT NULL
);

