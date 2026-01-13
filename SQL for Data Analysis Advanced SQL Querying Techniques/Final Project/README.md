# 📊 Major League Baseball SQL Analysis  
### Advanced SQL Exploration of Historical Player Data

## 📝 Overview  
As a newly hired **Data Analyst Intern for Major League Baseball**, you’ve been given access to a large historical dataset containing **decades of player information**.  
Your assignment is to use **advanced SQL techniques** to analyze how player statistics have changed over time and across teams.

The dataset includes:

- Schools attended  
- Salaries  
- Teams played for  
- Height and weight  
- Career timelines  
- Player performance metrics  

This project is organized into four major analytical parts.

---

# 🧩 PART I: SCHOOL ANALYSIS

### 1. View the schools and school details tables  
Inspect the structure and contents of the school‑related tables.

### 2. In each decade, how many schools produced players  
Analyze school representation across decades.

### 3. Top 5 schools that produced the most players  
Identify the most influential schools in MLB player development.

### 4. For each decade, top 3 schools that produced the most players  
Combine time‑based grouping with ranking logic.

---

# 💰 PART II: SALARY ANALYSIS

### 1. View the salaries table

Explore salary data and its structure.

### 2. Return the top 20% of teams by average annual spending  
Rank teams by spending efficiency and investment.

### 3. For each team, show cumulative spending over the years  
Use window functions to build cumulative totals.

### 4. Return the first year each team’s cumulative spending surpassed 1 billion  
Identify financial milestones across franchises.

---

# 🧢 PART III: PLAYER CAREER ANALYSIS

### 1. View the players table and count total players  
Basic exploration and summary statistics.

### 2. For each player, calculate:  
- Age at first game  
- Age at last game  
- Career length in years  
Sort results from longest to shortest career.

### 3. Determine each player’s starting and ending teams  
Track career movement across franchises.

### 4. Count players who:  

- Started and ended on the same team  
- Played for over a decade  

---

# ⚾ PART IV: PLAYER COMPARISON ANALYSIS

### 1. View the players table  
Explore player attributes and demographics.

### 2. Which players share the same birthday  
Identify birthday clusters across the league.

### 3. Create a summary table showing, for each team:  
- Percent of players who bat right  
- Percent who bat left  
- Percent who bat both  

### 4. Analyze how average height and weight at debut have changed over time  
Calculate decade‑over‑decade differences in player physique.

---

# 🛠️ SQL Techniques Used

- Window functions (`ROW_NUMBER`, `RANK`, `LAG`, `LEAD`, cumulative sums`)  
- Recursive CTEs  
- Aggregations and grouping  
- Join‑back patterns for min/max filtering  
- Date arithmetic  
- Deduplication patterns  
- Ranking and percentile logic  
- Time‑series analysis  

---
