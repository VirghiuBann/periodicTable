#! /bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

MAIN() {
  # get result of the element
  GET_RESULT=$($PSQL "SELECT * FROM elements WHERE atomic_number=$1 OR symbol='$1' OR name='$1'")

  if [[ -z $GET_RESULT ]]
  then
    echo "I could not find that element in the database."
  else
    echo $GET_RESULT
  fi

 }

if [[ -z $1 ]]
then
  echo Please provide an element as an argument.
else
  ELEMENT=$1  
  MAIN $ELEMENT
fi


