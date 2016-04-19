CREATE OR REPLACE FUNCTION hurtownia.kursyTrig() RETURNS TRIGGER AS 
$BODY$
DECLARE
rekord RECORD ;
id Char(3);
czas INTEGER;
stara DECIMAL(10,5);
BEGIN 
	FOR id IN (select distinct id_waluty FROM hurtownia.kursy)
	LOOP
		--raise NOTICE '%',id;
		czas=(SELECT MIN(id_czasu) FROM hurtownia.kursy WHERE id_waluty=id);
		UPDATE hurtownia.kursy
		SET zmiana=0, 
			proc_zmiana=0
		WHERE id_czasu=czas;
		FOR rekord IN (SELECT  id_czasu,kurs FROM hurtownia.kursy WHERE id_waluty=id AND id_czasu<>czas)
		LOOP
			stara:=(SELECT kurs FROM hurtownia.kursy WHERE id_waluty=id AND id_czasu<rekord.id_czasu ORDER  BY id_czasu desc LIMIT 1);
			UPDATE hurtownia.kursy
			SET  	zmiana=rekord.kurs-stara, 
				proc_zmiana=(rekord.kurs-stara)*100/stara
			WHERE id_waluty=id AND id_czasu=rekord.id_czasu;

		END LOOP;
	END LOOP;
		UPDATE hurtownia.kursy SET id_trendu=1 WHERE zmiana<0;
		UPDATE hurtownia.kursy SET id_trendu=2 WHERE zmiana=0;
		UPDATE hurtownia.kursy SET id_trendu=3 WHERE zmiana>0;
		RETURN NEW;
END;

$BODY$


 LANGUAGE plpgsql;


DROP TRIGGER kursyTrig ON hurtownia.kursy;
CREATE TRIGGER kursyTrig AFTER INSERT
ON hurtownia.kursy FOR STATEMENT
EXECUTE PROCEDURE hurtownia.kursyTrig();
