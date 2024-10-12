#!/bin/bash

# Check if argument is provided
if [[ -z $1 ]]; then
  echo "Please provide an element as an argument."
  exit 0  # Exit successfully after printing the message
fi