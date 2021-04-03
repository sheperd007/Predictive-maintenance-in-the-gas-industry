library(readxl)
Data <-data.frame(read_excel("/media/sda6/Projects/Data Mining on gas Network/output.xls")) 
z=c(9,4,3)
x=c("Categorical","Countinus","Timestamp")
xx=barplot(z,names.arg = x,ylab = "Number of Variable",xlab = "Variable type")
text(x = xx, y =z-2, label = z, pos = 3, cex = 0.8, col = "red")
rm(x,z,xx)

#EENS is normal?
shapiro.test(Data$EENS)
# It isn't normal 

library(dplyr)
library(ggplot2)
Data$feeder=factor(Data$feeder)
Data$AF=factor(Data$AF)



# number of regions
length(levels(Data$feeder))

# boxplot of GDP by region in 1970
p <- Data %>%
  ggplot(aes(feeder, EENS))
p + geom_boxplot()

# rotate names on x-axis
p + geom_boxplot() +
  ylab("Expected energy not supplied")
#Code: The reorder function
# by default, factor order is alphabetical

#Code: Enhanced boxplot ordered by median income, scaled, and showing data
# reorder by median income and color by continent
p <- Data %>%
  mutate(feeder = reorder(feeder, EENS, FUN = median)) %>%    # reorder
  ggplot(aes(feeder, EENS)) +    # color by continent
  geom_boxplot() +
  ylab("Expected energy not supplied") 
p

# log2 scale y-axis
p + scale_y_continuous(trans = "sqrt")

# add data points
p + scale_y_continuous(trans = "sqrt") + geom_point(show.legend = FALSE)

# Kruskal–Wallis
kruskal.test(EENS ~ feeder, data = Data)

#Multiple pairwise-comparison between groups
pairwise.wilcox.test(Data$EENS, Data$feeder,
                     p.adjust.method = "none")



library(snpar)
runs.test(Data$EENS)
