
-- Data Validation

-- Q1: Total records in both tables
SELECT
    (SELECT COUNT(*) FROM matches) AS total_matches,
    (SELECT COUNT(*) FROM deliveries) AS total_deliveries;


-- Q2: Matches per season
SELECT
    season,
    COUNT(*) AS total_matches
FROM matches
GROUP BY season
ORDER BY MIN(date);


-- Q3: Check duplicate match IDs
SELECT
    id,
    COUNT(*) AS occurrences
FROM matches
GROUP BY id
HAVING COUNT(*) > 1;


-- Q4: Check missing important match information
SELECT
    COUNT(*) FILTER (
        WHERE winner IS NULL
    ) AS missing_winners,
    COUNT(*) FILTER (
        WHERE toss_winner IS NULL
    ) AS missing_toss_winners,
    COUNT(*) FILTER (
        WHERE player_of_match IS NULL
    ) AS missing_player_awards
FROM matches;


-- Q5: Check deliveries without a matching match
SELECT
    COUNT(*) AS unmatched_deliveries
FROM deliveries d
LEFT JOIN matches m
    ON d.match_id = m.id
WHERE m.id IS NULL;


-- Q6: Check run consistency
SELECT
    COUNT(*) AS inconsistent_deliveries
FROM deliveries
WHERE total_runs <> batsman_runs + extra_runs;


-- Q7: Check available extras types
SELECT
    extras_type,
    COUNT(*) AS delivery_count
FROM deliveries
GROUP BY extras_type
ORDER BY delivery_count DESC;


-- Q8: Check available dismissal types
SELECT
    dismissal_kind,
    COUNT(*) AS dismissal_count
FROM deliveries
WHERE is_wicket = 1
GROUP BY dismissal_kind
ORDER BY dismissal_count DESC;
