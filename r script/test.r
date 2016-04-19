dane <- dbGetQuery(db.con, "SELECT kontynent, niestabilnosc, sr_proc_zmiana_walut FROM agregaty.niestabilnosc_kontynenty;
")
