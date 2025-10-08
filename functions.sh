#!/bin/bash

say_hello() {
  local name=$1
  if [[ -n "$name" ]]; then
    echo "Ahoj, $1 jak se vede..."
    return 0
  else
    echo "Nemám jméno. Nevím koho pozdravit."
    return 1
  fi
}

secti() {
  local number1=$1
  local number2=$2
  echo $(( $number1 + $number2 ))
}

say_joke() {
  curl -s https://api.chucknorris.io/jokes/random | jq -r ".value"
}

get_weather() {
  local result=$(curl -s https://wttr.in/$1?0)
  echo "$result"
}


result=$(say_hello "Pavle")
if [[ $? -eq 0 ]]; then
  echo "$result"
else
  echo "Chybí jméno pro argument funkce say_hello."
fi


result=$(say_hello)
if [[ $? -eq 0 ]]; then
  echo "$result"
else
  echo "Chybí jméno pro argument funkce say_hello. $result"
fi

result1=$(secti 2 5)
echo "výsledek je $result1"

say_joke


#get_weather
for i in "Mladá%20Boleslav" "Hradec%20Kralove" "Praha" "Brno"; do
    get_weather $i
done














