# Użytkowanie systemu UNIX (USUX) - Ćwiczenie 11

## Student
```md
Bartłomiej Krawczyk, 310774
```

## Skrypty powłoki i program make

1. Napisać skrypt, który generuje plik sterujący Makefile do podanego projektu. Wywołanie skryptu:
```sh
skrypt katalog
```

Założenia:
- wszystkie pliki źródłowe w podanym katalogu służą do utworzenia jednego programu wynikowego,
- nazwą pliku wykonywalnego jest rdzeń nazwy pliku źródłowego, zawierającego funkcję main,
- w katalogu znajduje się podkatalog `headers` z lokalnymi plikami nagłówkowymi,
- lokalne pliki nagłówkowe włączane są wybiórczo w niektórych plikach źródłowych w następujący sposób: `#include "cos.h"`
- make powinien zapewnić właściwą aktualizację projektu w przypadku zmiany któregokolwiek z plików źródłowych lub nagłówkowych.
