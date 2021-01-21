#!/usr/bin/env python
# coding: utf-8

# # Polynomial Regression on Car Engine Size Vs Emissions
# 
# 
# ## Objectives
# 
# -   Use scikit-learn to implement Polynomial Regression on features within the automobile data set.
# -   Create a model, train,test and use the model.
# -   Evaluate the accuracy of the model using mean absolute error, residual sum of squares, and R2-score.

# <h1>Table of contents</h1>
# 
# <div class="alert alert-block alert-info" style="margin-top: 20px">
#     <ol>
#         <li><a href="#download_data">Downloading Data</a></li>
#         <li><a href="#polynomial_regression">Polynomial regression</a></li>
#         <li><a href="#evaluation">Evaluation</a></li>
#         <li><a href="#practice">Practice</a></li>
#     </ol>
# </div>

# ### Importing Needed packages
# 

# In[1]:


import matplotlib.pyplot as plt
import pandas as pd
import pylab as pl
import numpy as np
get_ipython().run_line_magic('matplotlib', 'inline')


# <h2 id="download_data">Downloading Data</h2>

# In[2]:


get_ipython().run_cell_magic('capture', '', '!wget -O FuelConsumption.csv https://s3-api.us-geo.objectstorage.softlayer.net/cf-courses-data/CognitiveClass/ML0101ENv3/labs/FuelConsumptionCo2.csv')


# ## About the Data
# 
# ### `FuelConsumption.csv`:
# 
# Contains model-specific fuel consumption ratings and estimated carbon dioxide emissions for new light-duty vehicles for retail sale in Canada. [Dataset source](http://open.canada.ca/data/en/dataset/98f1a129-f628-4ce4-b24d-6f16bf24dd64?cm_mmc=Email_Newsletter-_-Developer_Ed%2BTech-_-WW_WW-_-SkillsNetwork-Courses-IBMDeveloperSkillsNetwork-ML0101EN-SkillsNetwork-20718538&cm_mmca1=000026UJ&cm_mmca2=10006555&cm_mmca3=M12345678&cvosrc=email.Newsletter.M12345678&cvo_campaign=000026UJ&cm_mmc=Email_Newsletter-_-Developer_Ed%2BTech-_-WW_WW-_-SkillsNetwork-Courses-IBMDeveloperSkillsNetwork-ML0101EN-SkillsNetwork-20718538&cm_mmca1=000026UJ&cm_mmca2=10006555&cm_mmca3=M12345678&cvosrc=email.Newsletter.M12345678&cvo_campaign=000026UJ&cm_mmc=Email_Newsletter-_-Developer_Ed%2BTech-_-WW_WW-_-SkillsNetwork-Courses-IBMDeveloperSkillsNetwork-ML0101EN-SkillsNetwork-20718538&cm_mmca1=000026UJ&cm_mmca2=10006555&cm_mmca3=M12345678&cvosrc=email.Newsletter.M12345678&cvo_campaign=000026UJ&cm_mmc=Email_Newsletter-_-Developer_Ed%2BTech-_-WW_WW-_-SkillsNetwork-Courses-IBMDeveloperSkillsNetwork-ML0101EN-SkillsNetwork-20718538&cm_mmca1=000026UJ&cm_mmca2=10006555&cm_mmca3=M12345678&cvosrc=email.Newsletter.M12345678&cvo_campaign=000026UJ)
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

# In[3]:


#Passing the CSV file to a Pandas dataframe
df = pd.read_csv("FuelConsumption.csv")

df.head()


# Selecting features that will be used for regression.

# In[4]:


cdf = df[['ENGINESIZE','CYLINDERS','FUELCONSUMPTION_COMB','CO2EMISSIONS']]
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


# <h2 id="polynomial_regression">Polynomial regression</h2>
# 

# Polynomial regression: where the relationship between the independent variable x and the dependent variable y is modeled as an nth degree polynomial in x. 
# 
# Since there are only x values in this data set (such as **Engine Size**) a few additional features will be created: 1, $x$, and $x^2$.
# 
# **PolynomialFeatures()** function in Scikit-learn library, drives a new feature sets from the original feature set. That is, a matrix will be generated consisting of all polynomial combinations of the features with degree less than or equal to the specified degree. For example, lets say the original feature set has only one feature, _ENGINESIZE_. Now, if the degree of the polynomial set to be 2, then it generates 3 features, degree=0, degree=1 and degree=2: 
# 

# In[7]:


from sklearn.preprocessing import PolynomialFeatures
from sklearn import linear_model
train_x = np.asanyarray(train[['ENGINESIZE']])
train_y = np.asanyarray(train[['CO2EMISSIONS']])

test_x = np.asanyarray(test[['ENGINESIZE']])
test_y = np.asanyarray(test[['CO2EMISSIONS']])


poly = PolynomialFeatures(degree=2)
train_x_poly = poly.fit_transform(train_x)
train_x_poly


# Essentially, this functions creats feature sets for multiple linear regression analysis. 
# 
# Now, the model can be dealt as a 'linear regression' problem.  
# 
# **LinearRegression()** function can be used now:

# In[8]:


clf = linear_model.LinearRegression()
train_y_ = clf.fit(train_x_poly, train_y)

print ('Coefficients: ', clf.coef_)
print ('Intercept: ',clf.intercept_)


# **Coefficient** and **Intercept** , are the parameters of the fit curvy line. 
# Given that it is a typical multiple linear regression, with 3 parameters, and knowing that the parameters are the intercept and coefficients of hyperplane, sklearn has estimated them from the new set of feature sets. Time to plot it:

# In[9]:


plt.scatter(train.ENGINESIZE, train.CO2EMISSIONS,  color='blue')
XX = np.arange(0.0, 10.0, 0.1)
yy = clf.intercept_[0]+ clf.coef_[0][1]*XX+ clf.coef_[0][2]*np.power(XX, 2)
plt.plot(XX, yy, '-r' )
plt.xlabel("Engine size")
plt.ylabel("Emission")


# <h2 id="evaluation">Evaluation</h2>
# 

# In[10]:


from sklearn.metrics import r2_score

test_x_poly = poly.fit_transform(test_x)
test_y_ = clf.predict(test_x_poly)

print("Mean absolute error: %.2f" % np.mean(np.absolute(test_y_ - test_y)))
print("Residual sum of squares (MSE): %.2f" % np.mean((test_y_ - test_y) ** 2))
print("R2-score: %.2f" % r2_score(test_y_ , test_y) )

