#Naive Bayes # only 5 column (feeder,COB,DFB,DOFDB,EENS)
data=read.csv(file.choose())
str(data)
#######################################
#Setting outcome variables as categorical
data$feeder = factor(data$feeder)
levels(data$feeder)

data$COB = factor(data$COB)
levels(data$COB)

data$DFB = factor(data$DFB)
levels(data$DFB)

levels(data$class)
summary(data)


library(ggplot2)
library(caret)
indxTrain <- createDataPartition(y = data$feeder, p = 0.75,list = FALSE)
training <- data[indxTrain,]
testing <- data[-indxTrain,]
#create objects x which holds the predictor variables and y which holds the response variables
x = training[,2:5]
y = training$feeder

#Fit the model
library(e1071)
model = train(x,y,'nb')
model

#Plot Variable performance
X <- varImp(model)
#varImpPlot(X)
plot(X)

