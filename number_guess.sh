#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

# randomly generate a number
SECRET_NUMBER=$((RANDOM % 1000 + 1))

# Part 1: user info
# prompt the user for a username
echo "Enter your username:"
read INPUT

# Sanitize input to prevent SQL injection (remove single quotes)
#INPUT=$(echo "$I_INPUT" | sed "s/'//g")

# check user_id in the database users
USER_ID=$($PSQL "SELECT user_id FROM users WHERE username = '$INPUT'")

# If the username exists
if [[ $USER_ID ]]
then
  # get username
  USERNAME=$INPUT
  # get the total number of games_played
  GAMES_PLAYED=$($PSQL "SELECT MAX(games_played) FROM gamelog WHERE user_id = '$USER_ID'")
  # get the fewest number of guesses it took that user to win
  BEST_GAME=$($PSQL "SELECT MIN(number_of_guesses) FROM gamelog WHERE user_id = '$USER_ID'")
  # print the message
  echo "Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."

# If user_id not found
else
  # insert a new username and get user_id
  USER_RESULT=$($PSQL "INSERT INTO users(username) VALUES('$INPUT')")
  # get username and new user_id
  USERNAME=$INPUT
  USER_ID=$($PSQL "SELECT user_id FROM users WHERE username = '$INPUT'")
  # print the message
  echo "Welcome, $USERNAME! It looks like this is your first time here."
fi

# Part 2: start the game

# function to check if anything other than an integer is input as a guess
CHECK_GUESS() {
  while ! [[ "$USER_GUESS" =~ ^[0-9]+$ ]]; do
    echo "That is not an integer, guess again:"
    read USER_GUESS
  done
}

# the user make a guess
echo "Guess the secret number between 1 and 1000:"
read USER_GUESS
CHECK_GUESS

# initialize user trial time
TRY=1

# the guess loop
while [[ $USER_GUESS -ne $SECRET_NUMBER ]]
do
  # if user guess is lower
  if [[ $USER_GUESS -lt $SECRET_NUMBER ]]
  then
    echo "It's lower than that, guess again:"
  # if user guess is higher
  else
    echo "It's higher than that, guess again:"
  fi
  # user input a new guess; check the guess
  read USER_GUESS
  CHECK_GUESS
  # number_of_guess increases
  TRY=$((TRY + 1))
done

# Part 3: database update
# insert game result into database
if [[ -z $GAMES_PLAYED ]]
then
  # if new user
  INSERT_RESULT=$($PSQL "INSERT INTO gamelog(user_id, games_played, number_of_guesses) VALUES('$USER_ID', 1, '$TRY')")
else
  # if existed user
  GAMES_PLAYED=$((GAMES_PLAYED + 1))
  INSERT_RESULT=$($PSQL "INSERT INTO gamelog(user_id, games_played, number_of_guesses) VALUES('$USER_ID', '$GAMES_PLAYED', '$TRY')")
fi

# print the final message
echo "You guessed it in $TRY tries. The secret number was $SECRET_NUMBER. Nice job!"

# exit
exit 0
