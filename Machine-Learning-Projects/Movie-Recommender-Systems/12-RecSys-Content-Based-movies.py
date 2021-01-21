#!/usr/bin/env python
# coding: utf-8

# # Movie Recommender System: Content Based Filtering
# 
# 
# Recommendation systems are a collection of algorithms used to recommend items to users based on information taken from the user. These systems have become ubiquitous, and can be commonly seen in online stores, movies databases and job finders. 
# **Content-Based** or **Item-Item recommendation systems**, attempts to figure out what a user's favourite aspects of an item is, and then recommends items that present those aspects. In this case, the goal is to figure out the input's favorite genres from the movies and ratings given.
# 
# ## Objectives
# 
# -   Create a recommendation system using content based filtering
# -   Evaulate the advantages and disadvantages of content based filtering

# ## Table of contents
# <div class="alert alert-block alert-info" style="margin-top: 20px">
#     <ol>
#         <li><a href="#ref1">Acquiring the Data</a></li>
#         <li><a href="#ref2">Preprocessing</a></li>
#         <li><a href="#ref3">Content-Based Filtering</a></li>
#     </ol>
# </div>

# <a id="ref1"></a> 
# ## Acquiring the Data

# Dataset acquired from [GroupLens](http://grouplens.org/datasets/movielens?cm_mmc=Email_Newsletter-_-Developer_Ed%2BTech-_-WW_WW-_-SkillsNetwork-Courses-IBMDeveloperSkillsNetwork-ML0101EN-SkillsNetwork-20718538&cm_mmca1=000026UJ&cm_mmca2=10006555&cm_mmca3=M12345678&cvosrc=email.Newsletter.M12345678&cvo_campaign=000026UJ&cm_mmc=Email_Newsletter-_-Developer_Ed%2BTech-_-WW_WW-_-SkillsNetwork-Courses-IBMDeveloperSkillsNetwork-ML0101EN-SkillsNetwork-20718538&cm_mmca1=000026UJ&cm_mmca2=10006555&cm_mmca3=M12345678&cvosrc=email.Newsletter.M12345678&cvo_campaign=000026UJ&cm_mmc=Email_Newsletter-_-Developer_Ed%2BTech-_-WW_WW-_-SkillsNetwork-Courses-IBMDeveloperSkillsNetwork-ML0101EN-SkillsNetwork-20718538&cm_mmca1=000026UJ&cm_mmca2=10006555&cm_mmca3=M12345678&cvosrc=email.Newsletter.M12345678&cvo_campaign=000026UJ&cm_mmc=Email_Newsletter-_-Developer_Ed%2BTech-_-WW_WW-_-SkillsNetwork-Courses-IBMDeveloperSkillsNetwork-ML0101EN-SkillsNetwork-20718538&cm_mmca1=000026UJ&cm_mmca2=10006555&cm_mmca3=M12345678&cvosrc=email.Newsletter.M12345678&cvo_campaign=000026UJ).

# In[1]:


get_ipython().run_cell_magic('capture', '', "!wget -O moviedataset.zip https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBMDeveloperSkillsNetwork-ML0101EN-SkillsNetwork/labs/Module%205/data/moviedataset.zip\nprint('unziping ...')\n!unzip -o -j moviedataset.zip ")


# <a id="ref2"></a>
# ## Preprocessing

# In[2]:


import pandas as pd
from math import sqrt
import numpy as np
import matplotlib.pyplot as plt
get_ipython().run_line_magic('matplotlib', 'inline')


# In[3]:


#Storing the movie information into a pandas dataframe
movies_df = pd.read_csv('movies.csv')

#Storing the user information into a pandas dataframe
ratings_df = pd.read_csv('ratings.csv')

movies_df.head()


# Removing the year from the **title** column by using pandas' replace function and store in a new **year** column.
# 

# In[4]:


#Parantheses are specified so there are no conflicts with movies that have years in their titles
movies_df['year'] = movies_df.title.str.extract('(\(\d\d\d\d\))',expand=False)

#Removing the parentheses
movies_df['year'] = movies_df.year.str.extract('(\d\d\d\d)',expand=False)

#Removing the years from the 'title' column
movies_df['title'] = movies_df.title.str.replace('(\(\d\d\d\d\))', '')

#Applying the strip function to get rid of any ending whitespace characters that may have appeared
movies_df['title'] = movies_df['title'].apply(lambda x: x.strip())

movies_df.head()


# Splitting the values in the **Genres** column into a **list of Genres** to simplify future use. 

# In[5]:


#Every genre is separated by a | so the split function will be applied on |
movies_df['genres'] = movies_df.genres.str.split('|')
movies_df.head()


# Since keeping genres in a list format isn't optimal for the content-based recommendation system technique, a One Hot Encoding technique will be applied to convert the list of genres to a vector where each column corresponds to one possible value of the feature. This encoding is needed for feeding categorical data. In this case, wevery different genre will be stored in columns that contain either 1 or 0. 1 shows that a movie has that genre and 0 shows that it doesn't. This dataframe will be stored in another variable since genres won't be important for our first recommendation system.

# In[6]:


#Copying the movie dataframe into a new one since the genre information won't be used in the the first case.
moviesWithGenres_df = movies_df.copy()

#For every row in the dataframe, iterate through the list of genres and place a 1 into the corresponding column
for index, row in movies_df.iterrows():
    for genre in row['genres']:
        moviesWithGenres_df.at[index, genre] = 1
        
#Filling in the NaN values with 0 to show that a movie doesn't have that column's genre
moviesWithGenres_df = moviesWithGenres_df.fillna(0)
moviesWithGenres_df.head()


# Next, is going through the ratings dataframe.
# 

# In[7]:


ratings_df.head()


# Every row in the ratings dataframe has a user id associated with at least one movie, a rating and a timestamp showing when they reviewed it. The timestamp column won't be needed so it will be dropped.
# 

# In[8]:


ratings_df = ratings_df.drop('timestamp', 1)
ratings_df.head()


# <a id="ref3"></a>
# ## Content-Based recommendation system

# Creating an input user to recommend movies to:

# In[9]:


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
# Next is to extract the input movie's ID's from the movies dataframe and add them into it.
# 
# This can be achieved by first filtering out the rows that contain the input movie's title and then merging this subset with the input dataframe.

# In[10]:


#Filtering out the movies by title
inputId = movies_df[movies_df['title'].isin(inputMovies['title'].tolist())]

#Then merging it to get the movieId. It's implicitly merging it by title.
inputMovies = pd.merge(inputId, inputMovies)

#Dropping information not needed from the input dataframe
inputMovies = inputMovies.drop('genres', 1).drop('year', 1)

#Final input dataframe
inputMovies


# The fun part now, learning the input's preferences! First is getting the subset of movies that the input has watched from the Dataframe containing genres defined with binary values.

# In[11]:


#Filtering out the movies from the input
userMovies = moviesWithGenres_df[moviesWithGenres_df['movieId'].isin(inputMovies['movieId'].tolist())]
userMovies


# Only a genre table is needed, the userMovies dataframe will be cleaned up a bit by resetting the index and dropping the movieId, title, genres and year columns.

# In[12]:


#Resetting the index to avoid future issues
userMovies = userMovies.reset_index(drop=True)

#Dropping unnecessary columns
userGenreTable = userMovies.drop('movieId', 1).drop('title', 1).drop('genres', 1).drop('year', 1)

userGenreTable


# Each genre will be converted into measureable weights. This can be done by taking the input's reviews and multiplying them into the input's genre table and then summing up the resulting table by column. This operation is actually a dot product between a matrix and a vector, so its time to call Pandas's "dot" function.

# In[13]:


inputMovies['rating']


# In[14]:


#Dot produt to get weights
userProfile = userGenreTable.transpose().dot(inputMovies['rating'])

#The user profile
userProfile


# Now, the user's preferences are weighted. This is known as the User Profile. Movies can now be recommended that satisfy the user's preferences.

# Extracting the genre table from the original dataframe:
# 

# In[15]:


#Getting the genres of every movie in the original dataframe
genreTable = moviesWithGenres_df.set_index(moviesWithGenres_df['movieId'])

#Dropping unneeded columns
genreTable = genreTable.drop('movieId', 1).drop('title', 1).drop('genres', 1).drop('year', 1)
genreTable.head()


# In[16]:


genreTable.shape


# Taking the weighted average of every movie based on the input profile and recommending the top twenty movies that most satisfy it.
# 

# In[17]:


#Multiply the genres by the weights and then take the weighted average
recommendationTable_df = ((genreTable*userProfile).sum(axis=1))/(userProfile.sum())
recommendationTable_df.head()


# In[18]:


#Sort recommendations in descending order
recommendationTable_df = recommendationTable_df.sort_values(ascending=False)

recommendationTable_df.head()


# Now here's the recommendation table!
# 

# In[19]:


movies_df.loc[movies_df['movieId'].isin(recommendationTable_df.head(20).keys())]


# ### Advantages and Disadvantages of Content-Based Filtering
# 
# ##### Advantages
# 
# -   Learns user's preferences
# -   Highly personalized for the user
# 
# ##### Disadvantages
# 
# -   Doesn't take into account what others think of the item, so low quality item recommendations might happen
# -   Extracting data is not always intuitive
# -   Determining what characteristics of the item the user dislikes or likes is not always obvious
# 
