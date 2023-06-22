#! /bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

MAIN() {
  # get result of the element
  GET_ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE (symbol='$1' OR name='$1' OR atomic_number::text= '$1')")

  if [[ -z $GET_ATOMIC_NUMBER ]]
  then
    echo "I could not find that element in the database."
  else
    echo $GET_ATOMIC_NUMBER
  fi

 }

if [[ -z $1 ]]
then
  echo Please provide an element as an argument.
else
  ELEMENT=$1  
  MAIN $ELEMENT
fi


