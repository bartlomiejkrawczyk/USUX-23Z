# Użytkowanie systemu UNIX (USUX) - Ćwiczenie 4

## Środowisko

1. Zmodyfikować (lub stworzyć) lokalne pliki konfiguracyjne powłoki zsh w celu :
    - dodania do ścieżki poszukiwań katalogu ~/skrypt. (0,5 pkt)
    Wyjaśnić jak sposób wykonania tej modyfikacji wpływa na kolejność przeszukiwania katalogów.
    - dodania aliasa na polecenie wyświetlania listy wszystkich własnych procesów. (0,5 pkt)

`~/.zshrc`:
```sh
...
export PATH="$PATH:$HOME/skrypt"
```

Katalogi wymienione w zmiennej path są przeszukiwane od lewej do prawej. 

- `$PATH:$HOME/skrypt` - katalog ~/skrypt będzie przeszukiwany na końcu
- `$HOME/skrypt:$PATH` - katalog ~/skrypt będzie przeszukiwany w pierwszej kolejności

`~/.zshrc`:
```sh
...
alias psu='ps -lU "$USER"'
```

2. Sprawdzić i zaprezentować podstawową różnicę między zmiennymi środowiska i zmiennymi lokalnymi shella. (1 pkt)

Zmienne środowiskowe:
- 

Zmienne lokalne shella:
- 

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

    | $ | ` ` | *
----|---|-----|--
" " |   |     |
' ' |   |     |
` ` |   |     |
\   |   |     |
