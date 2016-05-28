-- clean up 
DROP VIEW IF EXISTS match_results;
DROP TABLE IF EXISTS matches;
DROP TABLE IF EXISTS players;
DROP DATABASE IF EXISTS tournament;

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

-- match_results view assembled from players and matches tables
-- supports playerStandings() function

CREATE VIEW match_results AS
SELECT players.id, players.name,
(SELECT count(*) FROM matches WHERE matches.winner_id = players.id) as wins,
(SELECT count(*) FROM matches WHERE players.id in (winner_id, loser_id)) as matches
FROM players
GROUP BY players.id
ORDER BY wins DESC;

