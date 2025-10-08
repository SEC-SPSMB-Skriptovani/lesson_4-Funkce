# Funkce v Bash

## Na co použít funkce v Bash?
Funkce umožňují **znovu používat kód** bez nutnosti ho psát opakovaně.  
Díky nim můžeš:
- rozdělit skript na přehledné části,  
- předávat vstupy jako argumenty,  
- vracet výsledky (čísla, texty) nebo návratové kódy.

[![YOUTUBE - Crash-Course! Functions in Bash quickly explained and demystified!](https://img.youtube.com/vi/0tycTrpbWKs/0.jpg)](https://www.youtube.com/watch?v=0tycTrpbWKs)

---

## Základní definice funkce
Funkci můžeš napsat dvěma způsoby:

```bash
# Doporučený zápis
my_function() {
  echo "Ahoj světe"
}

# Alternativní zápis
function my_function {
  echo "Ahoj světe"
}
```

Volání funkce:
```bash
my_function
```

Výstup:
```
Ahoj světe
```

---

## Předávání argumentů
Funkce může přijímat argumenty přes proměnné `$1`, `$2`, `$3` …

```bash
pozdrav() {
  echo "Ahoj, $1!"
}

pozdrav "Karle"
```

Výstup:
```
Ahoj, Karle!
```

> `$#` → počet argumentů  
> `$@` → všechny argumenty jako seznam  

---

## Návratový kód (`return`)
Každá funkce může vrátit **číselný kód (0–255)** pomocí `return`.  
Hodnota `0` znamená úspěch (true), cokoliv jiného je chyba (false).

```bash
is_even() {
  if (( $1 % 2 == 0 )); then
    return 0    # true
  else
    return 1    # false
  fi
}

if is_even 6; then
  echo "Číslo je sudé"
else
  echo "Číslo je liché"
fi
```

---

## Vrácení textu nebo čísla (`echo`)
`return` umí jen číslo, takže když chceš vrátit text (např. výsledek výpočtu), použij `echo` a příkazovou substituci `$(...)`.

```bash
secti() {
  echo $(( $1 + $2 ))
}

vysledek=$(secti 5 7)
echo "Součet: $vysledek"
```

Výstup:
```
Součet: 12
```

---

## Lokální proměnné
Pomocí `local` zabráníš, aby proměnná z funkce ovlivnila zbytek skriptu.

```bash
soucin() {
  local a=$1
  local b=$2
  echo $((a * b))
}

echo "Výsledek: $(soucin 3 4)"
```

---

## Kombinace návratového kódu a textu
Můžeš vracet text (např. výsledek) a zároveň použít `return` k označení úspěchu či chyby.

```bash
get_message() {
  local name=$1
  if [ -z "$name" ]; then
    echo "Chyba: jméno chybí"
    return 1
  else
    echo "Ahoj, $name!"
    return 0
  fi
}

msg=$(get_message "Karel")

if [ $? -eq 0 ]; then
  echo "✅ OK: $msg"
else
  echo "⚠️  $msg"
fi
```

---

## Výchozí hodnoty argumentů
Pomocí `${1:-výchozí}` můžeš nastavit výchozí hodnotu argumentu.

```bash
say_hello() {
  local name=${1:-"neznámý"}
  echo "Ahoj, $name!"
}

say_hello          # → Ahoj, neznámý!
say_hello "Petr"   # → Ahoj, Petr!
```

---

## Praktický příklad – náhodný Chuck Norris vtip
```bash
#!/bin/bash

get_chuck_joke() {
  local joke=$(curl -s https://api.chucknorris.io/jokes/random | jq -r '.value')
  echo "🤣 $joke"
}

get_chuck_joke
```

Výstup:
```
🤣 Chuck Norris napsal funkci main() ještě předtím, než existoval jazyk C.
```

---

## Shrnutí

| Akce | Příklad |
|------|----------|
| Definice funkce | `my_func() { ... }` |
| Volání funkce | `my_func arg1 arg2` |
| Argumenty | `$1`, `$2`, `$#`, `$@` |
| Návratový kód | `return 0` / `return 1` |
| Textový výstup | `echo "..."` + `$(funkce)` |
| Lokální proměnné | `local var=value` |

---

## 🧩 Cvičení
Vytvoř skript `math_tools.sh`, který:
1. Bude mít dvě funkce:  
   - `secti a b` → vrátí součet  
   - `vydel a b` → vrátí podíl nebo napíše chybu při dělení nulou  
2. Na konci skriptu požádá uživatele o dvě čísla a operaci (`+` nebo `/`)  
3. Zavolá odpovídající funkci a vypíše výsledek  

> 💡 Tip: Použij kombinaci `read`, `if`, `echo`, `return` a `$(...)`.
