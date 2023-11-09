# Użytkowanie systemu UNIX (USUX) - Ćwiczenie 5

## Student
```
Bartłomiej Krawczyk, 310774
```

## Programowanie w języku powłoki sh

1. Porównać efekty różnych metod uruchamiania skryptów, posługując się prostym przykładem.

Możliwe jest uruchomienie skryptu poprzez podanie ścieżki do pliku:
```sh
$ ./calc.sh 2 + 2
4
```

Taki plik musi posiadać:
- prawa dostępu do wykonywania np. `-rwxr-xr-x`
- shebang z interpreterem potrzebnym do jego uruchomienia np. `#!/bin/bash` lub domyślnie zostanie wykorzystany interpreter `/bin/sh`

Jeśli folder, w którym znajduje się plik dodany jest do zmiennej środowiskowej `$PATH`. Możliwe będzie także wywołanie poprzez podanie nazwy skryptu:
```sh
$ calc.sh 2 + 2
4
```

Możliwe jest także wywołanie skryptu, poprzez podanie skryptu jako argumentu do wykorzystywanego interpretera:
```sh
$ /bin/bash calc.sh 2 + 2
4
```

Zaletą tego rozwiązania jest brak konieczności posiadania praw do wykonywania skryptu.

2. Zapoznać się szczegółowo z działaniem programu expr (man expr).

Komenda `expr` służy do ewaluowania różnego rodzaju wyrażeń.

Polecenie wspiera:
- operacje arytmetyczne (+, -, *, /, %)
- operacje porównania
- porównanie wzorców
- wycinanie podciągów
- zliczanie długości

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

```sh
$ ./sum.sh 1 2 3 -1  
Suma argumentow wynosi: 5
```

Skrypt oblicza sumę argumentów zadanych do programu.

```sh
$ ./sum.sh 1 2 test 4
Niewlasciwy argument !
```

W przypadku podania niewłaściwego argumentu program produkuje informację o błędzie.

```sh
$ ./sum.sh 
Poprawne wywolanie: ./sum.sh arg1 arg2 ...
```

Jeśli użytkownik nie poda żadnego argumentu zostanie wyświetlona informacja w jaki sposób należy skorzystać ze skryptu.

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

[Kalkulator](./calc.sh)