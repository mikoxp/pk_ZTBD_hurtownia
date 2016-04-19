-- Create schemas section -------------------------------------------------

CREATE SCHEMA hurtownia
;

-- Create tables section -------------------------------------------------

-- Table hurtownia.kursy

CREATE TABLE hurtownia.kursy(
 id_waluty Character(3) NOT NULL,
 id_czasu Integer NOT NULL,
 id_panstwa Character(3) NOT NULL,
 id_trendu Integer,
 kurs Numeric(6,4) NOT NULL,
 zmiana Numeric(6,4),
 proc_zmiana Numeric(6,4)
)
;

-- Create indexes for table hurtownia.kursy

CREATE INDEX IX_Relationship4 ON hurtownia.kursy (id_trendu)
;

-- Add keys for table hurtownia.kursy

ALTER TABLE hurtownia.kursy ADD CONSTRAINT Key1 PRIMARY KEY (id_waluty,id_czasu,id_panstwa)
;

-- Table hurtownia.waluty

CREATE TABLE hurtownia.waluty(
 id_waluty Character(3) NOT NULL,
 nazwa_waluty Character varying(20)
)
;

-- Add keys for table hurtownia.waluty

ALTER TABLE hurtownia.waluty ADD CONSTRAINT Key2 PRIMARY KEY (id_waluty)
;

-- Table hurtownia.panstwa

CREATE TABLE hurtownia.panstwa(
 id_panstwa Character(3) NOT NULL,
 nazwa_panstwa Character varying(50) NOT NULL,
 kontynent Character varying(50) NOT NULL,
 region Character varying(50) NOT NULL,
 powierzchnia Integer NOT NULL,
 kategoria_wielkosci Character varying(10)
)
;

-- Add keys for table hurtownia.panstwa

ALTER TABLE hurtownia.panstwa ADD CONSTRAINT Key3 PRIMARY KEY (id_panstwa)
;

-- Table hurtownia.czas

CREATE TABLE hurtownia.czas(
 id_czasu Integer NOT NULL,
 dzien Integer NOT NULL,
 tydzien Integer NOT NULL,
 miesiac Integer NOT NULL,
 kwartal Integer NOT NULL,
 rok Integer NOT NULL
)
;

-- Add keys for table hurtownia.czas

ALTER TABLE hurtownia.czas ADD CONSTRAINT Key4 PRIMARY KEY (id_czasu)
;

-- Table hurtownia.trend

CREATE TABLE hurtownia.trendy(
 id_trendu Integer NOT NULL,
 nazwa_trendu Character varying(10) NOT NULL
)
;

-- Add keys for table hurtownia.trend

ALTER TABLE hurtownia.trendy ADD CONSTRAINT Key5 PRIMARY KEY (id_trendu)
;

ALTER TABLE hurtownia.trendy ADD CONSTRAINT nazwa_trendu UNIQUE (nazwa_trendu)
;

-- Create relationships section ------------------------------------------------- 

ALTER TABLE hurtownia.kursy ADD CONSTRAINT walutakursu FOREIGN KEY (id_waluty) REFERENCES hurtownia.waluty (id_waluty) ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE hurtownia.kursy ADD CONSTRAINT czaskursu FOREIGN KEY (id_czasu) REFERENCES hurtownia.czas (id_czasu) ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE hurtownia.kursy ADD CONSTRAINT panstwokursu FOREIGN KEY (id_panstwa) REFERENCES hurtownia.panstwa (id_panstwa) ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE hurtownia.kursy ADD CONSTRAINT trendkursu FOREIGN KEY (id_trendu) REFERENCES hurtownia.trendy (id_trendu) ON DELETE NO ACTION ON UPDATE NO ACTION
;