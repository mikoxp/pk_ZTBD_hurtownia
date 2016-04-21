trendy <- dbGetQuery(db.con, "SELECT id_waluty,nazwa_waluty, rok, spadek, utrzymanie, wzrost FROM agregaty.trendy_zestawienie NATURAL JOIN hurtownia.waluty;")
kolory<-c("red","blue","green")   
pdf("pdf/currency_trend.pdf", 7, 5)
ids=unique(trendy$id_waluty);
for(id in ids){
d_wyk<-trendy[trendy$id_waluty==id,]
tr<-t(d_wyk[4:6])
barplot(tr, main=d_wyk[1,2],xlab="years", ylab= "Numbers",beside=TRUE, col=kolory,names.arg=d_wyk$rok)
legend("topleft",c("spadek","utrzymanie","wzrost"), cex=1, bty="n", fill=kolory);
}
dev.off()
print("Curency trends is DONE!!!!")