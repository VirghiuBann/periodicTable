#! /bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

MAIN() {
  # get result of the element
  GET_RESULT=$($PSQL "SELECT * FROM elements WHERE atomic_number=$1 OR symbol='$1' OR name='$1'")

  echo $GET_RESULT
 }

if [[ -z $1 ]]
then
  echo Please provide an element as an argument.
  read ELEMENT
else
  ELEMENT=$1  
fi

MAIN $ELEMENT

