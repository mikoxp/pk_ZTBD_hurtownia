CREATE OR REPLACE FUNCTION agregaty.aktualizacja() RETURNS BOOLEAN AS
$$

BEGIN
--srednie waluty w latach
DELETE FROM agregaty.waluty_w_latach;
INSERT INTO agregaty.waluty_w_latach(id_waluty, rok,miesiac, kurs, proc_zmiana)
	(SELECT id_waluty,rok,miesiac,round(AVG(kurs),5) as kurs,ROUND(AVG(proc_zmiana),5) as proc_zmiana
	FROM hurtownia.kursy NATURAL JOIN hurtownia.czas
	GROUP BY id_waluty,rok,miesiac
	ORDER BY 1,2);


--stabilnosc waluty panstwa
DELETE FROM agregaty.niestabilnosc_panstw;
INSERT INTO agregaty.niestabilnosc_panstw(nazwa_panstwa, niestabilnosc, sr_proc_zmiana_walut)
	(SELECT nazwa_panstwa,ROUND(STDDEV(kurs),5) as niestabilnosc,ROUND(AVG(proc_zmiana),5) as sr_proc_zmiana_walut
	FROM hurtownia.kursy NATURAL JOIN hurtownia.panstwa
	GROUP BY nazwa_panstwa);


--stabilnosc kontynentu
DELETE FROM agregaty.niestabilnosc_kontynenty;
INSERT INTO agregaty.niestabilnosc_kontynenty(kontynent, niestabilnosc, sr_proc_zmiana_walut)
	(SELECT kontynent,ROUND(AVG(s),5) as niestabilnosc,ROUND(AVG(p),5) as sr_proc_zmiana_walut
	FROM (SELECT kontynent,ROUND(STDDEV(kurs)/AVG(kurs),5) as s,ROUND(AVG(proc_zmiana),5) as p
		FROM hurtownia.kursy NATURAL JOIN hurtownia.czas NATURAL JOIN hurtownia.panstwa
		GROUP BY kontynent,id_panstwa) as foo
	GROUP BY kontynent
	ORDER BY 2,3);


--stabilnosc wielkosc_pasatw
DELETE FROM agregaty.niestabilnosc_wielkosc_panstwa;
INSERT INTO agregaty.niestabilnosc_wielkosc_panstwa(kategoria_wielkosci, niestabilnosc, sr_proc_zmiana_walut)
	(SELECT kategoria_wielkosci,ROUND(AVG(s),5) as niestabilnosc,ROUND(AVG(p),5) as sr_proc_zmiana_walut
	FROM (SELECT kategoria_wielkosci,ROUND(STDDEV(kurs)/AVG(kurs),5) as s,ROUND(AVG(proc_zmiana),5) as p
		FROM hurtownia.kursy NATURAL JOIN hurtownia.czas NATURAL JOIN hurtownia.panstwa
		GROUP BY kategoria_wielkosci,id_panstwa) as foo
	GROUP BY kategoria_wielkosci
	ORDER BY 2,3);


DELETE FROM agregaty.trendy_zestawienie;
INSERT INTO agregaty.trendy_zestawienie(id_waluty, rok, spadek, utrzymanie, wzrost)
	(SELECT * FROM
			(SELECT id_waluty,rok,COUNT(*) as spadek
			FROM hurtownia.kursy NATURAL JOIN hurtownia.czas
			WHERE id_trendu=1 
			GROUP BY id_waluty,rok
			ORDER BY 1,2) as s 
			NATURAL JOIN
			(SELECT id_waluty,rok,COUNT(*) as utrzymanie
			FROM hurtownia.kursy NATURAL JOIN hurtownia.czas
			WHERE id_trendu=2 
			GROUP BY id_waluty,rok
			ORDER BY 1,2)as u
			NATURAL JOIN 
			(SELECT id_waluty,rok,COUNT(*) as wzrost
			FROM hurtownia.kursy NATURAL JOIN hurtownia.czas
			WHERE id_trendu=3 
			GROUP BY id_waluty,rok
			ORDER BY 1,2) as w);
		

DELETE FROM agregaty.trend_dominujacy;

WITH tr AS
		(SELECT id_waluty,rok,1 as trend,COUNT(*) as ilosc
		FROM hurtownia.kursy NATURAL JOIN hurtownia.czas
		WHERE id_trendu=1 
		GROUP BY id_waluty,rok
		UNION
		SELECT id_waluty,rok,2 as trend,COUNT(*) as ilosc
		FROM hurtownia.kursy NATURAL JOIN hurtownia.czas
		WHERE id_trendu=2 
		GROUP BY id_waluty,rok
		UNION
		SELECT id_waluty,rok,3 as trend,COUNT(*) as ilosc
		FROM hurtownia.kursy NATURAL JOIN hurtownia.czas
		WHERE id_trendu=3 
		GROUP BY id_waluty,rok)


INSERT INTO agregaty.trend_dominujacy(id_waluty,rok, id_trendu, procent_trendu)
	(SELECT distinct id_waluty,rok,trend as "id_trendu",ROUND(ilosc/sum*100,2) as procent_trendu 
		FROM
		(SELECT id_waluty,rok,trend,ilosc FROM tr p
		WHERE ilosc=
			(SELECT MAX(ilosc) FROM tr
			WHERE p.id_waluty=id_waluty AND p.rok=rok	
			GROUP BY id_waluty,rok)) as foo
		NATURAL JOIN 
		(SELECT id_waluty,rok,SUM(ilosc) FROM tr 
		GROUP BY id_waluty,rok) as foo2
	ORDER BY 1,2);
RETURN TRUE;
END
$$
LANGUAGE 'plpgsql' ;