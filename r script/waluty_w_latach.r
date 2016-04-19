waluty <- dbGetQuery(db.con, "SELECT id_waluty,nazwa_waluty, rok,miesiac, kurs, proc_zmiana FROM agregaty.waluty_w_latach NATURAL JOIN hurtownia.waluty;")
pdf("pdf/lata.pdf", 7, 5)
for(id in ids){
w<-waluty[waluty$id_waluty==id,]
x <- as.Date(sprintf("%d %02d 1", w$rok, w$miesiac), format="%Y %m %d")
plot(x, w$kurs, type="l", col="blue", xlab="Time", ylab="PLN")
title(w[1,2])
}
dev.off()