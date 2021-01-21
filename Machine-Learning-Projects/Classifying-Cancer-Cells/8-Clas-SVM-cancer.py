#!/usr/bin/env python
# coding: utf-8

# # Classifying Cancer Cells With Support Vector Machines 
# 
# 
# ## Objectives
# 
# -   Use scikit-learn to Support Vector Machine to to build and train a model using human cell records, and classify cells to whether the samples are benign or malignant.

# SVM works by mapping data to a high-dimensional feature space so that data points can be categorized, even when the data are not otherwise linearly separable. A separator between the categories is found, then the data is transformed in such a way that the separator could be drawn as a hyperplane. Following this, characteristics of new data can be used to predict the group to which a new record should belong.

# <h1>Table of contents</h1>
# 
# <div class="alert alert-block alert-info" style="margin-top: 20px">
#     <ol>
#         <li><a href="#load_dataset">Load the Cancer data</a></li>
#         <li><a href="#modeling">Modeling</a></li>
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


# <h2 id="load_dataset">Load the Cancer data</h2>
# The example is based on a dataset that is publicly available from the UCI Machine Learning Repository (Asuncion and Newman, 2007)[http://mlearn.ics.uci.edu/MLRepository.html]. The dataset consists of several hundred human cell sample records, each of which contains the values of a set of cell characteristics. The fields in each record are:
# 
# | Field name  | Description                 |
# | ----------- | --------------------------- |
# | ID          | Clump thickness             |
# | Clump       | Clump thickness             |
# | UnifSize    | Uniformity of cell size     |
# | UnifShape   | Uniformity of cell shape    |
# | MargAdh     | Marginal adhesion           |
# | SingEpiSize | Single epithelial cell size |
# | BareNuc     | Bare nuclei                 |
# | BlandChrom  | Bland chromatin             |
# | NormNucl    | Normal nucleoli             |
# | Mit         | Mitoses                     |
# | Class       | Benign or malignant         |
# 
# <br>
# <br>

# In[2]:


get_ipython().system('wget -O cell_samples.csv https://s3-api.us-geo.objectstorage.softlayer.net/cf-courses-data/CognitiveClass/ML0101ENv3/labs/cell_samples.csv')


# ### Load Data From CSV File
# 

# In[3]:


cell_df = pd.read_csv("cell_samples.csv")
cell_df.head()


# The ID field contains the patient identifiers. The characteristics of the cell samples from each patient are contained in fields Clump to Mit. The values are graded from 1 to 10, with 1 being the closest to benign.
# 
# The Class field contains the diagnosis, as confirmed by separate medical procedures, as to whether the samples are benign (value = 2) or malignant (value = 4).
# 
# Lets view the distribution of the classes based on Clump thickness and Uniformity of cell size:
# 

# In[4]:


ax = cell_df[cell_df['Class'] == 4][0:50].plot(kind='scatter', x='Clump', y='UnifSize', color='DarkBlue', label='malignant');
cell_df[cell_df['Class'] == 2][0:50].plot(kind='scatter', x='Clump', y='UnifSize', color='Yellow', label='benign', ax=ax);
plt.show()


# ## Data pre-processing and selection
# 

# Viewing columns initial data types:

# In[5]:


cell_df.dtypes


# It looks like the **BareNuc** column includes some values that are not numerical. We can drop those rows:
# 

# In[6]:


cell_df = cell_df[pd.to_numeric(cell_df['BareNuc'], errors='coerce').notnull()]
cell_df['BareNuc'] = cell_df['BareNuc'].astype('int')
cell_df.dtypes


# In[7]:


feature_df = cell_df[['Clump', 'UnifSize', 'UnifShape', 'MargAdh', 'SingEpiSize', 'BareNuc', 'BlandChrom', 'NormNucl', 'Mit']]
X = np.asarray(feature_df)
X[0:5]


# The goal is for the model to predict the value of Class (that is, benign (=2) or malignant (=4)). As this field can have one of only two possible values. The measurement levels will be changed to reflect this.
# 

# In[8]:


cell_df['Class'] = cell_df['Class'].astype('int')
y = np.asarray(cell_df['Class'])
y [0:5]


# ## Train/Test dataset
# 

# Splitting the dataset into train and test set:
# 

# In[9]:


X_train, X_test, y_train, y_test = train_test_split( X, y, test_size=0.2, random_state=4)
print ('Train set:', X_train.shape,  y_train.shape)
print ('Test set:', X_test.shape,  y_test.shape)


# <h2 id="modeling">Modeling (SVM with Scikit-learn)</h2>
# 

# The SVM algorithm offers a choice of kernel functions for performing its processing. Basically, mapping data into a higher dimensional space is called kernelling. The mathematical function used for the transformation is known as the kernel function, and can be of different types, such as:
# 
# ```
# 1.Linear
# 2.Polynomial
# 3.Radial basis function (RBF)
# 4.Sigmoid
# ```
# 
# Each of these functions has its characteristics, its pros and cons, and its equation, but as there's no easy way of knowing which function performs best with any given dataset, its normal to choose different functions in turn and compare the results. The default, RBF (Radial Basis Function) will be used.

# In[10]:


from sklearn import svm
clf = svm.SVC(kernel='rbf')
clf.fit(X_train, y_train) 


# After being fitted, the model can then be used to predict new values:
# 

# In[11]:


yhat = clf.predict(X_test)
yhat [0:5]


# <h2 id="evaluation">Evaluation</h2>
# 

# In[12]:


from sklearn.metrics import classification_report, confusion_matrix
import itertools


# In[13]:


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


# In[14]:


# Compute confusion matrix
cnf_matrix = confusion_matrix(y_test, yhat, labels=[2,4])
np.set_printoptions(precision=2)

print (classification_report(y_test, yhat))

# Plot non-normalized confusion matrix
plt.figure()
plot_confusion_matrix(cnf_matrix, classes=['Benign(2)','Malignant(4)'],normalize= False,  title='Confusion matrix')


# Using the **f1_score** to measure model accuracy:

# In[15]:


from sklearn.metrics import f1_score
f1_score(y_test, yhat, average='weighted') 


# Using jaccard index to measure model accuracy:

# In[16]:


from sklearn.metrics import jaccard_similarity_score
jaccard_similarity_score(y_test, yhat)

