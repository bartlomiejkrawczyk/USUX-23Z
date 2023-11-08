# Użytkowanie systemu UNIX (USUX) - Ćwiczenie 4

## Środowisko

1. Zmodyfikować (lub stworzyć) lokalne pliki konfiguracyjne powłoki zsh w celu :
    - dodania do ścieżki poszukiwań katalogu ~/skrypt. (0,5 pkt)
    Wyjaśnić jak sposób wykonania tej modyfikacji wpływa na kolejność przeszukiwania katalogów.
    - dodania aliasa na polecenie wyświetlania listy wszystkich własnych procesów. (0,5 pkt)

> dodania do ścieżki poszukiwań katalogu ~/skrypt
`~/.zshrc`:
```sh
...
export PATH="$PATH:$HOME/skrypt"
```

```sh
$ source ~/.zshrc
```

> Wyjaśnić jak sposób wykonania tej modyfikacji wpływa na kolejność przeszukiwania katalogów

Katalogi wymienione w zmiennej $PATH są przeszukiwane od lewej do prawej. 

- `$PATH:$HOME/skrypt` - katalog ~/skrypt będzie przeszukiwany na końcu
- `$HOME/skrypt:$PATH` - katalog ~/skrypt będzie przeszukiwany w pierwszej kolejności

> dodania aliasa na polecenie wyświetlania listy wszystkich własnych procesów

`~/.zshrc`:
```sh
...
alias psu='ps -lu "$USER"'
```

```sh
$ source ~/.zshrc
```

2. Sprawdzić i zaprezentować podstawową różnicę między zmiennymi środowiska i zmiennymi lokalnymi shella. (1 pkt)

```sh
$ export TEST=var
$ echo $TEST
var
$ env | grep TEST
TEST=var
$ /bin/bash
$ env | grep TEST
TEST=var
```

Zmienne środowiskowe:
- są dostępne w obrębie procesu oraz wszystkich jego dzieci

```sh
$ TEST=var
$ env | grep TEST
$ echo $TEST
var
$ /bin/bash
$ env | grep TEST
$ echo $TEST

$ ^D
exit
$ echo $TEST
var
```

Zmienne lokalne shella:
- są dostępne jedynie w obrębie powłoki, w ramach której zostały zdefiniowane

3. Skonstruować polecenie: `ls opcje wzorzec` tak, aby otrzymać informacje tylko o plikach ukrytych z bieżącego katalogu, z wyjątkiem pozycji: . (katalog bieżący) i .. (katalog nadrzędny). (1 pkt)

```sh
$ ls -dA .*
```

Użyte flagi:
- `-d` - zamiast listować zawartość ukrytego katalogu listowanie nazwy
- `-A` - listowanie także ukrytych plików z wyjątkiem `.` i `..`

Ukryte pliki w linux rozpoczynają się od `.` - wzorzec `.*` pozwala na dopasowanie ukrytych plików.

4. Przedstawić przykłady ilustrujące działanie następujących znaków specjalnych:
" " (cudzysłów),
' ' (apostrof),
` ` (odwrotny apostrof),
\.

Wyjaśnić i zademonstrować jak zastosowanie powyższych znaków wpływa na interpretację znaków $, ` `, *. Wyniki przedstawić w postaci tabeli. (2 pkt)

> Przedstawić przykłady ilustrujące działanie

- cudzysłów - pozwala na grupowanie wyrazów. Tak powstałe wyrażenia są następnie rozwijane.
```sh
$ VAR="Home directory for user $USER: $(pwd)"
$ echo $VAR
```

- apostrof - pozwala na grupowanie wyrazów w wyrażenia. Nie wspiera rozwijania poszczególnych wyrażeń.
```sh
$ echo 'sudo rm -rf $HOME'                     
sudo rm -rf $HOME
```

- odwrotny apostrof - pozwala na wywołanie innego programu, a jego rezultat umieszcza w wyrażeniu. Jest tożsame z wywołaniem poprzez `$(command)`
```sh
$ VAR=`pwd`
$ echo $VAR
```

- backslash - zapobiega ewaluacji znaku następnego
```sh
$ echo *
README.md
$ echo \*
*
```
test

Ewaluacja | \$             | \` \`                                                          | \*
----------|----------------|----------------------------------------------------------------|-------------------------------------------
" "       | znak specjalny | wyrażenie wewnątrz jest interpretowane                         | znak gwiazdki \*
' '       | znak dolara \$ | wyrażenie nie interpretowane                                   | znak gwiazdki \*
\` \`     | znak specjalny | jeśli escapowany \\ to wewnętrzne wyrażenie też interpretowane | wildcard - dopasowuje dowolny ciąg symboli
\\        | znak dolara \$ | back tick \`                                                   | znak gwiazdki \*
