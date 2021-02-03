library(readxl)
Data <-data.frame(read_excel("Downloads/output.xls")) 
z=c(9,4,3)
x=c("Categorical","Countinus","Timestamp")
xx=barplot(z,names.arg = x,ylab = "Number of Variable",xlab = "Variable type")
text(x = xx, y =z-2, label = z, pos = 3, cex = 0.8, col = "red")
rm(x,z,xx)

#EENS is normal?
shapiro.test(Data$EENS)
# It isn't normal 
# Kruskal–Wallis