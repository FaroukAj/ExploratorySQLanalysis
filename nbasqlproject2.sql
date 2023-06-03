USE groceries;

SELECT * FROM players;

-- Calculate the average height, weight, and age of players by position.
SELECT DISTINCT Position, ROUND(AVG(Height_CM/30.48),2) AS AVG_Height , AVG(Weight) AS AVG_Weight, AVG(Age) AS AVG_Age
FROM players
GROUP BY position;

-- Determine the number of players who changed teams each season.
WITH team_switch AS (
SELECT f.season, COUNT( DISTINCT f.player)
FROM players f
JOIN players s
WHERE f.team <> s.team AND f.season > s.season
GROUP BY f.season
)
SELECT * FROM team_switch;

-- Calculate the percentage of players who were drafted each year that played at least 5 seasons in the league.
WITH player_percentage AS (
SELECT Draft_year,
COUNT(DISTINCT player) AS Player_count
FROM players
GROUP BY Draft_year
),
four_years AS (
SELECT Draft_year,
COUNT(DISTINCT player) AS four_year_Player_count
FROM players
WHERE seasons_in_league > 4
GROUP BY Draft_year
)
SELECT pp.Draft_year, 
pp.Player_count,
fy.four_year_Player_count,
ROUND((fy.four_year_Player_count *100)/pp.Player_count,2) AS percentage_of_players
FROM player_percentage pp
LEFT JOIN four_years fy
ON pp.Draft_year = fy.Draft_year;

-- Determine the total number of players who were drafted each year.
SELECT Draft_year, COUNT(DISTINCT Player) 
FROM players
GROUP BY Draft_year;

-- Calculate the average number of seasons in the league for each position.
SELECT DISTINCT Position, ROUND(AVG(Seasons_in_league))
FROM players
GROUP BY Position;


-- Identify the top 10 players with the highest all time Real_value.
SELECT DISTINCT player, SUM(real_value) AS All_time_real_value
FROM players
GROUP BY  player
ORDER BY All_time_real_value DESC
LIMIT 10;



-- Find the average height of players by conference and position.
SELECT Position, (select DISTINCT conference), AVG(Height)
FROM players
GROUP BY conference, Position;
