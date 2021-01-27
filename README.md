# Data Analyst Portfolio

---
This repository is a portfolio of data science projects I've completed for self learning and under the IBM Data Science Professional Certificate Program on Coursera. The projects are presented in the form of Jupyter Notebooks.
[Certificate Link](https://www.youracclaim.com/badges/8dafbf44-59e1-4a50-a50b-cc63c7027af7?source=linked_in_profile)

# Commulative Projects: Data Analysis with Python 
---
### [Clustering: Strategic New Fitness Centers in Los Angeles](https://github.com/c2barreto/Data-Analyst-Portfolio/blob/main/Data-Analysis-Projects/Strategic-New-Fitness-Centers-LA/Capstone-Opening-More-Fitness-Centers-LA.ipynb)

The overall goal is to minimize travel for all Los Angeles residents in need of access to a local gym while promoting health across the city. The objective of this project in particular is to determine optimal locations for a new gym or fitness center within Los Angeles. Specifically, the end result is to compile a list of Los Angeles neighborhoods that have no gyms or fitness centers within 3000 meters from their center points.

Data Methodology:
  + Data Gathering
  + Geocoding LA Neighborhoods
  + Data Visualization: Mapping Los Angeles
  + Exploring Neighborhood Venues With Foursquare API
  + Clustering Neighborhoods by Gym & Fitness Center Data

### [Machine Learning: Modeling Loan Classifiers](https://github.com/c2barreto/Data-Analyst-Portfolio/blob/main/Data-Analysis-Projects/Modeling-Loan-Classifiers/Modeling-Loan-Classifiers.ipynb)

The project goal is to build an accurate model that can predict whether loans from customers will be paid off or sent to collections. Several loan classifier models are to be built using machine learning on a dataset about past loans. The best classification model will be selected after each model's accuracy is evaluated.

Data Methodology:

  + Preprocessing & Data Exploration
  + Classification Models
    + K Nearest Neighbor(KNN)
    + Decision Tree
    + Support Vector Machine
    + Logistic Regression
  + Model Evaluation Using Test Set
    + Preprocessing Test Set for Evaluation
    + Testing Each Model

### Developing an Automobile Price Prediction Model

Utilizing a public automobile dataset for machine learning, the goal is to explore and formulate models that can best predict a fair but accurate price for automobiles based on features or characteristics they hold. This project has been broken down into multiple notebooks.

Data Methodology:

  + [Data Wrangling: Automobile Data Set](https://github.com/c2barreto/Data-Analyst-Portfolio/blob/main/Data-Analysis-Projects/Automobile-Price-Prediction-Model/1-Data-Wrangling.ipynb)
  + [Exploratory Analysis on Features that Impact Automobile Prices](https://github.com/c2barreto/Data-Analyst-Portfolio/blob/main/Data-Analysis-Projects/Automobile-Price-Prediction-Model/2-Exploratory-data-analysis.ipynb)
  + [Developing Models to Predict Automobile Prices](https://github.com/c2barreto/Data-Analyst-Portfolio/blob/main/Data-Analysis-Projects/Automobile-Price-Prediction-Model/3-model-development.ipynb)
  + [Automobile Price Prediction Model: Evaluation and Refinement](https://github.com/c2barreto/Data-Analyst-Portfolio/blob/main/Data-Analysis-Projects/Automobile-Price-Prediction-Model/4-model-evaluation-and-refinement.ipynb)

### Intercollegiate Athlethics Database
  + Created an [ERD](https://github.com/c2barreto/Data-Analyst-Portfolio/blob/main/SQL/Intercollegiate-Athletic-Database/1-Background%20on%20Intercollegiate%20Atheltic%20Database.pdf) for a database to support the scheduling and operations of intercollegiate athletic events.
  + Utilized SQL to [create tables](https://github.com/c2barreto/Data-Analyst-Portfolio/blob/main/SQL/Intercollegiate-Athletic-Database/3-CreateTables.sql) and to define column data types, primary keys, foreign keys, and additional constraints.
  + Queried [ad hoc requests](https://github.com/c2barreto/Data-Analyst-Portfolio/blob/main/SQL/Intercollegiate-Athletic-Database/5-JoinStatementQueries.sql) involving multiple joins between different tables and specific clauses to filter the data.

# Machine Learning Algorithms with Python
---
### [Movie Recommender System: Content Based Filtering](https://github.com/c2barreto/Data-Analyst-Portfolio/blob/main/Machine-Learning-Projects/Movie-Recommender-Systems/12-RecSys-Content-Based-movies.ipynb)

Recommendation systems are a collection of algorithms used to recommend items to users based on information taken from the user. These systems have become ubiquitous, and can  be commonly seen in online stores, movies databases and job finders. Content-Based or Item-Item recommendation systems, attempts to figure out what a user's favourite aspects of an item is, and then recommends items that present those aspects. In this case, the goal is to figure out the input's favorite genres from the movies and ratings given.

### [Movie Reccomender System: User-User Filtering](https://github.com/c2barreto/Data-Analyst-Portfolio/blob/main/Machine-Learning-Projects/Movie-Recommender-Systems/13-RecSys-User-Filtering-movies.ipynb) 
  
User-User Filtering, is also known as Collaborative Filtering. This technique uses other users to recommend items to the input user. It attempts to find users that have similar preferences and opinions as the input and then recommends items that they have liked to the input. There are several methods of finding similar users and the one that will be used here is going to be based on the Pearson Correlation Function.
 
 ### [Classifying Cancer Cells With Support Vector Machines](https://github.com/c2barreto/Data-Analyst-Portfolio/blob/main/Machine-Learning-Projects/Classifying-Cancer-Cells/8-Clas-SVM-cancer.ipynb)
 
 Support Vector Machines (SVM) work by mapping data to a high-dimensional feature space so that data points can be categorized, even when the data is not otherwise linearly separable. Characteristics of new data can be used to predict the group to which a new record should belong. The goal for this project is to use SVM to build and train a model using human cell records, and classify cells to whether the samples are benign or malignant.
 
 ### [Predicting Customer Churn With Logistic Regression](https://github.com/c2barreto/Data-Analyst-Portfolio/blob/main/Machine-Learning-Projects/Logistic-Regression-On-Customer-Churn/7-Clas-Logistic-Reg-churn.ipynb)
 
 A telecommunications company is concerned about the number of customers leaving their land-line business for cable competitors. They need to understand who is leaving.
Logistic regression will be used on a data set about customers who left in order to build a model that can classify and predict if current customers will leave for a competitor, so that they can take some action to retain the customers.
 
 ### [Decision Tree For Prescribing Medications](https://github.com/c2barreto/Data-Analyst-Portfolio/blob/main/Machine-Learning-Projects/Decision-Tree/6-Clas-Decision-Trees-drug.ipynb)
 
 A decision tree classification algorithm is needed to build a model from historical data of patients, and their response to different medications. The trained decision tree will be built to predict the class of a unknown patient, or to find a proper drug for a new patient.
 

 ### [Non Linear Regression Analysis on China's GDP](https://github.com/c2barreto/Data-Analyst-Portfolio/blob/main/Machine-Learning-Projects/Non-Linear-Regression-China-GDP/4-Reg-NoneLinearRegression.ipynb)
 
 The goal is to Fit a non-linear model to the datapoints corrensponding to China's GDP from 1960 to 2014 in order to predict it's future growth. The model's accuracy is evaluated using mean absolute error, residual sum of squares, and R2-score
 
 ### Applying Regression Alorithms on Fuel Consumption to Predict CO2 Emissions
   * [Polynomial Regression on Car Engine Size Vs Emissions](https://github.com/c2barreto/Data-Analyst-Portfolio/blob/main/Machine-Learning-Projects/Regression-On-CO2-Emissions/3-Polynomial-Regression-Co2.ipynb)
 
   * [Multiple Linear Regression To Predict CO2 Emissions](https://github.com/c2barreto/Data-Analyst-Portfolio/blob/main/Machine-Learning-Projects/Regression-On-CO2-Emissions/2-Mulitple-Linear-Regression-Co2.ipynb)
 
   * [Simple Linear Regression to Predict CO2 Emissions](https://github.com/c2barreto/Data-Analyst-Portfolio/blob/main/Machine-Learning-Projects/Regression-On-CO2-Emissions/1-Simple-Linear-Regression-Co2.ipynb)

# Data Visualization with Python 
---
Exploring a dataset containing annual data on the flows of international immigrants. The goal is to visualize immigration trends to Canada using multiple graphing techniques in Python.   
  + [Visualizing Immigration Trends to Canada with Regression Plots](https://github.com/c2barreto/Data-Analyst-Portfolio/blob/main/Data-Visualization-Projects/4-Regression-Plots.ipynb)
  + [Visualizing Immigration Trends to Canada with Pie Charts, Box Plots, Scatter Plots, & Bubble Plots](https://github.com/c2barreto/Data-Analyst-Portfolio/blob/main/Data-Visualization-Projects/3-Pie-Charts-Box-Plots-Scatter-Plots.ipynb)
  + [Visualizing Immigration Trends to Canada with Area Plots, Hiostograms, & Bar Charts](https://github.com/c2barreto/Data-Analyst-Portfolio/blob/main/Data-Visualization-Projects/2-Area-Plots-Histograms-and-Bar-Charts.ipynb)
  + [Filtering & Visualizing Immigration Trends to Canada With Line Plots](https://github.com/c2barreto/Data-Analyst-Portfolio/blob/main/Data-Visualization-Projects/1-Filtering-LinePlotting.ipynb)
