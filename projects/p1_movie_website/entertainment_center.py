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


the_princess_bride = media.Movie("The Princess Bride",
                                 "(1987)",
                                 "Boy from boy meets world meets book about boy meets girl",
                                 "http://ia.media-imdb.com/images/M/MV5BMTkzMDgyNjQwM15BMl5BanBnXkFtZTgwNTg2Mjc1MDE@._V1_SY317_CR0,0,214,317_AL_.jpg",
                                 "https://www.youtube.com/watch?v=VYgcrny2hRs",
                                 "[Action & Adventure, Kids & Family, Romance, Science Fiction & Fantasy, Comedy]",
                                 "97% Fresh",
                                 "As you wish")

blast_from_past = media.Movie("Blast From The Past",
                                 "(1999)",
                                 "Girl meets boy from bomb shelter ",
                                 "https://www.movieposter.com/posters/archive/main/97/MPW-48881",
                                 "https://youtu.be/AhMQOb0tEmI",
                                 "[Comedy, Romance]",
                                 "58% Fresh",
                                 "Enjoyable")

idiocracy = media.Movie("Idiocracy",
                                 "(2006)",
                                 "Boy meets girl, boy and girl left in cryo stasis, boy and girl in idiotic future world",
                                 "http://ia.media-imdb.com/images/M/MV5BMTk4NDYyNTU3Nl5BMl5BanBnXkFtZTcwNjE4NTQ0MQ@@._V1._CR11,6,327,487_UX182_CR0,0,182,268_AL_.jpg",
                                 "https://www.youtube.com/watch?v=BBvIweCIgwk",
                                 "[Adventure, Comedy, Sci-Fi, Thriller]",
                                 "74% Fresh",
                                 "Hilarious and sadly relatable")
								 
zombieland = media.Movie("Zombie Land",
                                 "(2009)",
                                 "Boys meets girls, and Bill Murray, during the Zombie apocolypse",
                                 "http://ia.media-imdb.com/images/M/MV5BMTU5MDg0NTQ1N15BMl5BanBnXkFtZTcwMjA4Mjg3Mg@@._V1_UY268_CR5,0,182,268_AL_.jpg",
                                 "https://www.youtube.com/watch?v=8m9EVP8X7N8",
                                 "[	Horror, Comedy]",
                                 "89% Fresh",
                                 "Zombieliscious")
						
goonies = media.Movie("Gooonies",
                                 "(1985)",
                                 "If you don't know, you better ask somebody",
                                 "https://resizing.flixster.com/Y1f-sWrYmumiRc2UtaY4QtQl-EM=/180x270/v1.bTsxMTE2NjczMDtqOzE3MDI5OzIwNDg7ODAwOzEyMDA",
                                 "www.youtube.com/watch?v=5qA2s_Vh0uE",
                                 "[	Horror, Comedy]",
                                 "69% Fresh",
                                 "Never say die")


# list to feed to movie web page generator
movies = [
  full_metal_jacket, 
  the_princess_bride, 
  blast_from_past,
  idiocracy,
  zombieland,
  goonies]


def main():
  
  """
  Function creates a new HTML file populated with movie data, 
  and opens it in a new browser page.
  
  """
  fresh_tomatoes.open_movies_page(movies)
  
# Execute if run as primary

if __name__ == "__main__":
    main()
