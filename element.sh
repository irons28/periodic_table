#!/bin/bash

# Check if argument is provided
if [[ -z $1 ]]; then
  echo "Please provide an element as an argument."
  exit 0  # Exit successfully after printing the message
fi

# Store the argument in a variable
input="$1"

# Check if the input is a number (atomic number) or a string (symbol or name)
if [[ $input =~ ^[0-9]+$ ]]; then
  # Input is a number, search by atomic number.
  element=$(psql --username=freecodecamp --dbname=periodic_table -t --no-align -c "
    SELECT atomic_number, name, symbol, types.type, atomic_mass, melting_point_celsius, boiling_point_celsius
    FROM elements
    JOIN properties USING(atomic_number)
    JOIN types ON properties.type_id = types.type_id
    WHERE atomic_number = $input;
  ")
else
  # Input is a string, search by symbol or name.
  element=$(psql --username=freecodecamp --dbname=periodic_table -t --no-align -c "
    SELECT atomic_number, name, symbol, types.type, atomic_mass, melting_point_celsius, boiling_point_celsius
    FROM elements
    JOIN properties USING(atomic_number)
    JOIN types ON properties.type_id = types.type_id
    WHERE symbol ILIKE '$input' OR name ILIKE '$input';
  ")
fi

