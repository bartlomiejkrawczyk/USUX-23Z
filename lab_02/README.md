# Użytkowanie systemu UNIX (USUX) - Ćwiczenie 2

## System plików

1. Zapoznać się z działaniem poleceń: mkdir, rmdir, rm, cp, mv, ln (wykorzystać informacje zawarte w manualu).

**mkdir** - program służy do tworzenia katalogów. Możliwe jest podanie opcji `-p`, aby utworzyć wszystkie katalogi ze ścieżki lub zapobiec błędowi, jeśli katalogi istnieją.

Przykład:
```sh
$ mkdir directory
$ ls
directory  README.md
```

**rmdir** - służy do usuwania pustych katalogów. Podobnie jak mkdir, możliwe jest usuwanie wielu katalogów z podaniem flagi `-p`.

Przykład:
```sh
$ rmdir directory
$ ls
README.md
```

**rm** - służy do usuwania (`unlink`) plików lub katalogów. Program zmniejsza ilość wskazań na inode i jeśli wartość spada do 0 to usuwana jest zawartość pliku.

Warto zwrócić uwagę na flagi:
- `-r` - rekursywne usuwanie katalogów i zawartości
- `-d` - usuwanie pustych katalogów
- `-f` / `--force` - ignorowanie nie istniejących plików, wyłączenie zapytań przed usunięciem pliku
- `-i` - zapytanie przed usunięciem każdego pliku

Przykład:
```sh
$ echo test > test
$ ls
README.md  test
$ rm test
$ ls
README.md
```

**cp** - program do kopiowania zawartości plików oraz katalogów.

Przykład:
```sh
$ echo test > test
$ cp test copy
$ ls -l
razem 16
-rw-r--r-- 1 usux5 usux    5 10-19 10:10 copy
-rw-r--r-- 1 usux5 usux 4852 10-19 10:10 README.md
-rw-r--r-- 1 usux5 usux    5 10-19 10:10 test
$ ls -i
2152604647 copy  2150583025 README.md  2150370953 test
```

**mv** - umożliwia przenoszenie plików z jednego miejsca w drugie. Dodatkowo pozwala na zmianę nazwy pliku, jeśli nie zmieniamy ścieżki. Możliwa jest zmiana relatywna do aktualnego katalogu oraz zmiana relatywna do `/`.
Przykład:
```sh
$ mv test tset
$ ls
copy  README.md  tset
$ mv tset test
```

**ln**  - służy do tworzenia połączeń między plikami. Domyślnie tworzone są twarde dowiązania. Dowiązania symboliczne możliwe są do utworzenia po podaniu flagi `-s`.

Przykład:
```sh
$ ln test hard
$ ln -s test symbolic
$ ls -l
razem 20
-rw-r--r-- 1 usux5 usux    5 10-19 10:10 copy
-rw-r--r-- 2 usux5 usux    5 10-19 10:10 hard
-rw-r--r-- 1 usux5 usux 5014 10-19 10:11 README.md
lrwxrwxrwx 1 usux5 usux    4 10-19 10:12 symbolic -> test
-rw-r--r-- 2 usux5 usux    5 10-19 10:10 test
```

2. Sprawdzić znaczenie praw dostępu rwx dla pliku zwykłego i katalogu. Jakie prawa własności i prawa dostępu do katalogu i znajdujących się w nim plików są konieczne (minimalny zestaw), aby wykonać operacje: cp, mv i rm na tych plikach? Wyniki przedstawić w tabeli. Sprawdzić uprawnienia potrzebne do usunięcia całej gałęzi drzewa katalogów (czyli katalogu wraz z zawartymi plikami) (2 pkt)

```sh
~/$ cp source/file destination/file
~/$ mv source/file destination/file
```

komenda | katalog źródłowy | katalog docelowy | plik
--------|------------------|------------------|------
cp      | --x              | -wx              | r--
mv      | -wx              | -wx              | ---

```sh
~/directory$ rm file
```

komenda | katalog | plik
--------|---------|------
rm      | -wx     | ---

> Sprawdzić uprawnienia potrzebne do usunięcia całej gałęzi drzewa katalogów (czyli katalogu wraz z zawartymi plikami)

```sh
~/parent$ rm -rf child
```

komenda | katalog rodzic | katalog dziecko | plik
--------|----------------|-----------------|------
rm      | -wx            | rwx             | ---


3. Porównać efekty utworzenia kopii pliku, nowego dowiązania i nowego dowiązania symbolicznego. (2 pkt)

```sh
echo test > test
cp test copy
ln -s test symbolic
ln test hard
```

> W jaki sposób rozróżnić te pozycje w katalogu?

```sh
$ ls -l
razem 20
-rw-r--r-- 1 usux5 usux    5 10-19 10:10 copy
-rw-r--r-- 2 usux5 usux    5 10-19 10:10 hard
-rw-r--r-- 1 usux5 usux 4874 10-19 10:12 README.md
lrwxrwxrwx 1 usux5 usux    4 10-19 10:12 symbolic -> test
-rw-r--r-- 2 usux5 usux    5 10-19 10:10 test
```

Kopia:
- identyczna zawartość co plik kopiowany
- 1 dowiązanie w i-węźle
- modyfikowanie zawartości nie wpływa na plik oryginalny
- w katalogu tworzony jest dodatkowy plik o identycznej zawartości co poprzedni
- nowy plik ma przydzielony nowy i-węzeł

Dowiązanie symboliczne:
- program ls wyświetla ścieżkę, na którą plik wskazuje np. `symbolic -> test`
- w pliku ustawiona jest dodatkowa flaga typu `l` np. lrwxrwxrwx
- dowiązanie stanowi oddzielny plik (1 dowiązanie do i-węzła), którego zawartość to relatywna ścieżka, na którą wskazuje
- program może sam decydować czy podążąć za dowiązaniami symbolicznymi

```sh
$ ls --inode
2152604647 copy  2150583025 README.md  2150370953 test
2150370953 hard  2155687914 symbolic
```

Dowiązanie twarde:
- program ls wyświetla zwiększoną ilość dowiązań do pliku
- możliwe jest także sprawdzenie numeru inode 
    - hard i test mają identyczny numer 2150370953 - wskazują na ten sam plik
- w trakcie tworzenia dowiązania twardego w katalogu zapisywane jest wskazanie na istniejący inode i zwiększana jest ilość dowiązań w i-węźle

> Ile zużyto i-węzłów?

- kopia oraz dowiązanie symboliczne wykorzystały po 1 i-węźle
- dowiązanie twarde nie zwiększyło ilości i-węzłów (zwiększona została ilość dowiązań w istniejącym i-węźle)

> Czy można utworzyć dowiązanie do nieistniejącego pliku?

Możliwe jest utworzenie jedynie symbolicznego dowiązania do nie istniejącego pliku.

4. Zapoznać się z działaniem polecenia find. Wykonać testy według zaleceń prowadzącego ćwiczenie. (1 pkt)

**find** - program pozwalający na przeszukiwanie hierarchii plików.

Zalecenia prowadzącego - wyszukać:
- pliki zwykłe
- prawa dostępu co najmniej 644
- lista plików z atrybutami

Przykład: 
```sh
find . -type f -perm -644 -printf "%m %p\n"
```
