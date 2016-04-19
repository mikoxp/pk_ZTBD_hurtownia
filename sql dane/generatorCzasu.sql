CREATE OR REPLACE FUNCTION hurtownia.generatorCzasu(start DATE,koniec DATE) RETURNS BOOLEAN AS
$$
DECLARE
id INTEGER;
BEGIN

WHILE start<=koniec
    LOOP
       
       id:=date_part('day',start)+date_part('month',start)*100+date_part('year',start)*10000;
      INSERT INTO hurtownia.czas(id_czasu, dzien, tydzien, miesiac, kwartal, rok)
    VALUES (id,date_part('day',start), date_part('week',start), date_part('month',start), date_part('quarter', start),date_part('year',start));
	start:=start+1;
    END LOOP;
RETURN TRUE;
END
$$
LANGUAGE 'plpgsql' ;