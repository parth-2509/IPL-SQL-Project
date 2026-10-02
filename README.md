
# IPL Cricket Analysis (2008–2024) 

# Project Overview

This project analyzes Indian Premier League (IPL) cricket data using
PostgreSQL to explore team performance, player statistics, match
outcomes, toss impact, venue performance and season-wise scoring trends.

The analysis uses two datasets:
- Matches: Match-level information such as teams, toss decisions,
  winners, venues and seasons.
- Deliveries: Ball-by-ball information such as batters, bowlers,
  runs, extras and wickets.

# Project Objectives

- Identify the most successful IPL teams by total wins.
- Analyze the relationship between toss decisions and match outcomes.
- Identify the highest run scorers and wicket-taking bowlers.
- Compare bowling economy rates.
- Analyze venue performance and season-wise scoring trends.
- Explore advanced SQL techniques using real-world cricket data.

# Technologies Used

- PostgreSQL 18
- pgAdmin 4
- SQL
- Git and GitHub

# Project Structure

```text
IPL-SQL-Project/
├── dataset/
├── sql/
│   ├── 01_create_tables.sql
│   ├── 02_data_validation.sql
│   ├── 03_ipl_analysis.sql
│   └── 04_advanced_analysis.sql
├── screenshots/
│   ├── 01_data_validation/
│   ├── 02_team_analysis/
│   ├── 03_player_analysis/
│   ├── 04_match_analysis/
│   └── 05_season_analysis/
├── results/
├── README.md
└── .gitignore
```

# Database Schema

The project uses two relational tables:

## 1. matches
Contains match-level information, including match ID, season,
date, teams, toss decision, winner, venue and result.

## 2. deliveries
Contains ball-by-ball information, including match ID, innings,
batting team, bowling team, batter, bowler, runs, extras and wickets.

The tables are connected through `matches.id` and
`deliveries.match_id`, forming a one-to-many relationship.

# SQL Concepts Used

- SELECT, WHERE, ORDER BY
- GROUP BY and HAVING
- Aggregate functions
- INNER JOIN and LEFT JOIN
- Subqueries
- Common Table Expressions (CTEs)
- Window functions (RANK, DENSE_RANK)
- CASE expressions
- Data validation and filtering

# Analysis Performed

1. Most successful teams by total wins
2. Toss winner and match winner comparison
3. Toss decision and match outcome analysis
4. Top 10 run scorers
5. Top wicket-taking bowlers
6. Player of the Match awards
7. Most frequently used venues
8. Season-wise scoring trends
9. Bowling economy analysis
10. Highest team totals in an innings

Advanced analysis includes team win percentages,
season-wise top run scorers and ranking teams using window functions.

# Key Findings

<!-- Replace these placeholders with your actual query results. -->

- Most successful team: [Mumbai Indians]
- Highest run scorer: [Virat Kohli]
- Highest wicket taker: [YS Chahal]
- Toss winner match-win percentage: [50.83]
- Highest scoring season: [2024]
- Highest innings total: [287 & Sunrisers Hyderabad]

# Screenshots

Screenshots of the SQL queries and their outputs are available
in the `screenshots/` directory.

# How to Run

1. Install PostgreSQL and pgAdmin 4.
2. Create a database named `ipl_analysis`.
3. Run `01_create_tables.sql` to create the tables.
4. Import the matches and deliveries CSV files into their
   respective tables, using the correct column mappings.
5. Execute `02_data_validation.sql` to validate the imported data.
6. Execute `03_ipl_analysis.sql` for the core analysis.
7. Execute `04_advanced_analysis.sql` for advanced analysis.

Refer to the dataset source below for the data files.
The dataset must be obtained separately if it is not included
in this repository.

# Dataset

IPL complete dataset, covering the seasons available in the
selected dataset version.

Source: [Kaggle IPL Complete Dataset](https://www.kaggle.com/datasets/patrickb1912/ipl-complete-dataset-20082020)

## Future Improvements

- Build an interactive dashboard using Power BI or Tableau.
- Add more player and team performance metrics.
- Explore year-wise trends using visualizations.
- Integrate the analysis with a web-based dashboard.

# Author

Parth Opalkar  
B.Tech — Electronics & Telecommunication Engineering  
GitHub: https://github.com/parth-2509
