# Użytkowanie systemu UNIX (USUX) - Ćwiczenie 1

## Zajęcia wstępne (podstawowe polecenia systemu, edycja plików)


1. Zapoznać się ze strukturą sekcji manuala (polecenie `man`). Zlokalizować informacje o poleceniach systemowych (sekcja 1), funkcjach systemowych (sekcja 2) i standardowych funkcjach języka C (sekcja 3) - na przykładzie mkdir, cp, printf, sleep, read, write itp.

Polecenia `man` stanowi interfejs dla systemowych podręczników dostępnych dla użytkownika. Man przeszukuje dostępne pliki i domyślnie otwiera je z wykorzystaniem programu `less`. Podręczniki `man` mają określoną budowę.

Kolejno dostępne są punkty:
- nazwa / krótki opis
- składnia / dostępne opcje
- długi opis
- przykłady użycia
- wprowadzenie
- zachowania domyślne
- opis dostępnych opcji wyołania programu
- kody zakończenia i co oznaczają
- środowisko
- pliki / opis plików konfiguracyjnych
- przydatne metody
- historia 

W celu wyszukania manuali dla komed ze wszystkich dostępnych sekcji można podać flagę `-a`:
```sh
usux5@cad10[~]$ man man | grep '\--all' -A 4
       -a, --all
              Domyślnie  man  zakończy  działanie  po wyświetleniu najbardziej
              odpowiedniej strony podręcznika, jaką znajdzie. Użycie tej opcji
              spowoduje,  że man pokaże wszystkie dostępne strony podręcznika,
              których nazwy odpowiadają kryteriom wyszukiwania.
```

Przykład:
```sh
$ man -a man
--Man-- następna: man(1) [ przeglądaj (return) | pomiń (Ctrl-D) | zakończ (Ctrl-C) ]

--Man-- następna: man(1p) [ przeglądaj (return) | pomiń (Ctrl-D) | zakończ (Ctrl-C) ]

--Man-- następna: man(7) [ przeglądaj (return) | pomiń (Ctrl-D) | zakończ (Ctrl-C) ]

--Man-- następna: man(7) [ przeglądaj (return) | pomiń (Ctrl-D) | zakończ (Ctrl-C) ]
```

Poszczególne sekcje są dostępne podając dodatkowo numer sekcji:
```sh
$ man 2 mkdir
```

Polecenia systemowe (sekcja 1):
- mkdir
- cp
- printf
- sleep
- read
- write

Funkcje systemowe (sekcja 2):
- mkdir
- read
- write

Standardowe funkcje języka C (sekcja 3):
- mkdir
- printf
- sleep
- read
- write

2. Sprawdzić działanie programów which, whatis i apropos.

**wchich**

Przykład:
```sh
$ which cp
/usr/bin/cp
```

```sh
$ whatis which
which (1)            - lokalizuje polecenie
```

Komenda `which` pozwala na zlokalizowanie pliku wykonywalnego. Wykonuje to poprzez przeszukiwanie lokalizacji ze zmiennej `$PATH` - zwraca lokalizację pierwszego napotkanego pliku o nazwie równej argumentowi.

**whatis**

Przykład:
```sh
$ whatis mkdir
mkdir (1)            - tworzy katalogi
mkdir (1p)           - make directories
mkdir (2)            - create a directory
mkdir (3p)           - make a directory
```

```sh
$ whatis whatis
whatis (1)           - wyświetla opisy stron podręcznika systemowego
```

Program `whatis` zwraca jedno-linijkowy opis manuali oraz w jakiej sekcji dana komenda może się znajdować.

**apropos**

Przykład:
```sh
$ apropos apropos
apropos (1)          - przeszukiwanie nazw i opisów stron podręcznika ekranowego
```

Program `apropos` pozwala przeszukać wszystkie dostępne manuale w poszukiwanie pewnego słowa kluczowego. Dla znalezionych manuali wyświetlany jest krótki opis.

3. Wywołać polecenia id, who, w, last. Sprawdzić w manualu zawartość kolumn oraz dostępne opcje.

**id** - pozwala wyświetlić uid użytkownika oraz id grup w których się znajduje.

Przykład:
```sh
$ id
uid=3005(usux5) gid=3000(usux) grupy=3000(usux)
```

**who** - komenda umożliwia wyświetlenie zalogowanych użytkowników

Przykład:
```sh
$ who
usux5    :0           2023-10-12 10:21 (:0)
usux5    pts/0        2023-10-12 10:23 (:0)
usux5    pts/1        2023-10-12 10:24 (:0)
```

**w** - pokazuje kto jest w danym momencie zalogowany oraz co aktualnie robi

Przykład:
```sh
$ w
 10:40:46 up 12 days, 20:27,  3 users,  load average: 0,12, 0,10, 0,13
USER     TTY      FROM             LOGIN@   IDLE   JCPU   PCPU WHAT
usux5    :0       :0               10:21   ?xdm?  18:56   0.29s mate-session
usux5    pts/0    :0               10:23    6.00s  0.77s  0.35s vim README.md
usux5    pts/1    :0               10:24    6.00s  0.09s  0.00s w
```

**last** - pozwala wylistować datę ostatnio zalogowanych użytkowników

Przykład:
```sh
usux5@cad10[~]$ last | grep "still logged in"
usux5    pts/1        :0               Thu Oct 12 10:24   still logged in   
usux5    pts/0        :0               Thu Oct 12 10:23   still logged in   
usux5    :0           :0               Thu Oct 12 10:21   still logged in
```

4. Za pomocą poleceń pwd, ls i cd obejrzeć strukturę drzewa katalogów. Sprawdzić działanie opcji i argumentów.

**pwd**

Komenda pozwala wyświetlić bieżącą ścieżkę.
```sh
usux5@cad10[~/USUX]$ pwd
/lab/usux5/USUX
```

Z dostępnych flag ciekawą jest unikanie symlinków `--physical`.

**ls**

Program pozwala wylistować zawartość aktualnego katalogu.
```sh
$ ls
README.md
```

Z flag wartych uwagi są:
- `-l` - pozwala wylistować metadane plików
- `-a` - wyświetla całą zawartość folderów - włącznie z ukrytymi plikami oraz . i ..
- `-A` - to samo co `-a` jednak pomija . i ..
- `-i` - wyświetla numer i-węzła każdego pliku
- `-R` - rekursywne listowanie katalogów

```sh
$ ls -al
razem 24
drwxr-xr-x 2 usux5 usux    43 10-12 10:46 .
drwxr-xr-x 5 usux5 usux    43 10-12 10:24 ..
-rw-r--r-- 1 usux5 usux  6004 10-12 10:46 README.md
-rw-r--r-- 1 usux5 usux 16384 10-12 10:49 .README.md.swp
```
Warto zwrócić uwagę na występowanie `.` oraz `..` wewnątrz katalogu. `.` to odniesienie do aktualnego katalogu, a `..` do katalogu rodzica co umożliwia przemieszczanie się wzdłuż gałęzi drzewa katalogów.

**cd**

Pozwala na modyfikację bieżącej ścieżki. Bez podania argumentu przenoszeni jesteśmy do katalogu domowego.

```sh
usux5@cad10[~/USUX/lab_01]$ cd ..
usux5@cad10[~/USUX]$ cd lab_01/
usux5@cad10[~/USUX/lab_01]$ cd -
~/USUX
usux5@cad10[~/USUX]$ cd
usux5@cad10[~]$ 
```

5. Zapoznać się z działaniem programów do przeglądania plików tekstowych: cat, more i less.

**cat** - służy do konkatenacji plików i wypisania ich na standardowe wyjście, co pozwala na wyświetlenie zawartości pliku w konsoli.

Przykład:
```sh
usux5@cad10[~/USUX/lab_01]$ echo Ala ma kota > test
usux5@cad10[~/USUX/lab_01]$ cat test 
Ala ma kota
usux5@cad10[~/USUX/lab_01]$ echo 1 > 01
usux5@cad10[~/USUX/lab_01]$ echo 2 > 02
usux5@cad10[~/USUX/lab_01]$ cat 01 02 
1
2
```

**more** - pozwala na wyświetlenie zawartości pliku po jednej stronie na raz. Przewijanie po pliku jest możliwe przy użyciu przycisków spacja, d, s, f lub b.

**less** - podobnie jak more pozwala na wyświetlenie zawartości pliku z wieloma opcjami przewijania zawartości. Intuicyjna obsługa za pomocą strzałek oraz scrolla, przewijanie albo po lini, albo po pełnych stronach.

6. Zapoznać się z działaniem edytorów vim, nano, gedit i geany. Przy pomocy edytora vim napisać krótkie sprawozdanie z ćwiczenia.

**vim** - lekki, jednak zaawansowany edytor tekstu. Wymaga zapoznania się z podstawowymi komendami, aby móc z niego korzystać.

Warto zwrócić uwagę na skróty:
- Esc lub Ctrl + C - wyjście z trybu wprowadzania
- a - przejście do trybu wprowadzania za aktualnym kursorem
- :wq - zapisanie pliku
- :w NAME - zapisanie pliku o podanej nazwie
- dd - wycięcie lini
- p - wstawienie tekstu ze schowka za kursorem
- 2dd - umożliwia wycinanie 2 lini na raz, możliwe jest podanie różnej ilości 
- yy - pozwala na kopiowanie lini
- u - służy do wycofania wprowadzonych zmian
- Ctrl + r - pozwala na przywrócenie wycofanej zmiany
- 0 - przejście na początek wiersza
- $ - przejście na koniec wiersza
- strzałki, hjkl - umożliwa przemieszczanie się po pliku
- /TEXT - wyszukiwanie tekstu do przodu
- ?TEXT - wyszukiwanie tekstu w tył

**nano** - prosty edytor tekstu przystępny dla nowych użytkowników. Skróty klawiszowe bezpośrednio dostępne z poziomu terminala.

**gedit** - pełna aplikacja z interfejsem graficznym, zapewnia podstawowe funkcje edycji tekstu.

**geany** - stanowi lekkie IDE z wieloma opcjami. Umożliwia budowanie programów z wykorzystaniem make.


