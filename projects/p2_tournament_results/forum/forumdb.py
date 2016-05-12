#
# Database access functions for the web forum.
# 

import time
import psycopg2

## Database connection
DB = psycopg2.connect("dbname=forum")

## Set Cursor
c = DB.cursor()

## Get posts from database.
def GetAllPosts():
    '''Get all the posts from the database, sorted with the newest first.
    '''
    query = "SELECT time, content From posts ORDER BY time DESC"
    c.execute(query)
    fetched = c.fetchall()
    posts = ({'content': str(row[1]), 'time': str(row[0])} 
             for row in fetched)
    DB.close()
    return posts


## Add a post to the database.
def AddPost(content):
    '''Add a new post to the database.

    Args:
      content: The text content of the new post.
    '''
    query = "INSERT INTO posts (content) VALUES {})".format(content)
    c.execute(query)
    DB.commit()
    DB.close()
