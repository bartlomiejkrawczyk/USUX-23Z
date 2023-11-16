# Użytkowanie systemu UNIX (USUX) - Ćwiczenie 8

## Student
```md
Bartłomiej Krawczyk, 310774
```

## Narzędzia programistyczne

1. Wykorzystując kompilator `gcc` wykonać następujące czynności:
    - przenieść prywatne pliki nagłówkowe (`*.h`) do innego katalogu niż pliki źródłowe `*.c`,
    - skompilować wszystkie pliki źródłowe i utworzyć z nich program wynikowy o nazwie `prog`,
    - porównać rozmiar pliku wynikowego otrzymanego po kompilacji z włączoną i wyłączoną optymalizacją,
    - znaleźć w kodzie źródłowym makro sterujące procesem prekompilacji i wykorzystując odpowiednią opcję programu `gcc` wykonać punkt 1b w dwóch wersjach.


2. Posługując się programem `ar` wykonać operacje:
    - zbudować własną bibliotekę statyczną `libusux.a` z wybranych plików obiektowych,
    - wykorzystać stworzoną bibliotekę do utworzenia tego samego programu co w punkcie 1b.

3. Posługując się programem `gcc` wykonać operacje:
    - zbudować własną bibliotekę dzieloną (dynamiczną) `libusux.so` z wybranych plików obiektowych,
    - wykorzystać stworzoną bibliotekę do utworzenia tego samego programu co w punkcie 1b.
    - zmodyfikować ścieżkę poszukiwań bibliotek, aby umożliwić wykonywanie programu.

4. Obejrzeć tablicę symboli programu `prog` i biblioteki `libusux.a`. Usunąć tablicę symboli z obu tych plików. Sprawdzić działanie programu po usunięciu tablicy symboli. Powtórzyć punkt 2b i wytłumaczyć ewentualne różnice w działaniu kompilatora.


5. Używając programów `gcc` i `gdb` wykonać następujące polecenia:
    - stworzyć program `prog` w taki sposób by umożliwić śledzenie jego pracy za pomocą `gdb`,
    - obejrzeć kod źródłowy przy pomocy `gdb`, wybrać miejsca dla kilku pułapek i je ustawić,
    - używając odpowiedniego polecenia programu `gdb` podać argumenty wywołania programu,
    - ustawić tryb śledzenia dla wybranej zmiennej,
    - uruchomić program,
    - w trakcie krokowego wykonywania programu zmienić wartość zmiennej z punktu 4d.
