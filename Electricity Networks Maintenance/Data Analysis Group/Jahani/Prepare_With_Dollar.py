import pandas as pd
from sklearn.model_selection import train_test_split
from math import sqrt
from sklearn.metrics import mean_squared_error
import pmdarima as pm
import numpy as np
def Build_appropriate_List(text,Remove_Head=10):
    f = open(text, "r")
    data=f.read()
    data=data.split(",")
    #Removing \n
    newl=[]
    for x in data:
        new=x.split("\n")
        newl += new
    Head=newl[:Remove_Head]
    newl=newl[Remove_Head:]
    return newl
def Seperate_Feature(data,start,lenght=12,style=float):
    frame=[]
    for i in range(start,len(data),lenght):
        frame.append(style(data[i]))
    return frame
def TimeSeries_Resample(daily,period="W"):
    """daily Timeseries With Dates"""
    weekly=daily.resample(period).mean()
    weekly=pd.DataFrame.dropna(weekly)
    weekly=pd.DataFrame.dropna(weekly)
    return weekly
def create_future_set(model, train_df, prediction_size,test_df):
    
    #Adding predictions place to the data frame
    future = model.make_future_dataframe(periods= prediction_size)
    return future
def RMSE(test,forecast):
    #RMSE
        rms = sqrt(mean_squared_error(test,forecast))
        print("RMSE =",rms)
        ape=(abs(test-forecast)/test)*100
        print(ape.mean())