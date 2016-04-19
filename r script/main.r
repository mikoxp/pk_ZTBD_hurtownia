require(RPostgreSQL)
drv <- dbDriver("PostgreSQL")
db.con <- dbConnect(drv, host="na1noc.pl", port=5432,
dbname="hurtownia", user="projekt_zbd", password="kasztan")
#dane <- dbGetQuery(db.con, "select 5;")
#print(dane)
#source('test.r');
source('waluty_w_latach.r');
dbDisconnect(db.con)
