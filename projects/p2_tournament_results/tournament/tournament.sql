-- create tournament database
CREATE DATABASE tournament;

-- connect to tournament
\c tournament

-- Table definitions for the tournament project.
--

-- players table: Players registered for tournament
-- field 1: name {text} name of a player
-- field 2: id {serial} unique id of a player

CREATE TABLE players ( name TEXT,
                       id SERIAL PRIMARY KEY );

-- matches table: Match results for tournament
-- field 1: match id (serial) unique id of the match played
-- field 2: result {real} result of a match. Winner = 1, Loser = 0
-- field 3: id {integer} player_id of a player, ties to id field of players table.

CREATE TABLE matches ( match_id SERIAL PRIMARY KEY,
                       winner_id INT,
					   loser_id INT,
					   FOREIGN KEY (winner_id) REFERENCES players(id),
                       FOREIGN KEY (loser_id) REFERENCES players(id) );

-- unnested matches view
-- melts (unpivots) matches to create a row for each player per match
-- assigns a value of 1 for a win and 0 for losses
-- Columns: [match_id, result, value, player id], where results is 'win' or 'loss'
-- This view is used in playerStandings function.

CREATE VIEW match_results AS
	SELECT match_id,
	       unnest(array[winner_id, loser_id]) AS player_id,
		   unnest(array['win', 'loss']) AS result,
		   unnest(array[1, 0]) AS result_value
	FROM matches
	ORDER BY match_id;

