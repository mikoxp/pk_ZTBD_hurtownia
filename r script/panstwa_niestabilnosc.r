panstwa <- dbGetQuery(db.con, "SELECT nazwa_panstwa,sr_proc_zmiana_walut FROM agregaty.niestabilnosc_panstw;")
