#!/usr/bin/env python
# coding: utf-8

# # Movie Reccomender System: User-User Filtering
# 
# **User-User Filtering**, is also known as **Collaborative Filtering**. This technique uses other users to recommend items to the input user. It attempts to find users that have similar preferences and opinions as the input and then recommends items that they have liked to the input. There are several methods of finding similar users and the one that will be used here is going to be based on the **Pearson Correlation Function**.
# 
# 
# ## Objectives
# 
# -   Create a movie recommendation system based on User-User filtering.
# -   Evaulate the advantages and disadvantages of User-User filtering.

# <h1>Table of contents</h1>
# 
# <div class="alert alert-block alert-info" style="margin-top: 20px">
#     <ol>
#         <li><a href="#ref1">Acquiring the Data</a></li>
#         <li><a href="#ref2">Preprocessing</a></li>
#         <li><a href="#ref3">User-User Filtering</a></li>
#     </ol>
# </div>

# <a id="ref1"></a>
# 
# # Acquiring the Data
# 

# 
# Dataset acquired from [GroupLens](http://grouplens.org/datasets/movielens?cm_mmc=Email_Newsletter-_-Developer_Ed%2BTech-_-WW_WW-_-SkillsNetwork-Courses-IBMDeveloperSkillsNetwork-ML0101EN-SkillsNetwork-20718538&cm_mmca1=000026UJ&cm_mmca2=10006555&cm_mmca3=M12345678&cvosrc=email.Newsletter.M12345678&cvo_campaign=000026UJ&cm_mmc=Email_Newsletter-_-Developer_Ed%2BTech-_-WW_WW-_-SkillsNetwork-Courses-IBMDeveloperSkillsNetwork-ML0101EN-SkillsNetwork-20718538&cm_mmca1=000026UJ&cm_mmca2=10006555&cm_mmca3=M12345678&cvosrc=email.Newsletter.M12345678&cvo_campaign=000026UJ&cm_mmc=Email_Newsletter-_-Developer_Ed%2BTech-_-WW_WW-_-SkillsNetwork-Courses-IBMDeveloperSkillsNetwork-ML0101EN-SkillsNetwork-20718538&cm_mmca1=000026UJ&cm_mmca2=10006555&cm_mmca3=M12345678&cvosrc=email.Newsletter.M12345678&cvo_campaign=000026UJ&cm_mmc=Email_Newsletter-_-Developer_Ed%2BTech-_-WW_WW-_-SkillsNetwork-Courses-IBMDeveloperSkillsNetwork-ML0101EN-SkillsNetwork-20718538&cm_mmca1=000026UJ&cm_mmca2=10006555&cm_mmca3=M12345678&cvosrc=email.Newsletter.M12345678&cvo_campaign=000026UJ).

# In[2]:


get_ipython().run_cell_magic('capture', '', "!wget -O moviedataset.zip https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBMDeveloperSkillsNetwork-ML0101EN-SkillsNetwork/labs/Module%205/data/moviedataset.zip\nprint('unziping ...')\n!unzip -o -j moviedataset.zip ")


# <hr>
# 
# <a id="ref2"></a>
# 
# # Preprocessing
# 

# In[3]:


import pandas as pd
from math import sqrt
import numpy as np
import matplotlib.pyplot as plt
get_ipython().run_line_magic('matplotlib', 'inline')


# In[4]:


#Storing the movie information into a pandas dataframe
movies_df = pd.read_csv('movies.csv')
#Storing the user information into a pandas dataframe
ratings_df = pd.read_csv('ratings.csv')


# Viewing how the movies_df is organized
# 

# In[5]:


movies_df.head()


# Removing the year from the **title** column by using pandas' replace function and storing it in a new **year** column.
# 

# In[6]:


#Parantheses are specified so there are no I conflicts with movies that have years in their titles
movies_df['year'] = movies_df.title.str.extract('(\(\d\d\d\d\))',expand=False)

#Removing the parentheses
movies_df['year'] = movies_df.year.str.extract('(\d\d\d\d)',expand=False)

#Removing the years from the 'title' column
movies_df['title'] = movies_df.title.str.replace('(\(\d\d\d\d\))', '')

#Applying the strip function to get rid of any ending whitespace characters that may have appeared
movies_df['title'] = movies_df['title'].apply(lambda x: x.strip())


# Viewing the results!
# 

# In[7]:


movies_df.head()


# Dropping the genres column since it's not needed for this particular recommendation system.
# 

# In[8]:


movies_df = movies_df.drop('genres', 1)


# Updated movies dataframe:
# 

# In[9]:


movies_df.head()


# <br>
# 

# Next, is viewing the ratings dataframe.

# In[10]:


ratings_df.head()


# Every row in the ratings dataframe has a user id associated with at least one movie, a rating and a timestamp showing when they reviewed it. The timestamp column is not needed, so it will be dropped.
# 

# In[11]:


ratings_df = ratings_df.drop('timestamp', 1)


# Updated ratings_df
# 

# In[12]:


ratings_df.head()


# <hr>
# 
# <a id="ref3"></a>
# 
# # User-User Filtering
# 

# The process for creating a User Based recommendation system is as follows:
# 
# -   Select a user with the movies the user has watched
# -   Based on his rating to movies, find the top X neighbours 
# -   Get the watched movie record of the user for each neighbour.
# -   Calculate a similarity score using some formula
# -   Recommend the items with the highest score
# 
# An input user will be created to recommend movies to:

# In[13]:


userInput = [
            {'title':'Breakfast Club, The', 'rating':5},
            {'title':'Toy Story', 'rating':3.5},
            {'title':'Jumanji', 'rating':2},
            {'title':"Pulp Fiction", 'rating':5},
            {'title':'Akira', 'rating':4.5}
         ] 
inputMovies = pd.DataFrame(userInput)
inputMovies


# #### Add movieId to input user
# 
# The inputMovies's ID's will be extracted from the movies dataframe and added to InputMovies dataframe.
# 
# This will be achieved by first filtering out the rows that contain the input movies' title and then merging this subset with the input dataframe.

# In[14]:


#Filtering out the movies by title
inputId = movies_df[movies_df['title'].isin(inputMovies['title'].tolist())]

#Then merging it to get the movieId. It's implicitly merging it by title.
inputMovies = pd.merge(inputId, inputMovies)

#Dropping information that won't be used from the input dataframe
inputMovies = inputMovies.drop('year', 1)

inputMovies


# #### The users who have seen the same movies
# 
# Now with the movie ID's in the created inputMovies dataframe, next is to fetch the subset of users that have watched and reviewed the movies in the input.
# 

# In[15]:


#Filtering out users that have watched movies that the input has watched and storing it
userSubset = ratings_df[ratings_df['movieId'].isin(inputMovies['movieId'].tolist())]
userSubset.head()


# Grouping up the rows by user ID.
# 

# In[16]:


#Groupby creates several sub dataframes where they all have the same value in the column specified as the parameter
userSubsetGroup = userSubset.groupby(['userId'])


# Viewing an example user with ID: 1130.

# In[17]:


userSubsetGroup.get_group(1130)


# Sorting these groups so the users that share the most movies in common with the input have higher priority.

# In[18]:


#Sorting it so users with movie most in common with the input will have priority
userSubsetGroup = sorted(userSubsetGroup,  key=lambda x: len(x[1]), reverse=True)


# Looking at the first user
# 

# In[19]:


userSubsetGroup[0:3]


# #### Similarity of users to input user
# 
# Next, is comparing all users (not really all !!!) to a specified user and finding the one that is most similar.  
# The **Pearson Correlation Coefficient** will be used to find out how similar each user is to the input. It is used to measure the strength of a linear association between two variables. The formula for finding this coefficient between sets X and Y with N values can be seen in the image below. 
# 
# Why Pearson Correlation?
# 
# Pearson correlation is invariant to scaling, i.e. multiplying all elements by a nonzero constant or adding any constant to all elements. For example, there are two vectors X and Y,then, pearson(X, Y) == pearson(X, 2 \* Y + 3). This is a pretty important property in recommendation systems because two users might rate two series of items totally different in terms of absolute rates, but they would be similar users (i.e. with similar ideas) with similar rates in various scales.
# 
# $$r = \frac{\sum_{i=1}^n{(x_i-\bar{x})(y_i-\bar{y})}}{\sqrt{\sum_{i=1}^n{(x_i-\bar{x})^2}}\sqrt{\sum_{i=1}^n{(y_i-\bar{y})^2}}}$$
# 
# The values given by the formula vary from r = -1 to r = 1, where 1 forms a direct correlation between the two entities (it means a perfect positive correlation) and -1 forms a perfect negative correlation. 
# 
# In this case, a 1 means that the two users have similar tastes while a -1 means the opposite.
# 

# First, is selecting a subset of users to iterate through. This limit is imposed to not waste too much time going through every single user.
# 

# In[20]:


userSubsetGroup = userSubsetGroup[0:100]


# Then, calculating the Pearson Correlation between input user and the subset group, and storing it in a dictionary, where the key is the user Id and the value is the coefficient

# In[21]:


#Store the Pearson Correlation in a dictionary, where the key is the user Id and the value is the coefficient
pearsonCorrelationDict = {}

#For every user group in this defined subset
for name, group in userSubsetGroup:
    
    #Sorting the input and current user group so the values aren't mixed up later on
    group = group.sort_values(by='movieId')
    inputMovies = inputMovies.sort_values(by='movieId')
    
    #Get the N for the formula
    nRatings = len(group)
    
    #Get the review scores for the movies that they both have in common
    temp_df = inputMovies[inputMovies['movieId'].isin(group['movieId'].tolist())]
    
    #And then store them in a temporary buffer variable in a list format to facilitate future calculations
    tempRatingList = temp_df['rating'].tolist()
    
    #Placing the current user group reviews in a list format
    tempGroupList = group['rating'].tolist()
    
    #Calculating the pearson correlation between two users, so called, x and y
    Sxx = sum([i**2 for i in tempRatingList]) - pow(sum(tempRatingList),2)/float(nRatings)
    Syy = sum([i**2 for i in tempGroupList]) - pow(sum(tempGroupList),2)/float(nRatings)
    Sxy = sum( i*j for i, j in zip(tempRatingList, tempGroupList)) - sum(tempRatingList)*sum(tempGroupList)/float(nRatings)
    
    #If the denominator is different than zero, then divide, else, 0 correlation.
    if Sxx != 0 and Syy != 0:
        pearsonCorrelationDict[name] = Sxy/sqrt(Sxx*Syy)
    else:
        pearsonCorrelationDict[name] = 0


# In[31]:


get_ipython().run_cell_magic('capture', '', 'pearsonCorrelationDict.items()')


# In[23]:


pearsonDF = pd.DataFrame.from_dict(pearsonCorrelationDict, orient='index')
pearsonDF.columns = ['similarityIndex']
pearsonDF['userId'] = pearsonDF.index
pearsonDF.index = range(len(pearsonDF))
pearsonDF.head()


# #### The top x similar users to input user
# 
# Getting the top 50 users that are most similar to the input.
# 

# In[24]:


topUsers=pearsonDF.sort_values(by='similarityIndex', ascending=False)[0:50]
topUsers.head()


# Next is to start recommending movies to the input user.
# 
# #### Rating of selected users to all movies
# 
# This will be completed by taking the weighted average of the ratings of the movies using the Pearson Correlation as the weight. But first is getting the movies watched by the users in the **pearsonDF** from the ratings dataframe and then storing their correlation in a new column called \_similarityIndex". This is achieved below by merging of these two tables.
# 

# In[25]:


topUsersRating=topUsers.merge(ratings_df, left_on='userId', right_on='userId', how='inner')
topUsersRating.head()


# Now all that is needed is to multiply the movie rating by its weight (The similarity index), then sum up the new ratings and divide it by the sum of the weights.
# 
# In other words, multiplying two columns, then grouping up the dataframe by movieId and then dividing two columns:
# 
# It shows the idea of all similar users to candidate movies for the input user:
# 

# In[26]:


#Multiplies the similarity by the user's ratings
topUsersRating['weightedRating'] = topUsersRating['similarityIndex']*topUsersRating['rating']
topUsersRating.head()


# In[27]:


#Applies a sum to the topUsers after grouping it up by userId
tempTopUsersRating = topUsersRating.groupby('movieId').sum()[['similarityIndex','weightedRating']]
tempTopUsersRating.columns = ['sum_similarityIndex','sum_weightedRating']
tempTopUsersRating.head()


# In[28]:


#Creates an empty dataframe
recommendation_df = pd.DataFrame()

#take the weighted average
recommendation_df['weighted average recommendation score'] = tempTopUsersRating['sum_weightedRating']/tempTopUsersRating['sum_similarityIndex']
recommendation_df['movieId'] = tempTopUsersRating.index
recommendation_df.head()


# Sort and see the top 20 movies that the algorithm recommended!
# 

# In[29]:


recommendation_df = recommendation_df.sort_values(by='weighted average recommendation score', ascending=False)
recommendation_df.head(10)


# In[30]:


movies_df.loc[movies_df['movieId'].isin(recommendation_df.head(10)['movieId'].tolist())]


# ### Advantages and Disadvantages of User-User Filtering
# 
# ##### Advantages
# 
# -   Takes other user's ratings into consideration
# -   Doesn't need to study or extract information from the recommended item
# -   Adapts to the user's interests which might change over time
# 
# ##### Disadvantages
# 
# -   Approximation function can be slow
# -   There might be a low of amount of users to approximate
# -   Privacy issues when trying to learn the user's preferences

# In[ ]:




