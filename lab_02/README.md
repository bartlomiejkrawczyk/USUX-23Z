# Użytkowanie systemu UNIX (USUX) - Ćwiczenie 2

## System plików

1. Zapoznać się z działaniem poleceń: mkdir, rmdir, rm, cp, mv, ln (wykorzystać informacje zawarte w manualu).

**mkdir**

**rmdir**

**rm**

**cp**

**mv**

**ln**

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

```sh
$ ls -l
total 16
-rw-r--r-- 1 bartlomiejkrawczyk bartlomiejkrawczyk 1383 Oct  5 12:41 README.md
-rw-r--r-- 1 bartlomiejkrawczyk bartlomiejkrawczyk    4 Oct  5 12:40 copy
-rw-r--r-- 2 bartlomiejkrawczyk bartlomiejkrawczyk    4 Oct  5 12:39 hard
lrwxrwxrwx 1 bartlomiejkrawczyk bartlomiejkrawczyk    4 Oct  5 12:40 symbolic -> test
-rw-r--r-- 2 bartlomiejkrawczyk bartlomiejkrawczyk    4 Oct  5 12:39 test
```

W jaki sposób rozróżnić te pozycje w katalogu? Ile zużyto i-węzłów? Czy można utworzyć dowiązanie do nieistniejącego pliku?

Po wywołaniu komendy `ls` z flagą `-l` otrzymujemy informacje o ilości dowiązań do danego pliku, a w przypadku dowiązania symbolicznego pokazana jest strzałka wskazująca na dowiązanie.

Dowiązanie symboliczne to tak naprawdę utworzenie nowego pliku, który przechowuje adres pliku wskazywanego. To programy same definiują czy chcą korzystać z pliku wskazywanego, czy może działać na symlinku.

Kopia to utworzenie całkowicie nowego pliku o zawartości takiej jak plik kopiowany.

Dowiązanie `hard` to utworzenie wskazania na dany plik bez tworzenia kopii. 

Możliwe jest utworzenie jedynie symbolicznego dowiązania do nie istniejącego pliku.

4. Zapoznać się z działaniem polecenia find. Wykonać testy według zaleceń prowadzącego ćwiczenie. (1 pkt)

