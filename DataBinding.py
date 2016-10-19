'''
Created on Oct 19, 2016

@author: DucTruong
'''
import numpy as np
import pandas as pd
# from sklearn import datasets
# from sklearn.model_selection import cross_val_predict
# from sklearn import linear_model
#import matplotlib.pyplot as plt


logonframe = pd.DataFrame.from_csv('logon.csv', sep=',')
#logon = pd.read_csv('logon.csv', sep=',')

#newframe = pd.DataFrame(logonframe['date'], logonframe['user'], logonframe['activity'])

print(logonframe[['user','activity']])

userActivity = logonframe[['user','activity']]

userActivityGroup = userActivity.groupby(['user','activity'])

userActivityGroupAggregate = userActivityGroup.size()
print(userActivityGroupAggregate.describe())

#logongroupbyframe = pd.DataFrame(logonframe.groupby(['date','user','activity']))
#print(userActivityGroup.describe())
#print(userActivityGroup.aggregate(np.sum))


#print(logonframe.describe())



