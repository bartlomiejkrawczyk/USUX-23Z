# Użytkowanie systemu UNIX (USUX) - Ćwiczenie 10

## Student
```md
Bartłomiej Krawczyk, 310774
```

## Program make

1. Napisać zestaw plików sterujących dla programu make (Makefile nadrzędny w katalogu głównym projektu i lokalne pliki Makefile w katalogach z plikami źródłowymi) umożliwiających:
    - tworzenie i aktualizację biblioteki libusux.a w katalogu ./lib,
    - tworzenie programów prog1 i prog2 odpowiednio w katalogach ./src1 i ./src2 (wywołanie: make),
    - ustawianie jednakowych opcji kompilacji wszystkich plików źródłowych, np. -O, -g, -Dmakro itp. w nadrzędnym pliku sterującym Makefile,
    - zainstalowanie ww. programów w katalogu ./bin po ewentualnym utworzeniu tego katalogu (wywołanie: make install),
    - usuwanie plików pośrednich z relokowalnym kodem binarnym (wywołanie: make clean).

Make powinien zapewnić właściwą aktualizację projektu w przypadku zmiany któregokolwiek z plików źródłowych lub nagłówkowych. 

Należy zwrócić uwagę na kolejność wykonywania operacji w podkatalogach. 

Pliki Makefile powinny być jak najprostsze.

