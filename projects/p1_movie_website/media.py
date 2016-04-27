# -*- coding: utf-8 -*-
#!/usr/bin/env python

"""
Created on Sat Nov 28 19:54:52 2015

@author: Andrew
"""


import webbrowser


class Movie():
    '''
    This class provides a way to store movie attributes and information.
    '''
    
    def __init__(self, movie_title, release_year,movie_storyline, poster_image,
                 trailer_youtube, genre, rott_tom_rating, my_rating):
        self.title = movie_title
        self.release_year = release_year
        self.storyline = movie_storyline
        self.poster_image_url = poster_image
        self.trailer_youtube_url = trailer_youtube
        self.genre = genre
        self.rott_tom_rating = rott_tom_rating # Rotten Tomatoes rating
        self.my_rating = my_rating

    def show_trailer(self):
        webbrowser.open(self.trailer_youtube_url)
