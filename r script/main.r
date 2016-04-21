require(RPostgreSQL)
drv <- dbDriver("PostgreSQL")
db.con <- dbConnect(drv, host="na1noc.pl", port=5432,
dbname="hurtownia", user="projekt_zbd", password="kasztan")
source('waluty_w_latach.r');
source('trendy_zestawieniw.r');
dbDisconnect(db.con)
