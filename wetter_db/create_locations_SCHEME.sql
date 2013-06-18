CREATE TABLE locations (
	id serial NOT NULL,
	plz VARCHAR (10),
	name VARCHAR (255),
	vorwahl text,
	einwohner integer,
	flaeche float,
	amt text,
	kz varchar (3),
	lat float,
	lon float
);

