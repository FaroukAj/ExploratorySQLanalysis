/* Task: Get every guard selected in an nba draft from 1965 to 2022*/

SELECT  cp.person_id, cp.first_name, cp.last_name, cp.birthdate, cp.school, cp.country, cp.height, cp.weight, cp.position, cp.draft_year, cp.draft_round, cp.draft_number, 
dh.season, dh.team_name, dh.overall_pick, dh.person_id
FROM common_player_info AS cp
LEFT OUTER JOIN draft_history AS dh
ON cp.person_id = dh.person_id

WHERE cp.position = "Guard" AND (dh.season > 1964)

ORDER BY cp.last_name;

/* TASK: Get every guard selected in the draft by the Celtics, Lakers, and Pistons. Also, find guards that are taller than 6'4 to determine if they are Shooting guards.*/

SELECT cp.person_id, cp.first_name, cp.last_name, cp.birthdate, cp.school, cp.country, cp.height, cp.weight, cp.position, cp.draft_year, cp.draft_round, cp.draft_number, 
dh.season, dh.team_name, dh.overall_pick, dh.person_id
FROM common_player_info AS cp
LEFT OUTER JOIN draft_history AS dh
ON cp.person_id = dh.person_id
WHERE cp.position = "Guard" AND (dh.season > 1964) 
AND (dh.team_name  IN ("Lakers" , "Celtics", "Pistons" )AND cp.height > '6-4')

ORDER BY cp.last_name;


