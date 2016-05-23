-- Sandbox for testing out queries to put in tournament.py

DROP VIEW match_results;
DROP TABLE matches;
DROP TABLE players;



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
					   
CREATE VIEW match_results AS
	SELECT match_id,
		   unnest(array['win', 'loss']) AS result,
		   unnest(array[1, 0]) AS result_value,
		   unnest(array[winner_id, loser_id]) AS player_id
	FROM matches
	ORDER BY match_id;
					   
					   
-- add some players

INSERT INTO players (Name) VALUES ('gg');
INSERT INTO players (Name) VALUES ('hh');
INSERT INTO players (Name) VALUES ('jj');
INSERT INTO players (Name) VALUES ('ii');
INSERT INTO players (Name) VALUES ('ee');

-- report some matches

INSERT INTO matches (winner_id, loser_id) VALUES (1,2);
INSERT INTO matches (winner_id, loser_id) VALUES (1,4);
INSERT INTO matches (winner_id, loser_id) VALUES (2,3);
INSERT INTO matches (winner_id, loser_id) VALUES (3,5);
INSERT INTO matches (winner_id, loser_id) VALUES (3,2);
INSERT INTO matches (winner_id, loser_id) VALUES (1,3);


select * from players;

select * from matches;

-- player standings

SELECT players.id, name, count(matches.winner_id) as wins
FROM players LEFT JOIN matches
ON players.id = matches.winner_id
GROUP BY players.id;

SELECT players.id, name, count(matches.loser_id) as losses
FROM players LEFT JOIN matches
ON players.id = matches.loser_id
GROUP BY players.id;

SELECT match_id,
       unnest(array['win', 'loss']) AS result,
	   unnest(array[1, 0]) AS result_value,
       unnest(array[winner_id, loser_id]) AS player_id
FROM matches
ORDER BY match_id;