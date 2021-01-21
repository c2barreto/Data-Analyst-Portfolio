#!/usr/bin/env python
# coding: utf-8

# # Simple Linear Regression to Predict CO2 Emissions
# 
# 
# ## Objectives
# 
# -   Use scikit-learn to implement simple linear regression on features from a fuel consumption data set.
# -   Create a model, train, test and use the model to predict CO2 emissions with the selected features.
# -   Evauluate the accuracy of the model using mean absolute error, residual sum of squares, and R2-score.

# ## Understanding the Data
# The fuel consumption data set, **`FuelConsumption.csv`**, contains model-specific fuel consumption ratings and estimated carbon dioxide emissions for new light-duty vehicles for retail sale in Canada. [Dataset source](http://open.canada.ca/data/en/dataset/98f1a129-f628-4ce4-b24d-6f16bf24dd64?cm_mmc=Email_Newsletter-_-Developer_Ed%2BTech-_-WW_WW-_-SkillsNetwork-Courses-IBMDeveloperSkillsNetwork-ML0101EN-SkillsNetwork-20718538&cm_mmca1=000026UJ&cm_mmca2=10006555&cm_mmca3=M12345678&cvosrc=email.Newsletter.M12345678&cvo_campaign=000026UJ&cm_mmc=Email_Newsletter-_-Developer_Ed%2BTech-_-WW_WW-_-SkillsNetwork-Courses-IBMDeveloperSkillsNetwork-ML0101EN-SkillsNetwork-20718538&cm_mmca1=000026UJ&cm_mmca2=10006555&cm_mmca3=M12345678&cvosrc=email.Newsletter.M12345678&cvo_campaign=000026UJ&cm_mmc=Email_Newsletter-_-Developer_Ed%2BTech-_-WW_WW-_-SkillsNetwork-Courses-IBMDeveloperSkillsNetwork-ML0101EN-SkillsNetwork-20718538&cm_mmca1=000026UJ&cm_mmca2=10006555&cm_mmca3=M12345678&cvosrc=email.Newsletter.M12345678&cvo_campaign=000026UJ&cm_mmc=Email_Newsletter-_-Developer_Ed%2BTech-_-WW_WW-_-SkillsNetwork-Courses-IBMDeveloperSkillsNetwork-ML0101EN-SkillsNetwork-20718538&cm_mmca1=000026UJ&cm_mmca2=10006555&cm_mmca3=M12345678&cvosrc=email.Newsletter.M12345678&cvo_campaign=000026UJ)
# 
# -   **MODELYEAR** e.g. 2014
# -   **MAKE** e.g. Acura
# -   **MODEL** e.g. ILX
# -   **VEHICLE CLASS** e.g. SUV
# -   **ENGINE SIZE** e.g. 4.7
# -   **CYLINDERS** e.g 6
# -   **TRANSMISSION** e.g. A6
# -   **FUEL CONSUMPTION in CITY(L/100 km)** e.g. 9.9
# -   **FUEL CONSUMPTION in HWY (L/100 km)** e.g. 8.9
# -   **FUEL CONSUMPTION COMB (L/100 km)** e.g. 9.2
# -   **CO2 EMISSIONS (g/km)** e.g. 182   --> low --> 0

# ### Downloading Data

# In[1]:


get_ipython().run_cell_magic('capture', '', '!wget -O FuelConsumption.csv https://s3-api.us-geo.objectstorage.softlayer.net/cf-courses-data/CognitiveClass/ML0101ENv3/labs/FuelConsumptionCo2.csv')


# ### Importing Needed packages
# 

# In[2]:


import matplotlib.pyplot as plt
import pandas as pd
import pylab as pl
import numpy as np
get_ipython().run_line_magic('matplotlib', 'inline')


# In[3]:


#Passing the csv file to a Pandas dataframe
df = pd.read_csv("FuelConsumption.csv")

df.head()


# ### Data Exploration

# In[4]:


# summarize the data
df.describe()


# Selecting features to explore.

# In[5]:


cdf = df[['ENGINESIZE','CYLINDERS','FUELCONSUMPTION_COMB','CO2EMISSIONS']]
cdf.head(9)


# Plotting each of the selected features.

# In[6]:


viz = cdf[['CYLINDERS','ENGINESIZE','CO2EMISSIONS','FUELCONSUMPTION_COMB']]
viz.hist()
plt.show()


# Plotting each of these features vs the Emission, to see how linear their relation is.

# In[7]:


plt.scatter(cdf.FUELCONSUMPTION_COMB, cdf.CO2EMISSIONS,  color='blue')
plt.xlabel("FUELCONSUMPTION_COMB")
plt.ylabel("Emission")
plt.show()


# In[8]:


plt.scatter(cdf.ENGINESIZE, cdf.CO2EMISSIONS,  color='blue')
plt.xlabel("Engine size")
plt.ylabel("Emission")
plt.show()


# Plotting **CYLINDER** vs the Emission, to see how linear their relation is.

# In[9]:


plt.scatter(cdf.CYLINDERS, cdf.CO2EMISSIONS,  color='blue')
plt.xlabel("Cylinders")
plt.ylabel("Emission")
plt.show()


# #### Creating train and test dataset
# 
# The dataset will be split into train and test sets, 80% of the entire data for training, and the 20% for testing. A mask will be created to select random rows using the **np.random.rand()** function: 

# In[10]:


msk = np.random.rand(len(df)) < 0.8
train = cdf[msk]
test = cdf[~msk]


# ### Simple Regression Model
# 
# Linear Regression fits a linear model with coefficients B = (B1, ..., Bn) to minimize the 'residual sum of squares' between the independent x in the dataset, and the dependent y by the linear approximation. 
# 

# #### Train data distribution
# 

# In[11]:


plt.scatter(train.ENGINESIZE, train.CO2EMISSIONS,  color='blue')
plt.xlabel("Engine size")
plt.ylabel("Emission")
plt.show()


# #### Modeling
# 
# Using sklearn package to model data.
# 

# In[12]:


from sklearn import linear_model
regr = linear_model.LinearRegression()
train_x = np.asanyarray(train[['ENGINESIZE']])
train_y = np.asanyarray(train[['CO2EMISSIONS']])
regr.fit (train_x, train_y)
# The coefficients
print ('Coefficients: ', regr.coef_)
print ('Intercept: ',regr.intercept_)


# **Coefficient** and **Intercept** in the simple linear regression, are the parameters of the fit line. 
# Given that it is a simple linear regression, with only 2 parameters, and knowing that the parameters are the intercept and slope of the line, sklearn can estimate them directly from our data. 
# All of the data must be available to traverse and calculate the parameters.

# #### Plot outputs

# Plotting the fit line over the data:

# In[13]:


plt.scatter(train.ENGINESIZE, train.CO2EMISSIONS,  color='blue')
plt.plot(train_x, regr.coef_[0][0]*train_x + regr.intercept_[0], '-r')
plt.xlabel("Engine size")
plt.ylabel("Emission")


# #### Evaluation
# 
# Comparing the actual values and predicted values to calculate the accuracy of a regression model. 
# 
# MSE will be used here to calculate the accuracy of the model based on the test set.

# In[14]:


from sklearn.metrics import r2_score

test_x = np.asanyarray(test[['ENGINESIZE']])
test_y = np.asanyarray(test[['CO2EMISSIONS']])
test_y_ = regr.predict(test_x)

print("Mean absolute error: %.2f" % np.mean(np.absolute(test_y_ - test_y)))
print("Residual sum of squares (MSE): %.2f" % np.mean((test_y_ - test_y) ** 2))
print("R2-score: %.2f" % r2_score(test_y , test_y_) )

