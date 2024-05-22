#!/bin/bash

# Failas, kuriame bus saugomos užduotys
uzduociu_failas="uzduotys.txt"

# Sukuriamas failas, jei jo nėra
if [ ! -f "$uzduociu_failas" ]; then
  touch "$uzduociu_failas"
fi

# Funkcija pridėti užduotį
prideti_uzduoti() {
  echo "Įveskite naują užduotį:"
  read -r nauja_uzduotis
  echo "$nauja_uzduotis" >> "$uzduociu_failas"
  echo "Užduotis pridėta."
}

# Funkcija peržiūrėti užduotis
perziureti_uzduotis() {
  echo "Dabartinės užduotys:"
  if [ ! -s "$uzduociu_failas" ]; then
    echo "Nėra užduočių."
  else
    cat -n "$uzduociu_failas"
  fi
}

# Funkcija ištrinti užduotį
istrinti_uzduoti() {
  echo "Įveskite užduoties numerį, kurį norite ištrinti:"
  read -r uzduoties_numeris
  if ! [[ "$uzduoties_numeris" =~ ^[0-9]+$ ]]; then
    echo "Netinkamas užduoties numeris."
    return
  fi

  sed -i "${uzduoties_numeris}d" "$uzduociu_failas"
  echo "Užduotis ištrinta."
}

# Pagrindinis meniu
while true; do
  echo "Pasirinkite veiksmą:"
  echo "1. Pridėti užduotį"
  echo "2. Peržiūrėti užduotis"
  echo "3. Ištrinti užduotį"
  echo "4. Išeiti"
  read -r pasirinkimas

  case $pasirinkimas in
    1)
      prideti_uzduoti
      ;;
    2)
      perziureti_uzduotis
      ;;
    3)
      istrinti_uzduoti
      ;;
    4)
      echo "Išeinama..."
      break
      ;;
    *)
      echo "Netinkamas pasirinkimas."
      ;;
  esac
done
