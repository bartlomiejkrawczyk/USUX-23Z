# Użytkowanie systemu UNIX (USUX) - Ćwiczenie 7

## Student
```md
Bartłomiej Krawczyk, 310774
```

## Filtr awk

Napisać skrypt służący do sumowania liczb całkowitych zapisanych w pliku. Postać wywołania skryptu:
```sh
nazwa_skryptu [-a]  plik  [kolumna1 kolumna2 ...]
```
np.:  
```sh
suma  a.txt  3 5
```

Plik wejściowy może zawierać kilka kolumn liczb całkowitych. Poszczególne kolumny rozdzielone są znakiem spacji lub tabulacji. Skrypt sumuje ze sobą wskazane kolumny (czyli w każdym wierszu dodaje liczby występujące we wskazanych kolumnach), tworzy wynikową kolumnę liczb i wypisuje ją na stdout. Przy braku argumentu "kolumna" należy podać wynik sumowania wszystkich kolumn.

Zrealizować następującą opcję:
- `-a` - skrypt podaje dodatkowo na stdout wynik sumowania wszystkich liczb w kolumnie wynikowej.

Wszystkie skrypty powinny zawierać obsługę błędów:
- sygnalizować błędy składni (podając poprawną postać),
- sygnalizować użycie niepoprawnego argumentu (np. nie istniejący plik),
- sygnalizować brak odpowiednich praw dostępu.
