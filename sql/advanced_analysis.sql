
-- Advanced SQL Queries

-- Q1: Rank teams by total wins using RANK()
WITH team_wins AS (
    SELECT
        winner AS team,
        COUNT(*) AS total_wins
    FROM matches
    WHERE winner IS NOT NULL
    GROUP BY winner
)
SELECT
    team,
    total_wins,
    RANK() OVER (
        ORDER BY total_wins DESC
    ) AS team_rank
FROM team_wins
ORDER BY team_rank;


-- Q2: Top run scorer in each season
WITH player_season_runs AS (
    SELECT
        m.season,
        d.batter,
        SUM(d.batsman_runs) AS total_runs
    FROM matches m
    JOIN deliveries d
        ON m.id = d.match_id
    WHERE d.batter IS NOT NULL
    GROUP BY m.season, d.batter
),
ranked_players AS (
    SELECT
        season,
        batter,
        total_runs,
        RANK() OVER (
            PARTITION BY season
            ORDER BY total_runs DESC
        ) AS player_rank
    FROM player_season_runs
)
SELECT
    season,
    batter,
    total_runs,
    player_rank
FROM ranked_players
WHERE player_rank = 1
ORDER BY season;


-- Q3: Team win percentage
WITH team_matches AS (
    SELECT id, team1 AS team, winner
    FROM matches

    UNION ALL

    SELECT id, team2 AS team, winner
    FROM matches
),
team_performance AS (
    SELECT
        team,
        COUNT(*) AS matches_played,
        COUNT(*) FILTER (
            WHERE winner = team
        ) AS matches_won
    FROM team_matches
    WHERE winner IS NOT NULL
    GROUP BY team
)
SELECT
    team,
    matches_played,
    matches_won,
    ROUND(
        100.0 * matches_won /
        NULLIF(matches_played, 0),
        2
    ) AS win_percentage
FROM team_performance
ORDER BY win_percentage DESC, matches_played DESC;


-- Q4: Rank the highest innings totals
WITH innings_totals AS (
    SELECT
        match_id,
        batting_team,
        inning,
        SUM(total_runs) AS team_total
    FROM deliveries
    GROUP BY match_id, batting_team, inning
)
SELECT
    match_id,
    batting_team,
    inning,
    team_total,
    DENSE_RANK() OVER (
        ORDER BY team_total DESC
    ) AS score_rank
FROM innings_totals
ORDER BY score_rank
LIMIT 20;


-- Q5: Season-wise team wins
SELECT
    season,
    winner AS team,
    COUNT(*) AS total_wins,
    RANK() OVER (
        PARTITION BY season
        ORDER BY COUNT(*) DESC
    ) AS season_rank
FROM matches
WHERE winner IS NOT NULL
GROUP BY season, winner
ORDER BY MIN(date), season_rank;
