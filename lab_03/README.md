# Użytkowanie systemu UNIX (USUX) - Ćwiczenie 3

## Procesy i sygnały

1. Za pomocą polecenia ps obejrzeć listę procesów z bieżącej sesji i zidentyfikować ich atrybuty (zwrócić uwagę na priorytet i wartość nice). (1 pkt)

```sh
$ ps -l -u "$USER"
F S   UID   PID  PPID  C PRI  NI ADDR SZ WCHAN  TTY          TIME CMD
```

Atrybuty:
- `F` - flagi procesu
- `S` - stan procesu
- `UID` - identyfikator użytkownika
- `PID` - identyfikator procesu
- `PPID` - identyfikator procesu rodzica (parent process id)
- `C` - procent użycia procesora przez proces
- `PRI` - priorytet procesu
- `NI` - "uprzejmość" procesu
- `ADDR` - adres procesu
- `SZ` - zużycie pamięci
- `WCHAN` - nazwa funkcji jądra, w czasie wykonywania, której proces jest uśpiony
- `TTY` - terminal
- `CMD` - nazwa oraz argumenty wywołania procesu

> Zwrócić uwagę na priorytet i wartość nice.
```sh
$ ps -o pri,nice,command
```

2. Obejrzeć listę wszystkich procesów w systemie.
Zidentyfikować własne procesy i narysować drzewo dziedziczenia od procesu o identyfikatorze PID=1 do tych procesów.
Zwrócić uwagę na stan poszczególnych procesów. (1 pkt)

> Obejrzeć listę wszystkich procesów w systemie.

```sh
ps -e
```

> Zidentyfikować własne procesy i narysować drzewo dziedziczenia od procesu o identyfikatorze PID=1 do tych procesów.

```sh
$ ps -efu "$USER" --forest
$ ps -e -u "$USER" -o pid,ppid,command --forest
$ pstree "$USER"
```

3. Sprawdzić reakcję procesów działających na pierwszym planie i w tle na wybrane sygnały. 
Wykorzystując wbudowane polecenie powłoki trap (man zshbuiltins), zmienić domyślną obsługę sygnału SIGINT w bieżącej powłoce - ustawić ignorowanie sygnału oraz wykonywanie polecenia w reakcji na sygnał. 
Sprawdzić, czy zmieni się obsługa sygnału w nowych procesach uruchamianych przez bieżącą powłokę w obydwu powyższych przypadkach. (1 pkt)

> zmienić domyślną obsługę sygnału SIGINT w bieżącej powłoce - ustawić ignorowanie sygnału
```sh
$ trap '' SIGINT
```

> zmienić domyślną obsługę sygnału SIGINT w bieżącej powłoce - ustawić wykonywanie polecenia w reakcji na sygnał
```sh
$ trap 'echo SIGINT' SIGINT
```

> Sprawdzić, czy zmieni się obsługa sygnału w nowych procesach uruchamianych przez bieżącą powłokę w obydwu powyższych przypadkach.

```sh
$ sleep 999
ctrl+c (SIGINT)
```

Długo trwający proces
```sh
$ sleep 999 &
```

```sh
$ pkill -INT sleep
```

4. Uruchomić kilka prac (np. polecenie sleep n) i sprawdzić działanie poleceń `jobs`, `fg`, `bg` wykorzystując różne argumenty. 
W jaki sposób przenieść proces z pierwszego planu do tła i z powrotem ? (1 pkt)

```sh
$ sleep 1000 &
$ sleep 2000 &
$ sleep 3000 &
$ sleep 4000 &
$ sleep 5000 &
```
- `jobs` - listuje procesy uruchomione w tle
- `fg` - foreground - ponownie dołącza proces uruchomiony w tle do terminala
- `bg` - background - przywraca działanie procesu po wysłaniu do niego sygnału SIGSTP

> W jaki sposób przenieść proces z pierwszego planu do tła?

Można wcisnąć kombinację `ctrl+z`, aby wysłać do procesu sygnał SIGSTP i przenieść go do tła. Następnie można wywołać `bg`, aby ponownie wystartować proces.

> W jaki sposób przenieść proces z powrotem z tła do pierwszego planu?

Można wywołać program `fg`, aby przywrócić proces z tła.

5. Uruchomić proces (np. sleep 100) w tle z obniżonym priorytem. 
Następnie zmienić priorytet działającego procesu. 
Obserwować wartości atrybutów: nice i priorytet. 
Czy priorytet można zmieniać dowolnie? (1 pkt)

```sh
$ sleep 100
```

```sh
$ ps -o pid,pri,nice,command
```

> Czy priorytet można zmieniać dowolnie?

Parametr nice może przyjmować wartości z zakresu jedynie -20-19.

Zwykły użytkownik może jedynie zwiększać wartość nice (zmniejszać priorytet). Jeśli priorytet zostanie podwyższony, to nie może go przywrócić do poprzedniego stanu.

Administrator ma prawo dowolnie podnosić i obniżać wartość nice.
