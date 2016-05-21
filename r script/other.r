pdf("pdf/special.pdf", 7, 5)
w <- dbGetQuery(db.con, "SELECT rok, miesiac, wartosc FROM agregaty.pl;");
x <- as.Date(sprintf("%d %02d 1", w$rok, w$miesiac), format="%Y %m %d");
plot(x, w$wartosc, type="l", col="blue", xlab="Time", ylab="PLN");
title("Polska waluta na tle innych");


#---------------------------------------------
eu<- dbGetQuery(db.con, "SELECT id_waluty,nazwa_waluty, rok,miesiac, kurs FROM agregaty.waluty_w_latach NATURAL JOIN hurtownia.waluty WHERE id_waluty IN ('USD','EUR') AND rok>=2006;");
usd<-eu[eu$id_waluty=='USD',];
eur<-eu[eu$id_waluty=='EUR',];
xusd <- as.Date(sprintf("%d %02d 1", usd$rok, usd$miesiac), format="%Y %m %d")
xeur <- as.Date(sprintf("%d %02d 1", eur$rok, eur$miesiac), format="%Y %m %d")

plot(xusd, usd$kurs, type="l", col="red", xlab="Czas", ylab="PLN", ylim=c(2, 5))
lines(xeur, eur$kurs, col='blue')

legend('topleft', 'Waluty', legend=c('USD', 'EUR'), pch=15, col=c('red', 'blue'))
title(paste("Korelacja miedzy EUR i USD - ", cor(usd$kurs, eur$kurs)))






dev.off();
print("Special is DONE!!!!")

