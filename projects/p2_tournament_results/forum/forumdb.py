#
# Database access functions for the web forum.
# 

import psycopg2

<<<<<<< HEAD

def GetAllPosts():
    '''Get all the posts from the database, sorted with the newest first.
    '''

=======
## Get posts from database.
def GetAllPosts():
    '''Get all the posts from the database, sorted with the newest first.
    '''
>>>>>>> 1b7fb009434c688131048692c11ce2cfb2934c17
    DB = psycopg2.connect("dbname=forum")
    c = DB.cursor()
    query = "SELECT time, content FROM posts ORDER BY time DESC"
    c.execute(query)
    fetched = c.fetchall()
    posts = ({'content': str(row[1]), 'time': str(row[0])} for row in fetched)
    DB.close()
    return posts


## Add a post to the database.
def AddPost(content):
    '''Add a new post to the database.

    Args:
      content: The text content of the new post.
    '''
<<<<<<< HEAD

    DB = psycopg2.connect("dbname=forum")
    c = DB.cursor()
    query = "INSERT INTO posts (content) VALUES ({}))".format(content)
=======
    DB = psycopg2.connect("dbname=forum")
    c = DB.cursor()
    query = "INSERT INTO posts (content) VALUES ('{}'))".format(content)
>>>>>>> 1b7fb009434c688131048692c11ce2cfb2934c17
    c.execute(query)
    DB.commit()
    DB.close()
