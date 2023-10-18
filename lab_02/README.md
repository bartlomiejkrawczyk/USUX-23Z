# Użytkowanie systemu UNIX (USUX) - Ćwiczenie 2

## System plików

1. Zapoznać się z działaniem poleceń: mkdir, rmdir, rm, cp, mv, ln (wykorzystać informacje zawarte w manualu).

**mkdir** - program służy do tworzenia katalogów. Możliwe jest podanie opcji `-p`, aby utworzyć wszystkie katalogi ze ścieżki lub zapobiec błędowi, jeśli katalogi istnieją.

Przykład:
```sh
$ mkdir directory
$ ls
README.md  directory
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
README.md
$ ls
```

**cp** - program do kopiowania zawartości plików oraz katalogów.

Przykład:
```sh
$ echo test > test
$ cp test copy
$ ls -l
TODO
$ ls -i
18327 README.md  48540 copy  48543 test
```

**mv** - umożliwia przenoszenie plików z jednego miejsca w drugie. Dodatkowo pozwala na zmianę nazwy pliku, jeśli nie zmieniamy ścieżki. Możliwa jest zmiana relatywna do aktualnego katalogu oraz zmiana relatywna do `/`.
Przykład:
```sh
$ mv test tset
$ ls
README.md  copy  tset
$ mv tset test
```

**ln**  - służy do tworzenia połączeń między plikami. Domyślnie tworzone są twarde dowiązania. Dowiązania symboliczne możliwe są do utworzenia po podaniu flagi `-s`.

Przykład:
```sh
$ ln test hard
$ ln -s test symbolic
$ ls -l
total 20
-rw-r--r-- 1 bartlomiejkrawczyk bartlomiejkrawczyk 4246 Oct 18 19:39 README.md
-rw-r--r-- 1 bartlomiejkrawczyk bartlomiejkrawczyk    5 Oct 18 19:32 copy
-rw-r--r-- 2 bartlomiejkrawczyk bartlomiejkrawczyk    5 Oct 18 19:28 hard
lrwxrwxrwx 1 bartlomiejkrawczyk bartlomiejkrawczyk    4 Oct 18 19:40 symbolic -> test
-rw-r--r-- 2 bartlomiejkrawczyk bartlomiejkrawczyk    5 Oct 18 19:28 test
```

2. Sprawdzić znaczenie praw dostępu rwx dla pliku zwykłego i katalogu. Jakie prawa własności i prawa dostępu do katalogu i znajdujących się w nim plików są konieczne (minimalny zestaw), aby wykonać operacje: cp, mv i rm na tych plikach? Wyniki przedstawić w tabeli. Sprawdzić uprawnienia potrzebne do usunięcia całej gałęzi drzewa katalogów (czyli katalogu wraz z zawartymi plikami) (2 pkt)

komenda | katalog | plik
--------|---------|-----
cp      | r-x     | r--
mv      | -wx     | ---
rm      | ---     | ---

Aby usunąć gałąź drzewa katalogów trzeba mieć co najmniej uprawnienia do pisania i wykonywania danego katalogu oraz uprawnienia do pisania dla katalogu nadrzędnego.

3. Porównać efekty utworzenia kopii pliku, nowego dowiązania i nowego dowiązania symbolicznego. (2 pkt)

```sh
echo TEST > test
cp test copy
ln -s test symbolic
ln test hard
```

> W jaki sposób rozróżnić te pozycje w katalogu?

```sh
$ ls -l
total 20
-rw-r--r-- 1 bartlomiejkrawczyk bartlomiejkrawczyk 4719 Oct 18 19:43 README.md
-rw-r--r-- 1 bartlomiejkrawczyk bartlomiejkrawczyk    5 Oct 18 19:32 copy
-rw-r--r-- 2 bartlomiejkrawczyk bartlomiejkrawczyk    5 Oct 18 19:28 hard
lrwxrwxrwx 1 bartlomiejkrawczyk bartlomiejkrawczyk    4 Oct 18 19:40 symbolic -> test
-rw-r--r-- 2 bartlomiejkrawczyk bartlomiejkrawczyk    5 Oct 18 19:28 test
```

Kopia:
- identyczna zawartość co plik kopiowany
- 1 dowiązanie w inode

Dowiązanie symboliczne:
- program ls wyświetla ścieżkę, na którą plik wskazuje
- dowiązanie stanowi oddzielny plik (1 dowiązanie do inode)

```sh
$ ls --inode
 18327 README.md   48540 copy   48543 hard  274441 symbolic   48543 test
```

Dowiązanie twarde:
- program ls wyświetla zwiększoną ilość dowiązań do pliku
- możliwe jest także sprawdzenie numeru inode (hard i test mają identyczny numer - wskazują na ten sam plik)

> Ile zużyto i-węzłów?

- kopia oraz dowiązanie symboliczne wykorzystały po 1 i-węźle
- dowiązanie twarde nie zwiększyło ilości i-węzłów (zwiększona została ilość dowiązań w istniejącym i-węźle)

> Czy można utworzyć dowiązanie do nieistniejącego pliku?

Możliwe jest utworzenie jedynie symbolicznego dowiązania do nie istniejącego pliku.

4. Zapoznać się z działaniem polecenia find. Wykonać testy według zaleceń prowadzącego ćwiczenie. (1 pkt)

**find** - program pozwalający na przeszukiwanie hierarchii plików.

TODO: zalecenie nie znane

Przykład:
```sh
find . -type d -group grupa -perm /g+r -exec chmod 700 {} +
```

