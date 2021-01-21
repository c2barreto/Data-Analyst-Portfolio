#!/usr/bin/env python
# coding: utf-8

# # Predicting Customer Churn With Logistic Regression
# 
# A telecommunications company is concerned about the number of customers leaving their land-line business for cable competitors. They need to understand who is leaving. The goal is to find out who is leaving and why.
# 
# ## Objectives
# 
# Create a model for a telecommunication company, to predict when its customers will leave for a competitor, so that they can take some action to retain the customers.
# 
# -   Use scikit Logistic Regression to classify
# -   Understand confusion matrix

# <h1>Table of contents</h1>
# 
# <div class="alert alert-block alert-info" style="margin-top: 20px">
#     <ol>
#         <li><a href="#about_dataset">About the dataset</a></li>
#         <li><a href="#preprocessing">Data pre-processing and selection</a></li>
#         <li><a href="#modeling">Modeling (Logistic Regression with Scikit-learn)</a></li>
#         <li><a href="#evaluation">Evaluation</a></li>
#         <li><a href="#practice">Practice</a></li>
#     </ol>
# </div>

# In[1]:


import pandas as pd
import pylab as pl
import numpy as np
import scipy.optimize as opt
from sklearn import preprocessing
from sklearn.model_selection import train_test_split
get_ipython().run_line_magic('matplotlib', 'inline')
import matplotlib.pyplot as plt


# <h2 id="about_dataset">About the dataset</h2>
# 
# The dataset includes information about:
# 
# -   Customers who left within the last month – the column is called Churn
# -   Services that each customer has signed up for – phone, multiple lines, internet, online security, online backup, device protection, tech support, and streaming TV and movies
# -   Customer account information – how long they had been a customer, contract, payment method, paperless billing, monthly charges, and total charges
# -   Demographic info about customers – gender, age range, and if they have partners and dependents
# 

# ### Load the Telco Churn data
# 
# Telco Churn is a hypothetical data file that concerns a telecommunications company's efforts to reduce turnover in its customer base. Each case corresponds to a separate customer and it records various demographic and service usage information. 

# In[2]:


get_ipython().run_cell_magic('capture', '', '!wget -O ChurnData.csv https://s3-api.us-geo.objectstorage.softlayer.net/cf-courses-data/CognitiveClass/ML0101ENv3/labs/ChurnData.csv')


# ### Load Data From CSV File
# 

# In[3]:


churn_df = pd.read_csv("ChurnData.csv")
churn_df.head()


# <h2 id="preprocessing">Data pre-processing and selection</h2>
# 

# Selecting key features for the modeling. Also changing the target data type to be integer, as it is a requirement  by the skitlearn algorithm:
# 

# In[4]:


churn_df = churn_df[['tenure', 'age', 'address', 'income', 'ed', 'employ', 'equip',   'callcard', 'wireless','churn']]
churn_df['churn'] = churn_df['churn'].astype('int')
churn_df.head()


# In[5]:


churn_df.shape


# Defining X and Y for the dataset:

# In[6]:


X = np.asarray(churn_df[['tenure', 'age', 'address', 'income', 'ed', 'employ', 'equip']])
X[0:5]


# In[7]:


y = np.asarray(churn_df['churn'])
y [0:5]


# Normalizing the dataset:

# In[8]:


from sklearn import preprocessing
X = preprocessing.StandardScaler().fit(X).transform(X)
X[0:5]


# ## Train/Test dataset
# 

# Splitting the dataset into train and test set:

# In[9]:


from sklearn.model_selection import train_test_split
X_train, X_test, y_train, y_test = train_test_split( X, y, test_size=0.2, random_state=4)
print ('Train set:', X_train.shape,  y_train.shape)
print ('Test set:', X_test.shape,  y_test.shape)


# <h2 id="modeling">Modeling (Logistic Regression with Scikit-learn)</h2>
# 

# This version of Logistic Regression in Scikit-learn, supports regularization. Regularization is a technique used to solve the overfitting problem in machine learning models.
# **C** parameter indicates **inverse of regularization strength** which must be a positive float. Smaller values specify stronger regularization. 
# 
# Fitting the model with the train set:
# 

# In[10]:


from sklearn.linear_model import LogisticRegression
from sklearn.metrics import confusion_matrix
LR = LogisticRegression(C=0.01, solver='liblinear').fit(X_train,y_train)
LR


# Predicting values using the test set:
# 

# In[11]:


yhat = LR.predict(X_test)
yhat


# **predict_proba**  returns estimates for all classes, ordered by the label of classes. So, the first column is the probability of class 1, P(Y=1|X), and second column is probability of class 0, P(Y=0|X):
# 

# In[12]:


get_ipython().run_cell_magic('capture', '', 'yhat_prob = LR.predict_proba(X_test)\nyhat_prob')


# <h2 id="evaluation">Evaluation</h2>
# 

# ### jaccard index
# 
# The jaccard index will be used for accuracy evaluation. The jaccard is defined as the size of the intersection divided by the size of the union of two label sets. If the entire set of predicted labels for a sample strictly match with the true set of labels, then the subset accuracy is 1.0; otherwise it is 0.0.

# In[15]:


from sklearn.metrics import jaccard_score
jaccard_score(y_test, yhat)


# ### Confusion matrix
# 
# Another way of looking at accuracy of classifier is to look at a **confusion matrix**.
# 

# In[16]:


from sklearn.metrics import classification_report, confusion_matrix
import itertools
def plot_confusion_matrix(cm, classes,
                          normalize=False,
                          title='Confusion matrix',
                          cmap=plt.cm.Blues):
    """
    This function prints and plots the confusion matrix.
    Normalization can be applied by setting `normalize=True`.
    """
    if normalize:
        cm = cm.astype('float') / cm.sum(axis=1)[:, np.newaxis]
        print("Normalized confusion matrix")
    else:
        print('Confusion matrix, without normalization')

    print(cm)

    plt.imshow(cm, interpolation='nearest', cmap=cmap)
    plt.title(title)
    plt.colorbar()
    tick_marks = np.arange(len(classes))
    plt.xticks(tick_marks, classes, rotation=45)
    plt.yticks(tick_marks, classes)

    fmt = '.2f' if normalize else 'd'
    thresh = cm.max() / 2.
    for i, j in itertools.product(range(cm.shape[0]), range(cm.shape[1])):
        plt.text(j, i, format(cm[i, j], fmt),
                 horizontalalignment="center",
                 color="white" if cm[i, j] > thresh else "black")

    plt.tight_layout()
    plt.ylabel('True label')
    plt.xlabel('Predicted label')
print(confusion_matrix(y_test, yhat, labels=[1,0]))


# In[17]:


# Compute confusion matrix
cnf_matrix = confusion_matrix(y_test, yhat, labels=[1,0])
np.set_printoptions(precision=2)


# Plot non-normalized confusion matrix
plt.figure()
plot_confusion_matrix(cnf_matrix, classes=['churn=1','churn=0'],normalize= False,  title='Confusion matrix')


# The first row is for customers whose actual churn value in test set is 1.
# Out of 40 customers, the churn value of 15 of them is 1. 
# And out of these 15, the classifier correctly predicted 6 of them as 1, and 9 of them as 0. 
# 
# It means, for 6 customers, the actual churn value were 1 in test set, and classifier also correctly predicted those as 1. However, while the actual label of 9 customers were 1, the classifier predicted those as 0, which is not very good. It can be considered as an error of the model for the first row.
# 
# 
# In the second row there were 25 customers whom their churn value were 0. 
# 
# The classifier correctly predicted 24 of them as 0, and one of them wrongly as 1. So, it has done a good job in predicting the customers with churn value 0. A good thing about confusion matrix is that shows the model’s ability to correctly predict or separate the classes.  In specific case of binary classifier, such as this example, these numbers can be interpretted as the count of true positives, false positives, true negatives, and false negatives. 
# 

# In[18]:


print (classification_report(y_test, yhat))


# Based on the count of each section, the precision and recall of each label can be calculated:
# 
# -   **Precision** is a measure of the accuracy provided that a class label has been predicted. It is defined by: precision = TP / (TP + FP)
# 
# -   **Recall** is true positive rate. It is defined as: Recall =  TP / (TP + FN)
# 
# 
# 
# **F1 score:**
# The F1 scores for each label can be calculated based on the precision and recall of that label. 
# 
# The F1 score is the harmonic average of the precision and recall, where an F1 score reaches its best value at 1 (perfect precision and recall) and worst at 0. It is a good way to show that a classifer has a good value for both recall and precision.
# 
# And finally, the average accuracy for this classifier is the average of the F1-score for both labels, which is 0.72 in this case.
# 

# ### log loss
# 
# Using **log loss** for the model evaluation. In logistic regression, the output can be the probability of customer churn is yes (or equals to 1). This probability is a value between 0 and 1.
# Log loss( Logarithmic loss) measures the performance of a classifier where the predicted output is a probability value between 0 and 1. 
# 

# In[19]:


from sklearn.metrics import log_loss
log_loss(y_test, yhat_prob)

