#!/usr/bin/env python
# coding: utf-8

# 
# # Decision Tree For Prescribing Medications
# 
# A decision tree classification algorithm is needed to build a model from historical data of patients, and their response to different medications. The trained decision tree will be needed to predict the class of a unknown patient, or to find a proper drug for a new patient.
# 
# 
# ## Objectives
# 
# -   Develop a classification model using a Decision Tree Algorithm.
# -   Verify the model is able to predict the class of an unknown patient.

# <h1>Table of contents</h1>
# 
# <div class="alert alert-block alert-info" style="margin-top: 20px">
#     <ol>
#         <li><a href="#about_dataset">About the dataset</a></li>
#         <li><a href="#downloading_data">Downloading the Data</a></li>
#         <li><a href="#pre-processing">Pre-processing</a></li>
#         <li><a href="#setting_up_tree">Setting up the Decision Tree</a></li>
#         <li><a href="#modeling">Modeling</a></li>
#         <li><a href="#prediction">Prediction</a></li>
#         <li><a href="#evaluation">Evaluation</a></li>
#         <li><a href="#visualization">Visualization</a></li>
#     </ol>
# </div>

# In[1]:


import numpy as np 
import pandas as pd
from sklearn.tree import DecisionTreeClassifier


# <div id="about_dataset">
#     <h2>About the dataset</h2>
#     Data has been collected on a set of patients, all of whom suffered from the same illness. During their course of treatment, each patient responded to one of 5 medications, Drug A, Drug B, Drug c, Drug x and y. 
#     <br>
#     <br>
#     The goal is to build a model to find out which drug might be appropriate for a future patient with the same illness. The feature sets of this dataset are Age, Sex, Blood Pressure, and Cholesterol of patients, and the target is the drug that each patient responded to.
#     <br>
#     <br>
#     It is a sample of multiclass classifier, and the training part of the dataset can be used
#     to build a decision tree, and then used to predict the class of a unknown patient, or to prescribe it to a new patient.
# </div>

# <div id="downloading_data"> 
#     <h2>Downloading the Data</h2>
# </div>
# 

# In[2]:


get_ipython().run_cell_magic('capture', '', '!wget -O drug200.csv https://s3-api.us-geo.objectstorage.softlayer.net/cf-courses-data/CognitiveClass/ML0101ENv3/labs/drug200.csv')


# In[3]:


my_data = pd.read_csv("drug200.csv", delimiter=",")
my_data[0:5]


# In[4]:


my_data.shape


# <div href="pre-processing">
#     <h2>Pre-processing</h2>
# </div>
# 

# <ul>
#     <li> <b> X </b> as the <b> Feature Matrix </b> (data of my_data) </li>
#     <li> <b> y </b> as the <b> response vector (target) </b> </li>
# </ul>
# 

# In[5]:


X = my_data[['Age', 'Sex', 'BP', 'Cholesterol', 'Na_to_K']].values
X[0:5]


# Some features in this dataset are categorical such as **Sex** or **BP**. Sklearn Decision Trees do not handle categorical variables. But these features can be converted to numerical values.

# In[6]:


from sklearn import preprocessing
le_sex = preprocessing.LabelEncoder()
le_sex.fit(['F','M'])
X[:,1] = le_sex.transform(X[:,1]) 


le_BP = preprocessing.LabelEncoder()
le_BP.fit([ 'LOW', 'NORMAL', 'HIGH'])
X[:,2] = le_BP.transform(X[:,2])


le_Chol = preprocessing.LabelEncoder()
le_Chol.fit([ 'NORMAL', 'HIGH'])
X[:,3] = le_Chol.transform(X[:,3]) 

X[0:5]


# Filling the target variable:
# 

# In[7]:


y = my_data["Drug"]
y[0:5]


# <hr>
# 
# <div id="setting_up_tree">
#     <h2>Setting up the Decision Tree</h2>
# </div>

# In[8]:


from sklearn.model_selection import train_test_split


# Now <b> train_test_split </b> will return 4 different parameters. They will be named:<br>
# X_trainset, X_testset, y_trainset, y_testset <br> <br>
# The <b> train_test_split </b> will need the parameters: <br>
# X, y, test_size=0.3, and random_state=3. <br> <br>
# The <b>X</b> and <b>y</b> are the arrays required before the split, the <b>test_size</b> represents the ratio of the testing dataset, and the <b>random_state</b> ensures that we obtain the same splits.

# In[9]:


X_trainset, X_testset, y_trainset, y_testset = train_test_split(X, y, test_size=0.3, random_state=3)


# In[10]:


print('Shape of X training set {}'.format(X_trainset.shape),'&',' Size of Y training set {}'.format(y_trainset.shape))


# In[12]:


print('Shape of X training set {}'.format(X_testset.shape),'&',' Size of Y training set {}'.format(y_testset.shape))


# <div id="modeling">
#     <h2>Modeling</h2>
#     First is creating an instance of the <b>DecisionTreeClassifier</b> called <b>drugTree</b>.<br>
#     Inside of the classifier, the following will be specified: <i> criterion="entropy" </i> so the information gain of each node can be viewed
# </div>

# In[13]:


drugTree = DecisionTreeClassifier(criterion="entropy", max_depth = 4)
drugTree # it shows the default parameters


# Next, is fitting the data with the training feature matrix <b> X_trainset </b> and training  response vector <b> y_trainset </b>

# In[14]:


drugTree.fit(X_trainset,y_trainset)


# <hr>
# 
# <div id="prediction">
#     <h2>Prediction</h2>
#     Making <b>predictions</b> on the testing dataset and storing it into a variable called <b>predTree</b>.
# </div>

# In[15]:


predTree = drugTree.predict(X_testset)


# Visually comparig the prediction to the actual values.

# In[16]:


print (predTree [0:5])
print (y_testset [0:5])


# <hr>
# 
# <div id="evaluation">
#     <h2>Evaluation</h2>
#     Importing <b>metrics</b> from sklearn and checking the accuracy of the model.
# </div>

# In[17]:


from sklearn import metrics
import matplotlib.pyplot as plt
print("DecisionTrees's Accuracy: ", metrics.accuracy_score(y_testset, predTree))


# **Accuracy classification score** computes subset accuracy: the set of labels predicted for a sample must exactly match the corresponding set of labels in y_true.  
# 
# In multilabel classification, the function returns the subset accuracy. If the entire set of predicted labels for a sample strictly match with the true set of labels, then the subset accuracy is 1.0; otherwise it is 0.0.
# 

# <hr>
# 
# <div id="visualization">
#     <h2>Visualization</h2>
# </div>
# 

# In[21]:


get_ipython().run_cell_magic('capture', '', '!pip install pydotplus \n!pip install graphviz ')


# In[23]:


from six import StringIO
import pydotplus
import matplotlib.image as mpimg
from sklearn import tree
get_ipython().run_line_magic('matplotlib', 'inline')


# In[24]:


dot_data = StringIO()
filename = "drugtree.png"
featureNames = my_data.columns[0:5]
targetNames = my_data["Drug"].unique().tolist()
out=tree.export_graphviz(drugTree,feature_names=featureNames, out_file=dot_data, class_names= np.unique(y_trainset), filled=True,  special_characters=True,rotate=False)  
graph = pydotplus.graph_from_dot_data(dot_data.getvalue())  
graph.write_png(filename)
img = mpimg.imread(filename)
plt.figure(figsize=(100, 200))
plt.imshow(img,interpolation='nearest')

