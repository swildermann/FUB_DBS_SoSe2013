CREATE TABLE staedte (
	id serial NOT NULL PRIMARY KEY,
	plz VARCHAR ( 10 ) NOT NULL ,
	name VARCHAR ( 255 ) NOT NULL ,
	vorwahl text,	
	einwohner integer,
	flaeche float,
	amt text, 
	kz varchar (3),
	lat float,
	lon float
);
