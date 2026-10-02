
-- IPL Cricket Analysis (2008–2024)
-- Core SQL Analysis Queries
-- Database: PostgreSQL

-- Q1: Most successful teams by total wins
SELECT
    winner AS team,
    COUNT(*) AS total_wins
FROM matches
WHERE winner IS NOT NULL
GROUP BY winner
ORDER BY total_wins DESC;


-- Q2: Does winning the toss help win the match?
SELECT
    COUNT(*) AS total_matches,
    COUNT(*) FILTER (
        WHERE toss_winner = winner
    ) AS toss_winner_won,
    ROUND(
        100.0 * COUNT(*) FILTER (
            WHERE toss_winner = winner
        ) / NULLIF(COUNT(*), 0),
        2
    ) AS win_percentage
FROM matches
WHERE winner IS NOT NULL
  AND toss_winner IS NOT NULL;


-- Q3: Bat first or field first?
SELECT
    toss_decision,
    COUNT(*) AS times_chosen,
    COUNT(*) FILTER (
        WHERE toss_winner = winner
    ) AS times_won,
    ROUND(
        100.0 * COUNT(*) FILTER (
            WHERE toss_winner = winner
        ) / NULLIF(COUNT(*), 0),
        2
    ) AS win_percentage
FROM matches
WHERE winner IS NOT NULL
  AND toss_winner IS NOT NULL
  AND toss_decision IS NOT NULL
GROUP BY toss_decision
ORDER BY times_chosen DESC;


-- Q4: Top 10 run scorers of all time
SELECT
    batter,
    SUM(batsman_runs) AS total_runs,
    COUNT(DISTINCT match_id) AS matches_played,
    ROUND(AVG(batsman_runs), 2) AS avg_runs_per_ball
FROM deliveries
WHERE batter IS NOT NULL
GROUP BY batter
ORDER BY total_runs DESC
LIMIT 10;


-- Q5: Top 10 wicket-taking bowlers
SELECT
    bowler,
    COUNT(*) AS total_wickets,
    COUNT(DISTINCT match_id) AS matches_bowled
FROM deliveries
WHERE is_wicket = 1
  AND bowler IS NOT NULL
  AND LOWER(COALESCE(dismissal_kind, ''))
      NOT IN (
          'run out',
          'retired hurt',
          'retired out',
          'obstructing the field'
      )
GROUP BY bowler
ORDER BY total_wickets DESC
LIMIT 10;


-- Q6: Most Player of the Match awards
SELECT
    player_of_match,
    COUNT(*) AS awards
FROM matches
WHERE player_of_match IS NOT NULL
GROUP BY player_of_match
ORDER BY awards DESC
LIMIT 10;


-- Q7: Venues hosting the most matches
SELECT
    venue,
    city,
    COUNT(*) AS matches_hosted
FROM matches
GROUP BY venue, city
ORDER BY matches_hosted DESC
LIMIT 10;


-- Q8: Season-wise total runs and matches
SELECT
    m.season,
    SUM(d.total_runs) AS total_runs,
    COUNT(DISTINCT m.id) AS total_matches,
    ROUND(AVG(d.total_runs), 2) AS avg_runs_per_delivery
FROM matches m
JOIN deliveries d
    ON m.id = d.match_id
GROUP BY m.season
ORDER BY MIN(m.date);


-- Q9: Best bowling economy
-- Minimum 100 overs 
SELECT
    bowler,
    SUM(
        batsman_runs +
        CASE
            WHEN LOWER(COALESCE(extras_type, ''))
                IN ('wides', 'noballs')
            THEN extra_runs
            ELSE 0
        END
    ) AS runs_conceded,
    COUNT(*) FILTER (
        WHERE LOWER(COALESCE(extras_type, ''))
            NOT IN ('wides', 'noballs')
    ) AS legal_balls,
    ROUND(
        SUM(
            batsman_runs +
            CASE
                WHEN LOWER(COALESCE(extras_type, ''))
                    IN ('wides', 'noballs')
                THEN extra_runs
                ELSE 0
            END
        ) * 6.0 /
        NULLIF(
            COUNT(*) FILTER (
                WHERE LOWER(COALESCE(extras_type, ''))
                    NOT IN ('wides', 'noballs')
            ),
            0
        ),
        2
    ) AS economy
FROM deliveries
WHERE bowler IS NOT NULL
GROUP BY bowler
HAVING COUNT(*) FILTER (
    WHERE LOWER(COALESCE(extras_type, ''))
        NOT IN ('wides', 'noballs')
) >= 600
ORDER BY economy ASC
LIMIT 10;


-- Q10: Highest team totals in a single innings
SELECT
    match_id,
    batting_team,
    inning,
    SUM(total_runs) AS team_total
FROM deliveries
GROUP BY match_id, batting_team, inning
ORDER BY team_total DESC
LIMIT 10;
