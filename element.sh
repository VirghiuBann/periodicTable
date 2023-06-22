#! /bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

MAIN() {
  # get result of the element
  GET_ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE (symbol='$1' OR name='$1' OR atomic_number::text= '$1')")

  if [[ -z $GET_ATOMIC_NUMBER ]]
  then
    echo "I could not find that element in the database."
  else
    GET_ELEMENT=$($PSQL "SELECT  atomic_number, name, symbol, atomic_mass, melting_point_celsius, boiling_point_celsius, type FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE atomic_number=$GET_ATOMIC_NUMBER")

    IFS='|' read -r ATOMIC_NUMBER NAME SYMBOL ATOMIC_MASS MELTING_POINT_CELSIUS BOILING_POINT_CELSIUS TYPE <<< "$GET_ELEMENT"

    echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT_CELSIUS celsius and a boiling point of $BOILING_POINT_CELSIUS celsius."

  fi

 }

if [[ -z $1 ]]
then
  echo Please provide an element as an argument.
else
  ELEMENT=$1  
  MAIN $ELEMENT
fi


