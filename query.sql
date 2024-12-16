-- Most Runs in the match
use cricket;

SELECT distinct
    p.name AS Players,
    COUNT(DISTINCT pp.Match_id) AS Matches,
    COUNT(pp.Innings) AS Inns,
    SUM(pp.Runs_scored) AS Runs, 
    ROUND(SUM(pp.Runs_scored) / NULLIF(COUNT(pp.Innings), 0), 2) AS Avg,
    ROUND((SUM(pp.Runs_scored
    ) / NULLIF(SUM(pp.Balls_faced), 0)) * 100, 2) AS Sr,  
    SUM(pp.Fours) AS 4s, 
    SUM(pp.Sixers) AS 6s  
FROM 
    players p
JOIN 

    player_performance pp ON p.player_id = pp.player_id
GROUP BY 
    p.player_id
ORDER BY 
    Runs DESC
LIMIT 10;


-- Highest Scores in a match

select distinct
	p.name as Players,
    max(pp.Runs_scored)as Runs,
    pp.Balls_faced as Balls,
    ROUND((SUM(pp.Runs_scored
    ) / NULLIF(SUM(pp.Balls_faced), 0)) * 100, 2) AS Sr,  
    SUM(pp.Fours) AS 4s, 
    SUM(pp.Sixers) AS 6s 
from
	players p	
join	
	player_performance pp
on
	p.player_id=pp.player_id
group by
	p.name,pp.Balls_faced
order by
	Runs desc;
    
-- Best Batting avg

SELECT
    p.name AS Players,
    COUNT(DISTINCT pp.Match_id) AS Matches,    -- Count of distinct matches the player played
    COUNT(pp.Innings) AS Inns,                  -- Count of innings the player batted in
    SUM(pp.Runs_scored) AS Runs,                -- Total runs scored by the player
    ROUND(SUM(pp.Runs_scored) / NULLIF(COUNT(pp.Innings), 0), 2) AS Avg  -- Calculate average
FROM
    players p
JOIN
    player_performance pp ON p.player_id = pp.player_id
GROUP BY
    p.name
ORDER BY
    Avg DESC;  -- Order by best batting average in descending order

-- Best Strike Rate of batsman

SELECT
    p.name AS Players,
    COUNT(DISTINCT pp.Match_id) AS Matches,      -- Count of distinct matches the player has played
    COUNT(pp.Innings) AS Inns,                    -- Count of innings the player has batted in
    SUM(pp.Runs_scored) AS Runs,                  -- Total runs scored by the player
    SUM(pp.Balls_faced) AS Balls,                 -- Total balls faced by the player
    ROUND((SUM(pp.Runs_scored) / NULLIF(SUM(pp.Balls_faced), 0)) * 100, 2) AS Sr -- Calculate strike rate
FROM
    players p
JOIN
    player_performance pp ON p.player_id = pp.player_id
GROUP BY
    p.name
ORDER BY
    Sr DESC;  -- Order by strike rate in descending order


-- Most Hundreads in a match

SELECT
    p.name AS Players,
    pp.Runs_scored as Runs,
    COUNT(CASE WHEN pp.Runs_scored >= 100 THEN 1 END) AS "100s"
FROM
    players p
JOIN
    player_performance pp ON p.player_id = pp.player_id
GROUP BY
    p.name,pp.Runs_scored
HAVING
    COUNT(CASE WHEN pp.Runs_scored >= 100 THEN 1 END) > 0  -- Only show players who have scored at least one hundred
ORDER BY
    "100s" DESC;  -- Sort by number of hundreds in descending order

-- MOst Fifties in a match

SELECT
    p.name AS Players,
    SUM(CASE WHEN pp.Runs_scored >= 50 AND pp.Runs_scored < 100 THEN 1 ELSE 0 END) AS "Fifties"
FROM
    players p
JOIN
    player_performance pp ON p.player_id = pp.player_id
GROUP BY
    p.name
HAVING
    SUM(CASE WHEN pp.Runs_scored >= 50 AND pp.Runs_scored < 100 THEN 1 ELSE 0 END) > 0  -- Only show players with at least one fifty
ORDER BY
    "Fifties" desc;  -- Sort by the total number of fifties in descending order
    
-- Most Wickets in Match

SELECT
    p.name AS Players,
    count(distinct pp.match_id)as Matches,
    SUM(pp.Wickets_taken) AS Wickets
FROM
    players p
JOIN
    player_performance pp ON p.player_id = pp.player_id
GROUP BY
    p.name
HAVING
    SUM(pp.Wickets_taken) > 0
ORDER BY
    Wickets DESC;

-- Best Bowling Average

SELECT
    p.name AS Players,
    count(pp.match_id) AS Matches,  -- Total matches played by the player
    SUM(pp.Overs_bowled) AS Overs,  -- Total overs bowled by the player
    SUM(pp.Wickets_taken) AS Wickets,  -- Total wickets taken by the player
    round(SUM(pp.Runs) / NULLIF(SUM(pp.Wickets_taken), 0),2) AS "Bowling Average"  -- Calculating bowling average (Runs Given / Wickets)
FROM
    players p
JOIN
    player_performance pp ON p.player_id = pp.player_id
GROUP BY
    p.name
HAVING
    SUM(pp.Wickets_taken) > 0  -- Only include players who have taken at least one wicket
ORDER BY
    "Bowling Average" ASC;  -- Sort by the best bowling average (ascending)

-- BOwling avg

SELECT
    p.name AS Players,
    count(distinct pp.match_id) AS Matches,  -- Total matches played by the player
    SUM(pp.Overs_bowled) AS Overs,  -- Total overs bowled by the player
    SUM(pp.Wickets_taken) AS Wickets,  -- Total wickets taken by the player
    round(SUM(pp.Runs) / NULLIF(SUM(pp.Overs_bowled), 0),2) AS "Economy Rate"  -- Calculating economy rate (Runs Given / Overs)
FROM
    players p
JOIN
    player_performance pp ON p.player_id = pp.player_id
GROUP BY
    p.name
HAVING
    SUM(pp.Overs_bowled) > 0  -- Only include players who have bowled at least one over
ORDER BY
    "Economy Rate" asc;  -- Sort by the best economy rate (ascending)


-- Most Five Wickets Haul

SELECT
    p.name AS Players,
	count(distinct pp.match_id)as Matches,
    COUNT(CASE WHEN pp.Wickets_taken >= 5 THEN 1 END) AS "Five Wickets Hauls"
FROM
    players p
JOIN
    player_performance pp ON p.player_id = pp.player_id
GROUP BY
    p.name
HAVING
    COUNT(CASE WHEN pp.Wickets_taken >= 5 THEN 1 END) > 0  -- Only show players with at least one five-wicket haul
ORDER BY
    "Five Wickets Hauls" DESC;  -- Sort by the number of five-wicket hauls in descending order
