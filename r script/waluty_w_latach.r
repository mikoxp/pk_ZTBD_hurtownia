library("forecast")
waluty <- dbGetQuery(db.con, "SELECT id_waluty,nazwa_waluty, rok,miesiac, kurs, proc_zmiana FROM agregaty.waluty_w_latach NATURAL JOIN hurtownia.waluty;")
pdf("pdf/currency change in the forecast.pdf", 7, 5)
ids=unique(waluty$id_waluty);

for(id in ids){
w<-waluty[waluty$id_waluty==id,]
x <- as.Date(sprintf("%d %02d 1", w$rok, w$miesiac), format="%Y %m %d")
plot(x, w$kurs, type="l", col="blue", xlab="Time", ylab="Wskaznik")
title(w[1,2])
#predykcja
kurs = ts(w$kurs, frequency=12, start=c(w[1,3],w[1,4]))
hwforecast = HoltWinters(kurs, beta=FALSE, gamma=TRUE)
plot.forecast(forecast.HoltWinters(hwforecast, h=12),main=paste("Forecast: ",w[1,2]))
}
dev.off()
print("currency change in the forecast is DONE!!!!")
