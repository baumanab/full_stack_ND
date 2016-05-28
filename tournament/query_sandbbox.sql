-- Sandbox for testing out queries to put in tournament.py

DROP VIEW IF EXISTS match_results;
DROP VIEW IF EXISTS standings;
DROP TABLE IF EXISTS matches;
DROP TABLE IF EXISTS players;

\pset border 2
\pset linestyle unicode
\pset format wrapped
\f ','
\o sandbox_script_output




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
                       


/* Ultimately I need to calculate wins and number of matches per player, but I want to keep
the match table in a tidy form where each row represents an observation of a match. To that end
I played with a view that "melted" or unpivotted the data. It ended up not being quite what I needed,
but was fun learning expereince nonethless. View code saved for future reference.					   
*/

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

-- winners
/*
SELECT players.id, name, count(matches.winner_id) as wins
FROM players LEFT JOIN matches
ON players.id = matches.winner_id
GROUP BY players.id;

-- losers

SELECT players.id, name, count(matches.loser_id) as losses
FROM players LEFT JOIN matches
ON players.id = matches.loser_id
GROUP BY players.id;


*/
-- melt/unpivot joined players and matches tabble with unnest

SELECT match_id,
       unnest(array[winner_id, loser_id]) AS player_id,
       unnest(array['win', 'loss']) AS result,
	   unnest(array[1, 0]) AS result_value

FROM matches
ORDER BY match_id;

/*

-- select and rename columns and add player names

SELECT match_results.player_id as id, players.name, SUM(match_results.result_value) AS wins, COUNT(match_results.player_id) AS matches
FROM players JOIN match_results
ON players.id = match_results.player_id
GROUP BY player_id, players.name
ORDER BY wins DESC;
*/

-- Try to pull this off the last couple of steps in a single query
-- The driver for this is not to be elegant but to save running the queries above 
-- multiple times during use of the backend. My backup is going to be creating another view

SELECT sub_match_results.player_id as id, players.name, SUM(sub_match_results.result_value) AS wins, COUNT(sub_match_results.player_id) AS matches
FROM 
(SELECT match_id,
       unnest(array[winner_id, loser_id]) AS player_id,
       unnest(array['win', 'loss']) AS result,
	   unnest(array[1, 0]) AS result_value

FROM matches) AS sub_match_results
JOIN 
players
ON players.id = sub_match_results.player_id
GROUP BY player_id, players.name
ORDER BY wins DESC;

/*
this worked:  Here is the key that really simplifies the concept of subquries etc.
Just about everything you do has to be from a table.  So in this case if you have

SELECT table1.field, table2.field FROM table1, table2
     FROM table1 JOIN table2...yadda yadda yadds

the JOIN part is a table, you are selecting from the table created by the JOIN operation
in the case of a more complex querie, each subquery or view or whatever is just a table
so just think of it as a table. For you organic chemists, it is the R group in a synthesis
involing complex molecules.  At the end of the day you are still just working with a functional
group and R is just an object.  In this case the table is just an object.
*/


-- need to have players appear in match results prior to any match reports

/*
try something based on players table
COALESCE will return the vlaue of the inner function unless the information is not present, in which case
it will return the specified value. This will only work if the empty table is grouped (which is technically not empty
because there will be at least one row representing the GROUP BY operatiion).  See the psql documentation for details.
*/

SELECT result_id, COALESCE(SUM(result_value), 0) AS wins, COUNT(sub_match_results.result_id) as matches
FROM
(SELECT winner_id, loser_id,
       unnest(array[winner_id, loser_id]) AS result_id,
       unnest(array['win', 'loss']) AS result,
	   unnest(array[1, 0]) AS result_value
 FROM matches) AS sub_match_results
GROUP BY result_id
ORDER BY wins DESC;


DELETE FROM matches;

SELECT result_id, COALESCE(SUM(result_value), 0) AS wins, COUNT(sub_match_results.result_id) as matches
FROM
(SELECT winner_id, loser_id,
       unnest(array[winner_id, loser_id]) AS result_id,
       unnest(array['win', 'loss']) AS result,
	   unnest(array[1, 0]) AS result_value
 FROM matches) AS sub_match_results
GROUP BY result_id
ORDER BY wins DESC;

/*
So this is not working the way I would like.  I wrote additional queries that pulled in player name
but in the end it was either too complex, not a good representation of the underlying data or didn't work
prior to populating the matches table. I would rather do something more straight forward.
*/

SELECT players.id, players.name,
(SELECT count(*) FROM matches WHERE matches.winner_id = players.id) as wins,
(SELECT count(*) FROM matches WHERE players.id in (winner_id, loser_id)) as matches
FROM players
GROUP BY players.id
ORDER BY wins DESC;

-- Seems to work, now let's add some matches and check the result
INSERT INTO matches (winner_id, loser_id) VALUES (1,2);
INSERT INTO matches (winner_id, loser_id) VALUES (1,4);
INSERT INTO matches (winner_id, loser_id) VALUES (2,3);
INSERT INTO matches (winner_id, loser_id) VALUES (3,5);
INSERT INTO matches (winner_id, loser_id) VALUES (3,2);
INSERT INTO matches (winner_id, loser_id) VALUES (1,3);

SELECT players.id, players.name,
(SELECT count(*) FROM matches WHERE matches.winner_id = players.id) as wins,
(SELECT count(*) FROM matches WHERE players.id in (winner_id, loser_id)) as matches
FROM players
GROUP BY players.id
ORDER BY wins DESC;




