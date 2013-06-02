CREATE TABLE locations (
id serial primary key,
loc_id integer NOT NULL,
plz text NOT NULL,
name VARCHAR (255) NOT NULL,
vorwahl text,
einwohner integer,
flaeche float,
amt varchar(255),
kz varchar(3),
lat numeric(10,8) NOT NULL,
lon numeric(11,8) NOT NULL
);