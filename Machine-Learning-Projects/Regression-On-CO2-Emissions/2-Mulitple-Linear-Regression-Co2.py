#!/usr/bin/env python
# coding: utf-8

# # Multiple Linear Regression To Predict CO2 Emissions
# 
# 
# ## Objectives
# 
# -   Use scikit-learn to implement Multiple Linear Regression on features from an automobile data set to predict CO2 Emissions.
# -   Create a model, train,test and use the model.
# -   Measure the accuracy of the model using residual sum of squares and checking the variance score.

# <h1>Table of contents</h1>
# <div class="alert alert-block alert-info" style="margin-top: 20px">
#     <ol>
#         <li><a href="#understanding-data">About the Data</a></li>
#         <li><a href="#multiple_regression_model">Multiple Regression Model</a></li>
#         <li><a href="#prediction">Prediction</a></li>
#     </ol>
# </div>

# <h2 id="understanding_data">About the Data</h2>
# 
# The fuel consumption dataset, **`FuelConsumption.csv`**, contains model-specific fuel consumption ratings and estimated carbon dioxide emissions for new light-duty vehicles for retail sale in Canada. [Dataset source](http://open.canada.ca/data/en/dataset/98f1a129-f628-4ce4-b24d-6f16bf24dd64?cm_mmc=Email_Newsletter-_-Developer_Ed%2BTech-_-WW_WW-_-SkillsNetwork-Courses-IBMDeveloperSkillsNetwork-ML0101EN-SkillsNetwork-20718538&cm_mmca1=000026UJ&cm_mmca2=10006555&cm_mmca3=M12345678&cvosrc=email.Newsletter.M12345678&cvo_campaign=000026UJ&cm_mmc=Email_Newsletter-_-Developer_Ed%2BTech-_-WW_WW-_-SkillsNetwork-Courses-IBMDeveloperSkillsNetwork-ML0101EN-SkillsNetwork-20718538&cm_mmca1=000026UJ&cm_mmca2=10006555&cm_mmca3=M12345678&cvosrc=email.Newsletter.M12345678&cvo_campaign=000026UJ&cm_mmc=Email_Newsletter-_-Developer_Ed%2BTech-_-WW_WW-_-SkillsNetwork-Courses-IBMDeveloperSkillsNetwork-ML0101EN-SkillsNetwork-20718538&cm_mmca1=000026UJ&cm_mmca2=10006555&cm_mmca3=M12345678&cvosrc=email.Newsletter.M12345678&cvo_campaign=000026UJ&cm_mmc=Email_Newsletter-_-Developer_Ed%2BTech-_-WW_WW-_-SkillsNetwork-Courses-IBMDeveloperSkillsNetwork-ML0101EN-SkillsNetwork-20718538&cm_mmca1=000026UJ&cm_mmca2=10006555&cm_mmca3=M12345678&cvosrc=email.Newsletter.M12345678&cvo_campaign=000026UJ)
# 
# -   **MODELYEAR** e.g. 2014
# -   **MAKE** e.g. Acura
# -   **MODEL** e.g. ILX
# -   **VEHICLE CLASS** e.g. SUV
# -   **ENGINE SIZE** e.g. 4.7
# -   **CYLINDERS** e.g 6
# -   **TRANSMISSION** e.g. A6
# -   **FUELTYPE** e.g. z
# -   **FUEL CONSUMPTION in CITY(L/100 km)** e.g. 9.9
# -   **FUEL CONSUMPTION in HWY (L/100 km)** e.g. 8.9
# -   **FUEL CONSUMPTION COMB (L/100 km)** e.g. 9.2
# -   **CO2 EMISSIONS (g/km)** e.g. 182   --> low --> 0

# ### Importing Needed packages
# 

# In[1]:


import matplotlib.pyplot as plt
import pandas as pd
import pylab as pl
import numpy as np
get_ipython().run_line_magic('matplotlib', 'inline')


# #### Downloading Data

# In[2]:


get_ipython().run_cell_magic('capture', '', '!wget -O FuelConsumption.csv https://s3-api.us-geo.objectstorage.softlayer.net/cf-courses-data/CognitiveClass/ML0101ENv3/labs/FuelConsumptionCo2.csv')


# In[3]:


#passing csv file to a pandas dataframe
df = pd.read_csv("FuelConsumption.csv")

df.head()


# Selecting features that will be used for regression.

# In[4]:


cdf = df[['ENGINESIZE','CYLINDERS','FUELCONSUMPTION_CITY','FUELCONSUMPTION_HWY','FUELCONSUMPTION_COMB','CO2EMISSIONS']]
cdf.head(9)


# Plotting Emission values with respect to Engine size:

# In[5]:


plt.scatter(cdf.ENGINESIZE, cdf.CO2EMISSIONS,  color='blue')
plt.xlabel("Engine size")
plt.ylabel("Emission")
plt.show()


# #### Creating train and test dataset

# In[6]:


msk = np.random.rand(len(df)) < 0.8
train = cdf[msk]
test = cdf[~msk]


# #### Train data distribution
# 

# In[7]:


plt.scatter(train.ENGINESIZE, train.CO2EMISSIONS,  color='blue')
plt.xlabel("Engine size")
plt.ylabel("Emission")
plt.show()


# <h2 id="multiple_regression_model">Multiple Regression Model</h2>
# 

# In reality, there are multiple variables that predict the Co2emission. When more than one independent variable is present, the process is called multiple linear regression. For example, predicting co2emission using Fuelconsumption, EngineSize and Cylinders of cars.

# In[8]:


from sklearn import linear_model
regr = linear_model.LinearRegression()
x = np.asanyarray(train[['ENGINESIZE','CYLINDERS','FUELCONSUMPTION_COMB']])
y = np.asanyarray(train[['CO2EMISSIONS']])
regr.fit (x, y)
# The coefficients
print ('Coefficients: ', regr.coef_)


# **Coefficient** and **Intercept** , are the parameters of the fit line. 
# Given that it is a multiple linear regression, with 3 parameters, and knowing that the parameters are the intercept and coefficients of hyperplane, sklearn can estimate them from the data. Scikit-learn uses plain Ordinary Least Squares method to solve this problem.

# <h2 id="prediction">Prediction</h2>
# 

# In[9]:


y_hat= regr.predict(test[['ENGINESIZE','CYLINDERS','FUELCONSUMPTION_COMB']])
x = np.asanyarray(test[['ENGINESIZE','CYLINDERS','FUELCONSUMPTION_COMB']])
y = np.asanyarray(test[['CO2EMISSIONS']])
print("Residual sum of squares: %.2f"
      % np.mean((y_hat - y) ** 2))

# if variance score: 1 then it is a perfect prediction
print('Variance score: %.2f' % regr.score(x, y))


# Using multiple linear regression with the same dataset but this time using fuel consumption in city and 
# fuel consumption in hwy instead of fuel consumption comb.

# In[10]:


regr = linear_model.LinearRegression()
x = np.asanyarray(train[['ENGINESIZE','CYLINDERS','FUELCONSUMPTION_CITY','FUELCONSUMPTION_HWY']])
y = np.asanyarray(train[['CO2EMISSIONS']])
regr.fit (x, y)
print ('Coefficients: ', regr.coef_)
y_= regr.predict(test[['ENGINESIZE','CYLINDERS','FUELCONSUMPTION_CITY','FUELCONSUMPTION_HWY']])
x = np.asanyarray(test[['ENGINESIZE','CYLINDERS','FUELCONSUMPTION_CITY','FUELCONSUMPTION_HWY']])
y = np.asanyarray(test[['CO2EMISSIONS']])
print("Residual sum of squares: %.2f"% np.mean((y_ - y) ** 2))
print('Variance score: %.2f' % regr.score(x, y))

