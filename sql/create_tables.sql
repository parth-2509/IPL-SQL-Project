
-- Table 1: Match-level data
CREATE TABLE matches (
    id BIGINT PRIMARY KEY,
    season TEXT,
    city TEXT,
    date DATE,
    match_type TEXT,
    player_of_match TEXT,
    venue TEXT,
    team1 TEXT,
    team2 TEXT,
    toss_winner TEXT,
    toss_decision TEXT,
    winner TEXT,
    result TEXT,
    result_margin INTEGER,
    target_runs INTEGER,
    target_overs NUMERIC(4,1),
    super_over TEXT,
    method TEXT,
    umpire1 TEXT,
    umpire2 TEXT
);

-- Table 2: Ball-by-ball delivery data
CREATE TABLE deliveries (
    match_id BIGINT,
    inning INTEGER,
    batting_team TEXT,
    bowling_team TEXT,
    over INTEGER,
    ball INTEGER,
    batter TEXT,
    bowler TEXT,
    non_striker TEXT,
    batsman_runs INTEGER,
    extra_runs INTEGER,
    total_runs INTEGER,
    extras_type TEXT,
    is_wicket INTEGER,
    player_dismissed TEXT,
    dismissal_kind TEXT,
    fielder TEXT,

    FOREIGN KEY (match_id)
        REFERENCES matches(id)
);

-- Indexes to support common joins and filters
CREATE INDEX idx_deliveries_match_id
ON deliveries(match_id);

CREATE INDEX idx_deliveries_batter
ON deliveries(batter);

CREATE INDEX idx_deliveries_bowler
ON deliveries(bowler);

CREATE INDEX idx_matches_season
ON matches(season);
