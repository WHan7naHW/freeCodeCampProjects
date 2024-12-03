#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

MAIN_FUNCTION() {
  # check the user input
  if [[ -z $1 ]]
  then
    echo Please provide an element as an argument.
    exit 0
  else
    # check if the input matches one element in elements database
    A_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE atomic_number = '$1'")
    NAME=$($PSQL "SELECT name FROM elements WHERE name = '$1'")
    SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE symbol = '$1'")

    # if input matches the atomic_number
    if [[ $A_NUMBER ]]
    then
      NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number = '$1'")
      SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number = '$1'")
      ELEMENT_INFO
    
    else
      # if input matches the atomic name
      if [[ $NAME ]]
      then
        A_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE name = '$1'")
        SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE name = '$1'")
        ELEMENT_INFO
      
      else
        # if input matches the atomic symbol
        if [[ $SYMBOL ]]
        then
          A_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE symbol = '$1'")
          NAME=$($PSQL "SELECT name FROM elements WHERE symbol = '$1'")
          ELEMENT_INFO

        else
          # if input doen't match any
          echo I could not find that element in the database.
        fi
      fi
    fi
  fi
}

# get element info with atomic_number
ELEMENT_INFO() {
  MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number = '$A_NUMBER'")
  MELT=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number = '$A_NUMBER'")
  BOIL=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number = '$A_NUMBER'")
  TYPE=$($PSQL "SELECT type FROM types JOIN properties ON properties.type_id = types.type_id WHERE properties.atomic_number = '$A_NUMBER'")
  
  # print the infomation
  echo "The element with atomic number $A_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELT celsius and a boiling point of $BOIL celsius."
}

MAIN_FUNCTION "$1"
