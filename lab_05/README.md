# Użytkowanie systemu UNIX (USUX) - Ćwiczenie 5

## Student
```md
Bartłomiej Krawczyk, 310774
```

## Programowanie w języku powłoki sh

1. Porównać efekty różnych metod uruchamiania skryptów, posługując się prostym przykładem.


2. Zapoznać się szczegółowo z działaniem programu expr (man expr).


3. Uruchomić i przeanalizować działanie skryptu:

```sh
#!/bin/sh
if [ $# -eq 0 ]
then
   echo Poprawne wywolanie: $0 arg1 arg2 ...
   exit 1
fi
suma=0
while [ $1 ]
do
  suma=`expr $suma + $1 2> /dev/null`
  if [ $? -eq 2 ]
  then
     echo "Niewlasciwy argument !"
     exit 2
  fi
  shift
done
echo "Suma argumentow wynosi: $suma";
```

4. Wykorzystując polecenie `expr`, napisać skrypt działający jako prosty kalkulator liczb całkowitych z czterema podstawowymi działaniami (+ - * /) oraz jednym poziomem nawiasów. Nie trzeba uwzględniać priorytetu operatorów.

Postać wywołania skryptu:
```sh
$ nazwa_skryptu arg op (arg op arg) ...
```

Skrypt powinien:
- obliczyć i podać wynik końcowy,
- sygnalizować błędy składni:
    - niepoprawny typ argumentów (tylko argumenty całkowite),
    - niepoprawny operator (poprawne operatory: + - * /),
    - niepoprawna liczba argumentów,
    - brak domknięcia nawiasów,
    - inne
- podawać poprawną postać składni w przypadku wywołania bez argumentów lub wykrycia błędów.
