x<-1:3
x2<-1:5
y<-x*x*x
y2<-x2+1
plot_colors <- c("blue","red","forestgreen")
plot(x,y,type="o" ,col=plot_colors[1])
lines(x2,y2,type="o" ,col=plot_colors[2])