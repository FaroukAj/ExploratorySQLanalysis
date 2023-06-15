/* TASK: WRITE A QUERY TO FIND OUT ALL PLAYERS SELECTED IN A CONVENTIONAL DRAFT AND THEIR DRAFT COMBINE STATS */
SELECT dc.season,  
       dc.player_id, 
       dc.player_name, 
       dc.position, 
       dc.height_w_shoes_ft_in, 
       dc.height_wo_shoes_ft_in , 
       dc.weight, 
       dc.standing_vertical_leap, 
       dc.max_vertical_leap,
       dh.person_id, 
       dh.player_name, 
       dh.round_number, 
       dh.round_pick, 
       dh.draft_type
FROM draft_combine_stats dc
LEFT OUTER JOIN draft_history dh
ON dc.player_id = dh.person_id
WHERE dh.draft_type NOT NULL;

/* TASK: BUILDING OFF OF PREVIOUS QUERY,  FIND OUT THE TOP 15 HEAVIEST PLAYERS AT DRAFT  */
SELECT dc.season, 
       dc.player_id, 
       dc.player_name, 
       dc.position, 
       dc.height_w_shoes_ft_in, 
       dc.height_wo_shoes_ft_in , 
       dc.weight, dc.standing_vertical_leap, 
       dc.max_vertical_leap,
       dh.person_id, 
       dh.player_name, 
       dh.round_number, 
       dh.round_pick, 
       dh.draft_type
FROM draft_combine_stats dc
LEFT OUTER JOIN draft_history dh
ON dc.player_id = dh.person_id
WHERE dh.draft_type NOT NULL
ORDER BY dc.weight DESC 
LIMIT 15;


/* TASK: FIND OUT HOW MANY PLAYERS WERE SELECTED FROM EACH POSITION IN THE DRAFT*/
SELECT  dc.position, 
	COUNT(dc.position) AS number_of_players_selected_per_position
FROM draft_combine_stats dc
LEFT OUTER JOIN draft_history dh
ON dc.player_id = dh.person_id
WHERE dh.draft_type NOT NULL 
GROUP BY dc.position;

/* TASK: FIND OUT HOW MANY PLAYERS WERE SELECTED FROM EACH POSITION USING 'PARTITION BY' IN THE DRAFT*/
SELECT *,  
	COUNT(*)OVER (PARTITION BY dc.position) AS number_of_players_selected_per_position
FROM draft_combine_stats dc
LEFT OUTER JOIN draft_history dh
ON dc.player_id = dh.person_id
WHERE dh.draft_type NOT NULL
ORDER BY dc.player_name;


/* TASK: FIND OUT  THE AVERAGE  STANDING VERTICAL LEAP IN NBA DRAFT HISTORY*/
SELECT ROUND(AVG(dc.standing_vertical_leap), 3)
FROM draft_combine_stats dc
LEFT OUTER JOIN draft_history dh
ON dc.player_id = dh.person_id
WHERE dh.draft_type NOT NULL;

/* TASK: FIND OUT  TOP 15 PLAYERS WHO HAVE A HIGHER STANDING VERTICAL LEAP GREATER THAN THE AVERAGE S.V.A IN NBA DRAFT HISTORY*/
SELECT *
FROM draft_combine_stats dc
LEFT OUTER JOIN draft_history dh ON dc.player_id = dh.person_id
WHERE standing_vertical_leap > (SELECT AVG(standing_vertical_leap) FROM draft_combine_stats)
ORDER BY dc.standing_vertical_leap DESC
LIMIT 15;

/* TASK: FIND OUT  TOP 15 PLAYERS WHO HAVE A LOWER STANDING VERTICAL LEAP GREATER THAN THE AVERAGE S.V.A IN NBA DRAFT HISTORY*/
SELECT *
FROM draft_combine_stats dc
LEFT OUTER JOIN draft_history dh ON dc.player_id = dh.person_id
WHERE standing_vertical_leap < (SELECT AVG(standing_vertical_leap) FROM draft_combine_stats)
ORDER BY dc.standing_vertical_leap DESC
LIMIT 15;


/* TASK: FIND OUT THE LIST OF ACTIVE  PLAYERS ONLY*/
SELECT * 
FROM common_player_info 
WHERE common_player_info.rosterstatus IS "Active"

/* TASK: FIND OUT HOW MANY YEARS EVERY ACTIVE  PLAYER HAS BEEN IN THE LEAGUE IN THE YEAR 2023 */
SELECT *, 
	2023 - common_player_info.from_year AS years_active 
FROM common_player_info 
WHERE common_player_info.rosterstatus IS "Active" 
ORDER BY years_active DESC;


/* TASK: CATEGORIZE EVERY PLAYER FOR HOW LONG THEY HAVE BEEN IN THE LEAGUE. FIRST YEAR PLAYERS: ROOKIE, SECOND YEAR PLAYERS: SOPHOMORE THIRD YEAR AND BEYOND: VETETRAN*/
SELECT *, 
	2023 - common_player_info.from_year AS years_active ,
CASE 
	WHEN 2023 - common_player_info.from_year = 1 THEN "ROOKIE"
	WHEN 2023 - common_player_info.from_year = 2 THEN "SOPHOMORE"
	WHEN 2023 - common_player_info.from_year >= 3 THEN "VETERAN"
END AS Player_labels
FROM common_player_info 
WHERE common_player_info.rosterstatus IS "Active" 
ORDER BY years_active DESC;

/* TASK: FIND OUT THE OLDEST TEAMS TO YOUNGEST IN THE ASSOCIATION ALSO CONVERTING THE STRING YEAR COLUMN TO INT*/
SELECT * , 
	CAST(year_founded AS INT )AS year_founded_updated
FROM team
ORDER BY year_founded ASC;

