# Użytkowanie systemu UNIX (USUX) - Ćwiczenie 1

## Zajęcia wstępne (podstawowe polecenia systemu, edycja plików)


1. Zapoznać się ze strukturą sekcji manuala (polecenie `man`). Zlokalizować informacje o poleceniach systemowych (sekcja 1), funkcjach systemowych (sekcja 2) i standardowych funkcjach języka C (sekcja 3) - na przykładzie mkdir, cp, printf, sleep, read, write itp.

Polecenia `man` stanowi interfejs dla systemowych podręczników dostępnych dla użytkownika. Man przeszukuje dostępne pliki i domyślnie otwiera je z wykorzystaniem programu `less`. Podręczniki `man` mają określoną budowę.

Kolejno dostępne są punkty:
- krótki opis
- dostępne opcje
- długi opis
- przykłady użycia
- przegląd
- opis dostępnych opcji wyołania programu  

W celu wyszukania manuali dla komed ze wszystkich dostępnych sekcji można podać flagę `-a`:
```sh
$ man man | grep '\--all' -A 4
       -a, --all
              By default, man will exit after displaying the most suitable manual  page  it  finds.
              Using  this  option  forces man to display all the manual pages with names that match
              the search criteria.
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
- write

Funkcje systemowe (sekcja 2):
- mkdir
- read
- write

Standardowe funkcje języka C (sekcja 3):
- printf
- sleep

2. Sprawdzić działanie programów which, whatis i apropos.

**wchich**

Przykład:
```sh
$ which cp
/usr/bin/cp
```

```sh
$ whatis which
which (1)            - locate a command
```

Komenda `which` pozwala na zlokalizowanie pliku wykonywalnego. Wykonuje to poprzez przeszukiwanie lokalizacji ze zmiennej `$PATH` - zwraca lokalizację pierwszego napotkanego pliku o nazwie równej argumentowi.

**whatis**

Przykład:
```sh
$ whatis mkdir
mkdir (1)            - make directories
mkdir (2)            - create a directory
```

```sh
$ whatis whatis
whatis (1)           - display one-line manual page descriptions
```

Program `whatis` zwraca jedno-linijkowy opis manuali oraz w jakiej sekcji dana komenda może się znajdować.

**apropos**

Przykład:
```sh
$ apropos apropos
apropos (1)          - search the manual page names and descriptions
```

Program `apropos` pozwala przeszukać wszystkie dostępne manuale w poszukiwanie pewnego słowa kluczowego. Dla znalezionych manuali wyświetlany jest krótki opis.

3. Wywołać polecenia id, who, w, last. Sprawdzić w manualu zawartość kolumn oraz dostępne opcje.

**id** - pozwala wyświetlić uid użytkownika oraz id grup w których się znajduje

**who** - 

**w** - pokazuje kto jest w danym momencie zalogowany i co teraz robi

**last** - pozwala wylistować datę ostatnio zalogowanych użytkowników

4. Za pomocą poleceń pwd, ls i cd obejrzeć strukturę drzewa katalogów. Sprawdzić działanie opcji i argumentów.

**pwd**

Komenda pozwala wyświetlić bieżącą ścieżkę.
```sh
$ pwd
/home/bartlomiejkrawczyk/USUX
```

Z dostępnych flat ciekawą jest unikanie symlinków.

**ls**

Program pozwala wylistować zawartość aktualnego katalogu.
```sh
$ ls
lab_01
```

Z flag wartych uwagi są:
- `-l` - pozwala wylistować metadane plików
- `-a` - wyświetla całą zawartość folderów - włącznie z ukrytymi plikami

```sh
ls -al
total 56
drwxr-xr-x 14 bartlomiejkrawczyk bartlomiejkrawczyk 4096 Oct  5 10:12 .
drwxr-x--- 27 bartlomiejkrawczyk bartlomiejkrawczyk 4096 Oct  5 11:10 ..
drwxr-xr-x  7 bartlomiejkrawczyk bartlomiejkrawczyk 4096 Oct  5 10:13 .git
drwxr-xr-x  2 bartlomiejkrawczyk bartlomiejkrawczyk 4096 Oct  5 11:06 lab_01
```

**cd**

Pozwala na modyfikację bieżącej ścieżki.

```sh
~/USUX$ cd lab_01/

~/USUX/lab_01$ cd -

~/USUX$ cd

~$
```


**tree**

Pozwala wyświetlić strukturę katalogów w postaci drzewa.
```sh
tree
.
└── lab_01
    └── README.md
```

5. Zapoznać się z działaniem programów do przeglądania plików tekstowych: cat, more i less.

**cat** - służy do konkatenacji plików, dodatkowo pozwala na wyświetlenie zawartości pliku w konsoli.

**more** - pozwala na wyświetlenie zawartości pliku po jednej stronie na raz.

**less** - pozwala na wyświetlenie zawartości pliku z wieloma opcjami przewijania zawartości.

6. Zapoznać się z działaniem edytorów vim, nano, gedit i geany. Przy pomocy edytora vim napisać krótkie sprawozdanie z ćwiczenia.

**vim** - lekki, jednak zaawansowany edytor tekstu. Wymaga zapoznania się z podstawowymi komendami, aby móc z niego korzystać.

**nano** - prosty edytor tekstu przystępny dla nowych użytkowników.

**gedit** - pełna aplikacja z interfejsem graficznym, zapewnia podstawowe funkcje edycji tekstu.

**geany** - stanowi IDE z wieloma opcjami.


