#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
Created on Wed April 25 00:20:45 2016

@author: Andrew Bauman

Function employs the movie class from media.py to create a movie trailer website

Move Parameters:
- Title
- Release Year
- Storyline
- Movie poster image
- Trailer
- Genre
- Rotten Tomatoes Rating
- My rating
"""

import media
import fresh_tomatoes

full_metal_jacket = media.Movie("Full Metal Jacket", 
                                "A marine journalist during the vietnam conflict",
                                 "(1987)",
                                "https://upload.wikimedia.org/wikipedia/en/9/99/Full_Metal_Jacket_poster.jpg", 
                                "https://www.youtube.com/watch?v=x9f6JaaX7Wg",
                                "[Drama, Action & Adventure]",
                                "95% Fresh",
                                "Compelling")


the_princess_bride = movie.Movie("The Princess Bride",
                                 "(1987)",
                                 "Boy from boy meets world meets book about boy meets girl",
                                 "http://ia.media-imdb.com/images/M/MV5BMTkzMDgyNjQwM15BMl5BanBnXkFtZTgwNTg2Mjc1MDE@._V1_SY317_CR0,0,214,317_AL_.jpg",
                                 "https://www.youtube.com/watch?v=VYgcrny2hRs",
                                 "[Action & Adventure, Kids & Family, Romance, Science Fiction & Fantasy, Comedy]",
                                 "97% Fresh",
                                 "As you wish")

blast_from_past = movie.Movie("Blast From The Past",
                                 "(1999)",
                                 "Girl meets boy from bomb shelter ",
                                 "https://www.movieposter.com/posters/archive/main/97/MPW-48881",
                                 "https://youtu.be/AhMQOb0tEmI",
                                 "[Comedy, Romance]",
                                 "58% Fresh",
                                 "Enjoyable")

# list to feed to movie web page generator
movies = [
  full_metal_jacket, 
  princess_bride, 
  blast_from_past, 
  zombieland, 
  idiocracy
  ]


def main():
  
  """
  Function creates a new HTML file populated with movie data, 
  and opens it in a new browser page.
  
  """
  fresh_tomatoes.open_movies_page(movies)
  
# Execute if run as primary

if__name__ == "__main__":
  main()
