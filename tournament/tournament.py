#!/usr/bin/env python
# 
# tournament.py -- implementation of a Swiss-system tournament
#

import psycopg2
from functools import wraps
from itertools import izip


def connect():
    """Connect to the PostgreSQL database.  Returns a database connection."""
    return psycopg2.connect("dbname=tournament")
    
# a wrapper generator
def decorator(f):
    @wraps(f)
    def wrapper(*args, **kwds):
        return f(*args, **kwds)
    return wrapper
    
# decorator function for select queries
@decorator
def select_query(func):    
    
    """Decorator function to wrap select queries"""
    def wrapped_func():
        DB = connect()
        c = DB.cursor()
        response = func(c)
        DB.close()
        return response
    return wrapped_func
    
# a decorator function for transaction queries
@decorator
def transaction_query(func): 
    
    """A decorator function for transaction queries"""
    def wrapped_func(*args):
        DB = connect()
        c = DB.cursor()
        func(*args, c= c)
        DB.commit()
        DB.close()
    return wrapped_func


# transaction query to delete matches
@transaction_query
def deleteMatches(c= None):    
    
    """Remove all matches from the matches table"""
    
    query = "DELETE FROM matches;"
    c.execute(query)
    

@transaction_query
def deletePlayers(c= None):
    """Remove all the player records from the database."""
    query = "DELETE FROM players;"
    c.execute(query)

# a function to count players in the players table, wrapped by the select query function
@select_query
def countPlayers(c= None):    
    
    """Returns the number of players in the tournament players table"""
    
    query = "SELECT count(*) FROM players;"
    c.execute(query)
    return c.fetchone()[0]


@transaction_query
def registerPlayer(name, c= None):
    """Adds a player to the tournament database.
  
    The database assigns a unique serial id number for the player.  (This
    should be handled by your SQL database schema, not in your Python code.)
  
    Args:
      name: the player's full name (need not be unique).
    """
    
    query = "INSERT INTO players (Name) VALUES (%s);"
    c.execute(query, (name,))

@select_query
def playerStandings(c= None):
    """Returns a list of the players and their win records, sorted by wins.

    The first entry in the list should be the player in first place, or a player
    tied for first place if there is currently a tie.

    Returns:
      A list of tuples, each of which contains (id, name, wins, matches):
        id: the player's unique id (assigned by the database)
        name: the player's full name (as registered)
        wins: the number of matches the player has won
        matches: the number of matches the player has played
    """
    query = "SELECT * FROM match_results;"
    c.execute(query)
    return c.fetchall()
    

@transaction_query  
def reportMatch(winner, loser, c= None):
    """Records the outcome of a single match between two players.

    Args:
      winner:  the id number of the player who won
      loser:  the id number of the player who lost
    """
    query = "INSERT INTO matches (winner_id, loser_id) VALUES (%s, %s);"
    c.execute(query, (winner, loser,))
 
@select_query 
def swissPairings(c = None):
    """Returns a list of pairs of players for the next round of a match.
  
    Assuming that there are an even number of players registered, each player
    appears exactly once in the pairings.  Each player is paired with another
    player with an equal or nearly-equal win record, that is, a player adjacent
    to him or her in the standings.
  
    Returns:
      A list of tuples, each of which contains (id1, name1, id2, name2)
        id1: the first player's unique id
        name1: the first player's name
        id2: the second player's unique id
        name2: the second player's name
    """
    
    query = "SELECT id, name from match_results"
    c.execute(query)
    to_pair = c.fetchall()
    to_pair_iter = iter(to_pair)
    pairings = (c+next(to_pair_iter, '') for c in to_pair_iter)
    return list(pairings)
    
    


