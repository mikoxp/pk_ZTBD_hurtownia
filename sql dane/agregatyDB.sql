/*
Created: 2016-04-07
Modified: 2016-04-10
Model: PostgreSQL 9.4
Database: PostgreSQL 9.4
*/


-- Create schemas section -------------------------------------------------

CREATE SCHEMA agregaty
;

-- Create tables section -------------------------------------------------

-- Table waluty_w_latach

CREATE TABLE agregaty.waluty_w_latach(
 id_waluty Character(3) NOT NULL,
 rok Integer NOT NULL,
 miesiac integer NOT NULL,
 kurs Numeric(10,6) NOT NULL,
 proc_zmiana Numeric(10,6) NOT NULL,
 CONSTRAINT waKey11 PRIMARY KEY (id_waluty,rok,miesiac)
)
;

-- Add keys for table waluty_w_latach



-- Table agregaty.niestabilnosc_panstw

CREATE TABLE agregaty.niestabilnosc_panstw(
 nazwa_panstwa Character varying(50) NOT NULL PRIMARY KEY,
 niestabilnosc Numeric(10,6) NOT NULL,
 sr_proc_zmiana_walut Numeric(10,6) NOT NULL
)
;

-- Add keys for table agregaty.niestabilnosc_panstw



-- Table agregaty.niestabilnosc_kontynenty

CREATE TABLE agregaty.niestabilnosc_kontynenty(
 kontynent Character varying(50) NOT NULL PRIMARY KEY,
 niestabilnosc Numeric(10,6) NOT NULL,
 sr_proc_zmiana_walut Numeric(10,6) NOT NULL
)
;

-- Add keys for table agregaty.niestabilnosc_kontynenty



-- Table agregaty.niestabilnosc_wielkosc_panstwa

CREATE TABLE agregaty.niestabilnosc_wielkosc_panstwa(
 kategoria_wielkosci Character varying(10) NOT NULL PRIMARY KEY,
 niestabilnosc Numeric(10,6) NOT NULL,
 sr_proc_zmiana_walut Numeric(10,6) NOT NULL
)
;

-- Add keys for table agregaty.niestabilnosc_wielkosc_panstwa



-- Table agregaty.trendy_zestawienie

CREATE TABLE agregaty.trendy_zestawienie(
 id_waluty Character(3) NOT NULL,
 rok Integer NOT NULL,
 spadek Integer NOT NULL,
 utrzymanie Integer NOT NULL,
 wzrost Integer NOT NULL,
 CONSTRAINT waKey33 PRIMARY KEY (id_waluty,rok)
)
;

-- Add keys for table agregaty.trendy_zestawienie




-- Table trend_dominujacy

CREATE TABLE agregaty.trend_dominujacy(
 id_waluty Character(3) NOT NULL,
 id_trendu Integer NOT NULL,
 rok Integer NOT NULL,
 procent_trendu Numeric(10,6) NOT NULL,
 CONSTRAINT waKey44 PRIMARY KEY (id_waluty,rok)
)
;

-- Add keys for table trend_dominujacy






