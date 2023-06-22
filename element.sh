#! /bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

GET_ATOMIC_NUMBER() {
  local query="SELECT atomic_number FROM elements WHERE (symbol='$1' OR name='$1' OR atomic_number::text= '$1')"
  $PSQL "$query"
}

GET_ELEMENT() {
  local query="SELECT  atomic_number, name, symbol, atomic_mass, melting_point_celsius, boiling_point_celsius, type FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE atomic_number=$1"
  $PSQL "$query"
}

PRINT_ELEMENT_DETAILS() {
    IFS='|' read -r ATOMIC_NUMBER NAME SYMBOL ATOMIC_MASS MELTING_POINT_CELSIUS BOILING_POINT_CELSIUS TYPE <<< "$1"

    echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT_CELSIUS celsius and a boiling point of $BOILING_POINT_CELSIUS celsius."
}

MAIN() {
  local ELEMENT=$1
  
  local GET_ATOMIC_NUMBER_RESULT=$(GET_ATOMIC_NUMBER "$ELEMENT")
 
  if [[ -z $GET_ATOMIC_NUMBER_RESULT ]]
  then
    echo "I could not find that element in the database."
  else
    local GET_ELEMENT_RESULT=$(GET_ELEMENT "$GET_ATOMIC_NUMBER_RESULT")

    PRINT_ELEMENT_DETAILS "$GET_ELEMENT_RESULT"
  fi
 }

if [[ -z $1 ]]
then
  echo Please provide an element as an argument.
else
  ELEMENT=$1  
  MAIN $ELEMENT
fi


