#!/usr/bin/env python
# coding: utf-8

# # Applying K-Nearest Neighbors For Marketing Telecoms Services
# 
# 
# ## Objectives
# 
# -   Load the telecoms customer dataset and fit the data for modeling.
# -   Use K Nearest neighbors to classify and segment customer data.
# -   Use K Nearest neighbors to predict customer categories for marketing.

# <h1>Table of contents</h1>
# 
# <div class="alert alert-block alert-info" style="margin-top: 20px">
#     <ol>
#         <li><a href="#about_dataset">About the dataset</a></li>
#         <li><a href="#visualization_analysis">Data Visualization and Analysis</a></li>
#         <li><a href="#classification">Classification</a></li>
#     </ol>
# </div>

# In[1]:


import itertools
import numpy as np
import matplotlib.pyplot as plt
from matplotlib.ticker import NullFormatter
import pandas as pd
import numpy as np
import matplotlib.ticker as ticker
from sklearn import preprocessing
get_ipython().run_line_magic('matplotlib', 'inline')


# <div id="about_dataset">
#     <h2>About the dataset</h2>
# </div>
# 

# A telecommunications provider has segmented its customer base by service usage patterns, categorizing the customers into four groups. If demographic data can be used to predict group membership, the company can customize offers for individual prospective customers. It is a classification problem. That is, given the dataset,  with predefined labels, a model needs to be built to predict a class of a new or unknown case. 
# 
# The example focuses on using demographic data, such as region, age, and marital, to predict usage patterns. 
# 
# The target field, called **custcat**, has four possible values that correspond to the four customer groups, as follows:
#   1- Basic Service
#   2- E-Service
#   3- Plus Service
#   4- Total Service

# In[2]:


get_ipython().run_cell_magic('capture', '', '!wget -O teleCust1000t.csv https://s3-api.us-geo.objectstorage.softlayer.net/cf-courses-data/CognitiveClass/ML0101ENv3/labs/teleCust1000t.csv')


# ### Load Data From CSV File
# 

# In[3]:


df = pd.read_csv('teleCust1000t.csv')
df.head()


# <div id="visualization_analysis">
#     <h2>Data Visualization and Analysis</h2> 
# </div>
# 

# #### Viewing how many of each class is in the data set

# In[4]:


df['custcat'].value_counts()


# #### 281 Plus Service, 266 Basic-service, 236 Total Service, and 217 E-Service customers
# 

# In[5]:


df.hist(column='income', bins=50)


# ### Feature set
# 

# In[6]:


df.columns


# To use scikit-learn library, the Pandas data frame must be converted to a Numpy array:

# In[7]:


X = df[['region', 'tenure','age', 'marital', 'address', 'income', 'ed', 'employ','retire', 'gender', 'reside']] .values  #.astype(float)
X[0:5]


# In[8]:


y = df['custcat'].values
y[0:5]


# ## Normalize Data
# 

# Data Standardization give data zero mean and unit variance.

# In[9]:


X = preprocessing.StandardScaler().fit(X).transform(X.astype(float))
X[0:5]


# ### Train Test Split

# In[10]:


from sklearn.model_selection import train_test_split
X_train, X_test, y_train, y_test = train_test_split( X, y, test_size=0.2, random_state=4)
print ('Train set:', X_train.shape,  y_train.shape)
print ('Test set:', X_test.shape,  y_test.shape)


# <div id="classification">
#     <h2>Classification</h2>
# </div>
# 

# <h3>K nearest neighbor (KNN)</h3>
# 

# In[11]:


from sklearn.neighbors import KNeighborsClassifier


# ### Training
# 
# Starting the algorithm with k=4 for now:

# In[12]:


k = 4
#Train Model and Predict  
neigh = KNeighborsClassifier(n_neighbors = k).fit(X_train,y_train)
neigh


# ### Predicting
# 
# Using the trained model to predict the test set:

# In[13]:


yhat = neigh.predict(X_test)
yhat[0:5]


# ### Accuracy evaluation
# 
# In multilabel classification, **accuracy classification score** is a function that computes subset accuracy. This function is equal to the jaccard_similarity_score function. Essentially, it calculates how closely the actual labels and predicted labels are matched in the test set.
# 

# In[14]:


from sklearn import metrics
print("Train set Accuracy: ", metrics.accuracy_score(y_train, neigh.predict(X_train)))
print("Test set Accuracy: ", metrics.accuracy_score(y_test, yhat))


# Building the model again, but this time with k=6

# In[15]:


k = 6

neigh2 = KNeighborsClassifier(n_neighbors = k).fit(X_train,y_train)
neigh2
yhat2 = neigh.predict(X_test)
yhat2[0:5]
print("Train set Accuracy: ", metrics.accuracy_score(y_train, neigh2.predict(X_train)))
print("Test set Accuracy: ", metrics.accuracy_score(y_test, yhat2))


# #### What about other K?
# 
# The accuracy of KNN for different K's can be calculated.

# In[16]:


Ks = 10
mean_acc = np.zeros((Ks-1))
std_acc = np.zeros((Ks-1))
ConfustionMx = [];
for n in range(1,Ks):
    
    
    neigh = KNeighborsClassifier(n_neighbors = n).fit(X_train,y_train)
    yhat=neigh.predict(X_test)
    mean_acc[n-1] = metrics.accuracy_score(y_test, yhat)

    
    std_acc[n-1]=np.std(yhat==y_test)/np.sqrt(yhat.shape[0])

mean_acc


# #### Plotting  model accuracy  for Different number of Neighbors

# In[17]:


plt.plot(range(1,Ks),mean_acc,'g')
plt.fill_between(range(1,Ks),mean_acc - 1 * std_acc,mean_acc + 1 * std_acc, alpha=0.10)
plt.legend(('Accuracy ', '+/- 3xstd'))
plt.ylabel('Accuracy ')
plt.xlabel('Number of Nabors (K)')
plt.tight_layout()
plt.show()


# In[18]:


print( "The best accuracy was with", mean_acc.max(), "with k=", mean_acc.argmax()+1) 

