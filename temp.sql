--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: stadtwetter; Type: DATABASE; Schema: -; Owner: vanhech
--

CREATE DATABASE stadtwetter WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'de_DE.UTF-8' LC_CTYPE = 'de_DE.UTF-8';


ALTER DATABASE stadtwetter OWNER TO vanhech;

\connect stadtwetter

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: geodb_coordinates; Type: TABLE; Schema: public; Owner: vanhech; Tablespace: 
--

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


ALTER TABLE public.geodb_coordinates OWNER TO vanhech;

--
-- Name: geodb_coordinates_bk; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE geodb_coordinates_bk (
    loc_id integer,
    lon integer,
    lat integer,
    coord_type integer,
    coord_subtype integer,
    valid_since integer,
    date_type_since integer,
    valid_until text,
    date_type_until integer
);


ALTER TABLE public.geodb_coordinates_bk OWNER TO postgres;

--
-- Name: geodb_floatdata; Type: TABLE; Schema: public; Owner: vanhech; Tablespace: 
--

CREATE TABLE geodb_floatdata (
    loc_id integer,
    float_type integer,
    float_val integer,
    date_type_since integer,
    valid_since date,
    valid_until date,
    date_type_until integer
);


ALTER TABLE public.geodb_floatdata OWNER TO vanhech;

--
-- Name: geodb_floatdata_old; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE geodb_floatdata_old (
    loc_id integer,
    float_val integer,
    float_type integer,
    float_subtype integer,
    valid_since integer,
    date_type_since text,
    valid_until integer,
    date_type_until integer
);


ALTER TABLE public.geodb_floatdata_old OWNER TO postgres;

--
-- Name: geodb_intdata; Type: TABLE; Schema: public; Owner: vanhech; Tablespace: 
--

CREATE TABLE geodb_intdata (
    loc_id integer,
    int_type integer,
    int_val integer,
    valid_since date,
    date_type_since integer,
    valid_until date,
    date_type_until integer
);


ALTER TABLE public.geodb_intdata OWNER TO vanhech;

--
-- Name: geodb_intdata_old; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE geodb_intdata_old (
    loc_id integer,
    level integer,
    id_lvl1 integer,
    id_lvl2 integer,
    id_lvl3 integer,
    id_lvl4 text,
    id_lvl5 integer,
    id_lvl7 integer,
    id_lvl8 integer,
    id_lvl9 integer,
    valid_since date,
    date_type_since integer,
    valid_until date,
    date_type_until integer
);


ALTER TABLE public.geodb_intdata_old OWNER TO postgres;

--
-- Name: geodb_locations; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE geodb_locations (
    loc_id integer,
    loc_type integer
);


ALTER TABLE public.geodb_locations OWNER TO postgres;

--
-- Name: geodb_textdata; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE geodb_textdata (
    loc_id integer,
    text_type integer,
    text_val1 text,
    text_val2 text,
    text_val3 integer,
    text_val4 integer,
    text_val5 integer,
    text_val6 integer,
    text_val7 date,
    text_val8 integer
);


ALTER TABLE public.geodb_textdata OWNER TO postgres;

--
-- Name: locations; Type: TABLE; Schema: public; Owner: vanhech; Tablespace: 
--

CREATE TABLE locations (
    id integer NOT NULL,
    loc_id integer NOT NULL,
    plz text NOT NULL,
    name character varying(255) NOT NULL,
    vorwahl text,
    einwohner integer,
    flaeche double precision,
    amt character varying(255),
    kz character varying(3),
    lat numeric(10,8) NOT NULL,
    lon numeric(11,8) NOT NULL
);


ALTER TABLE public.locations OWNER TO vanhech;

--
-- Name: locations_id_seq; Type: SEQUENCE; Schema: public; Owner: vanhech
--

CREATE SEQUENCE locations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.locations_id_seq OWNER TO vanhech;

--
-- Name: locations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vanhech
--

ALTER SEQUENCE locations_id_seq OWNED BY locations.id;


--
-- Name: wettermessung; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE wettermessung (
    stations_id integer NOT NULL,
    datum date NOT NULL,
    qualitaet integer,
    min_5cm double precision,
    min_2m double precision,
    mittel_2m double precision,
    max_2m double precision,
    relative_feuchte double precision,
    mittel_windstaerke double precision,
    max_windgeschwindigkeit double precision,
    sonnenscheindauer double precision,
    mittel_bedeckungsgrad double precision,
    niederschlagshoehe double precision,
    mittel_luftdruck double precision
);


ALTER TABLE public.wettermessung OWNER TO postgres;

--
-- Name: wetterstation; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE wetterstation (
    s_id integer NOT NULL,
    standort text NOT NULL,
    geo_breite double precision,
    geo_laenge double precision,
    hoehe integer,
    betreiber text
);


ALTER TABLE public.wetterstation OWNER TO postgres;

--
-- Name: zip_coordinates; Type: TABLE; Schema: public; Owner: vanhech; Tablespace: 
--

CREATE TABLE zip_coordinates (
    zc_id integer NOT NULL,
    zc_loc_id integer NOT NULL,
    zc_zip character varying(10) NOT NULL,
    zc_location_name character varying(255) NOT NULL,
    zc_lat double precision,
    zc_lon double precision
);


ALTER TABLE public.zip_coordinates OWNER TO vanhech;

--
-- Name: zip_coordinates_zc_id_seq; Type: SEQUENCE; Schema: public; Owner: vanhech
--

CREATE SEQUENCE zip_coordinates_zc_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.zip_coordinates_zc_id_seq OWNER TO vanhech;

--
-- Name: zip_coordinates_zc_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vanhech
--

ALTER SEQUENCE zip_coordinates_zc_id_seq OWNED BY zip_coordinates.zc_id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: vanhech
--

ALTER TABLE ONLY locations ALTER COLUMN id SET DEFAULT nextval('locations_id_seq'::regclass);


--
-- Name: zc_id; Type: DEFAULT; Schema: public; Owner: vanhech
--

ALTER TABLE ONLY zip_coordinates ALTER COLUMN zc_id SET DEFAULT nextval('zip_coordinates_zc_id_seq'::regclass);


--
-- Name: locations_pkey; Type: CONSTRAINT; Schema: public; Owner: vanhech; Tablespace: 
--

ALTER TABLE ONLY locations
    ADD CONSTRAINT locations_pkey PRIMARY KEY (id);


--
-- Name: wettermessung_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY wettermessung
    ADD CONSTRAINT wettermessung_pkey PRIMARY KEY (stations_id, datum);


--
-- Name: wetterstation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY wetterstation
    ADD CONSTRAINT wetterstation_pkey PRIMARY KEY (s_id);


--
-- Name: zip_coordinates_pkey; Type: CONSTRAINT; Schema: public; Owner: vanhech; Tablespace: 
--

ALTER TABLE ONLY zip_coordinates
    ADD CONSTRAINT zip_coordinates_pkey PRIMARY KEY (zc_id);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

