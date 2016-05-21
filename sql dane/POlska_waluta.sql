SELECT rok,miesiac,ROUND(AVG(nk),5) as wartosc
FROM
	(SELECT id_waluty,rok,miesiac,kurs/m as nk
	FROM hurtownia.kursy NATURAL JOIN hurtownia.czas NATURAL JOIN
	(SELECT id_waluty,MAX(kurs) as m FROM
		hurtownia.kursy
		GROUP BY id_waluty) as foo) as a
		
GROUP BY rok,miesiac
ORDER BY rok,miesiac
