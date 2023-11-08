# Użytkowanie systemu UNIX (USUX) - Ćwiczenie 6

## Student
```md
Bartłomiej Krawczyk, 310774
```

## Filtry grep i sed

[Materiały pomocnicze](https://studia.elka.pw.edu.pl/f-raw/23Z/103B-xxxxx-ISP-USUX/priv//materialy.html) zawierają szczegółowe informacje o programach `grep` i `sed`.

1. Wykorzystując program `sed`, napisać skrypt służący do zamiany fragmentów tekstu w pliku wejściowym. Postać wywołania skryptu:
```sh
zamien plik tekst1 tekst2
```

Wszystkie wystąpienia fragmentu `tekst1` w pliku powinny być zastąpione przez `tekst2`. Plik oryginalny pozostaje bez zmian, a zmodyfikowany tekst należy zapisać w nowym pliku o nazwie:  `plik.n`, gdzie n oznacza kolejny numer, np. `plik.1` (jeśli `plik.1` już istnieje, to `plik.2` itd.).

Napisać skrypt wywoływany w następujący sposób:
```sh
licz [-R] katalog [typ]
```

Skrypt zlicza pliki określonego typu (np. d -katalogi, f -pliki zwykłe, l -dowiązania itp.) we wskazanym katalogu i wypisuje uzyskany wynik na stdout. W przypadku katalogów nie zliczać pozycji: . i .. Przy braku argumentu `typ` należy zliczyć pliki wszystkich typów. Z opcją `–R` skrypt działa rekurencyjnie w gałęzi drzewa katalogów wskazanej przez  `katalog`.

**UWAGA**

Wszystkie skrypty powinny zawierać obsługę błędów:
- sygnalizować błędy składni (podając poprawną postać),
- sygnalizować użycie niepoprawnego argumentu,
- sygnalizować brak odpowiednich praw dostępu.
