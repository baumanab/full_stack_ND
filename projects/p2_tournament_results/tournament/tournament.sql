-- Table definitions for the tournament project.
--

-- players table: Players registered for tournament
-- field 1: name {text} name of a player
-- field 2: id {serial} unique id of a player

CREATE TABLE players ( name TEXT,
                       id SERIAL PRIMARY KEY );

-- matches table: Match results for tournament
--- field 1: match id (serial) unique id of the match played
-- field 2: result {real} result of a match. Winner = 1, Loser = 0
-- field 3: id {integer} player_id of a player, ties to id field of players table.

CREATE TABLE matches ( match_id SERIAL PRIMARY KEY,
                       result REAL,
                       FOREIGN KEY (player_id) REFERENCES players(id) );

