#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

# clear the tables if needed
$PSQL "TRUNCATE TABLE teams, games RESTART IDENTITY;"
# reset team_id sequence to start from 1 without gaps
$PSQL "SELECT SETVAL('teams_team_id_seq', 1, false);"
# create temp_teams table
$PSQL "CREATE TABLE IF NOT EXISTS temp_teams (name VARCHAR UNIQUE);"

# insert unique team names from .csv to database table
cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
  # skip the title line
  if [[ $YEAR != 'year' ]]
  then
    # insert unique winner to team name
    INSERT_NAME_RESULT=$($PSQL "INSERT INTO temp_teams(name) VALUES('$WINNER') ON CONFLICT (name) DO NOTHING")
    # insert unique opponent to team name
    INSERT_NAME_RESULT=$($PSQL "INSERT INTO temp_teams(name) VALUES('$OPPONENT') ON CONFLICT (name) DO NOTHING")
  fi 
done

# copy names from temp_teams to teams and get team_id automatically
$PSQL "INSERT INTO teams(name) SELECT name FROM temp_teams"
# drop temp_teams table
$PSQL "DROP TABLE temp_teams;"

# insert the data from .csv to database games table  
cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
  # skip the title line
  if [[ $YEAR != 'year' ]]
  then
    # get team_id for WINNER and OPPONENT
    WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name = '$WINNER';")
    OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name = '$OPPONENT';")

    # insert data into games table
    $PSQL "INSERT INTO games (year, round, winner_id, opponent_id, winner_goals, opponent_goals) 
           VALUES ($YEAR, '$ROUND', $WINNER_ID, $OPPONENT_ID, $WINNER_GOALS, $OPPONENT_GOALS);"
  fi
done
