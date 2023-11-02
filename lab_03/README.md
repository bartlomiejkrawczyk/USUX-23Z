# Użytkowanie systemu UNIX (USUX) - Ćwiczenie 3

## Procesy i sygnały

1. Za pomocą polecenia ps obejrzeć listę procesów z bieżącej sesji i zidentyfikować ich atrybuty (zwrócić uwagę na priorytet i wartość nice). (1 pkt)

```sh
$ ps -l
F S   UID   PID  PPID  C PRI  NI ADDR SZ WCHAN  TTY          TIME CMD
0 S  3005 19718 18660  0  80   0 - 37393 sigsus pts/1    00:00:00 zsh
0 R  3005 21479 19718  0  80   0 - 38332 -      pts/1    00:00:00 ps
```

```sh
$ ps -l -T            
F S   UID   PID  SPID  PPID  C PRI  NI ADDR SZ WCHAN  TTY          TIME CMD
0 S  3005 19718 19718 18660  0  80   0 - 36797 sigsus pts/1    00:00:00 zsh
0 R  3005 20900 20900 19718  0  80   0 - 38332 -      pts/1    00:00:00 ps
```

```sh
$ ps -l -u "$USER"
F S   UID   PID  PPID  C PRI  NI ADDR SZ WCHAN  TTY          TIME CMD
1 S  3005 17957     1  0  80   0 - 79439 poll_s ?        00:00:00 gnome-keyring-d
4 S  3005 17985 17939  0  80   0 - 142592 poll_s ?       00:00:00 mate-session
1 S  3005 17995     1  0  80   0 - 17397 poll_s ?        00:00:00 dbus-launch
...
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
$ ps -eo pri,nice,command
PRI  NI COMMAND
 19   0 /usr/lib/systemd/systemd --switched-root --system --deserialize 22
 19   0 [kthreadd]
 39 -20 [kworker/0:0H]
 19   0 [ksoftirqd/0]
139   - [migration/0]
```

Im wyższa wartość nice tym proces ma mniejszy priorytet. W przypadku PRI jest odwrotnie - to znaczy im wyższa wartość PRI tym proces jest ważniejszy.

2. Obejrzeć listę wszystkich procesów w systemie.
Zidentyfikować własne procesy i narysować drzewo dziedziczenia od procesu o identyfikatorze PID=1 do tych procesów.
Zwrócić uwagę na stan poszczególnych procesów. (1 pkt)

> Obejrzeć listę wszystkich procesów w systemie.

```sh
$ ps -le                     
F S   UID   PID  PPID  C PRI  NI ADDR SZ WCHAN  TTY          TIME CMD
4 S     0     1     0  0  80   0 - 47883 ep_pol ?        00:00:21 systemd
1 S     0     2     0  0  80   0 -     0 kthrea ?        00:00:00 kthreadd
1 S     0     4     2  0  60 -20 -     0 worker ?        00:00:00 kworker/0:0H
1 S     0     6     2  0  80   0 -     0 smpboo ?        00:00:00 ksoftirqd/0
1 S     0     7     2  0 -40   - -     0 smpboo ?        00:00:00 migration/0
...
```

> Zidentyfikować własne procesy i narysować drzewo dziedziczenia od procesu o identyfikatorze PID=1 do tych procesów.

```sh
$ ps -u "$USER" -o uid,pid,ppid,command --forest
...
 3005 19376     1 /usr/share/code/chrome_crashpad_handler --monitor-self-annotat
 3005 19353     1 /usr/share/code/code .
 3005 19357 19353  \_ /usr/share/code/code --type=zygote --no-zygote-sandbox
 3005 19390 19357  |   \_ /usr/share/code/code --type=gpu-process --crashpad-han
 3005 19399 19390  |       \_ /usr/share/code/code --type=broker
 3005 19358 19353  \_ /usr/share/code/chrome-sandbox /usr/share/code/code --type
 3005 19360 19358  |   \_ /usr/share/code/code --type=zygote
 3005 19362 19360  |       \_ /usr/share/code/code --type=zygote
 3005 19405 19353  \_ /usr/share/code/code --type=utility --utility-sub-type=net
 3005 19417 19353  \_ /usr/share/code/code --type=renderer --crashpad-handler-pi
 3005 19443 19353  \_ /usr/share/code/code --type=utility --utility-sub-type=nod
 3005 19485 19443  |   \_ /usr/share/code/code --ms-enable-electron-run-as-node 
 3005 19444 19353  \_ /usr/share/code/code --type=utility --utility-sub-type=nod
 3005 19464 19353  \_ /usr/share/code/code --type=utility --utility-sub-type=nod
 3005 19602 19464      \_ /usr/share/code/code --ms-enable-electron-run-as-node 
 3
...
```

W przypadku ps należy zauważyć, że każdy proces który nie zaczyna się od gałęzi ma ustawiony PPID=1 to znaczy, że jest bezpośrednim potomkiem procesu `init`.


```sh
$ pstree "$USER"
at-spi-bus-laun─┬─dbus-daemon
                └─3*[{at-spi-bus-laun}]

at-spi2-registr───2*[{at-spi2-registr}]

chrome_crashpad───2*[{chrome_crashpad}]

clock-applet───3*[{clock-applet}]

code─┬─chrome-sandbox───code───code
     ├─code───code─┬─code
     │             └─6*[{code}]
     ├─code───4*[{code}]
     ├─code───20*[{code}]
     ├─code─┬─code───11*[{code}]
     │      └─13*[{code}]
     ├─code───15*[{code}]
     ├─code─┬─code───7*[{code}]
     │      └─14*[{code}]
     └─29*[{code}]
...
```

3. Sprawdzić reakcję procesów działających na pierwszym planie i w tle na wybrane sygnały.
Wykorzystując wbudowane polecenie powłoki trap (man zshbuiltins), zmienić domyślną obsługę sygnału SIGINT w bieżącej powłoce - ustawić ignorowanie sygnału oraz wykonywanie polecenia w reakcji na sygnał. 
Sprawdzić, czy zmieni się obsługa sygnału w nowych procesach uruchamianych przez bieżącą powłokę w obydwu powyższych przypadkach. (1 pkt)

> Sprawdzić reakcję procesów działających na pierwszym planie i w tle na wybrane sygnały.

```sh
usux5@cad10[~/USUX]$ trap SIGINT
usux5@cad10[~/USUX]$ 
usux5@cad10[~/USUX]$ sleep 100
^C
usux5@cad10[~/USUX]$
```

Sygnał SIGINT powoduje zatrzymanie uruchomionego procesu.

> Zmienić domyślną obsługę sygnału SIGINT w bieżącej powłoce - ustawić ignorowanie sygnału. Sprawdzić, czy zmieni się obsługa sygnału w nowych procesach uruchamianych przez bieżącą.

```sh
$ trap '' SIGINT
```

```sh
$ sleep 100     
^C^C
```

```sh
usux5@cad10[~/USUX]$ sleep 1000
^Z
zsh: suspended  sleep 1000
usux5@cad10[~/USUX]$ bg
[1]    continued  sleep 1000
usux5@cad10[~/USUX]$ jobs -l
[1]    28434 running    sleep 1000
usux5@cad10[~/USUX]$ kill -SIGINT 28434
usux5@cad10[~/USUX]$ kill -SIGINT 28434
usux5@cad10[~/USUX]$ jobs -l           
[1]    28434 running    sleep 1000
```

Przestaje działać przesłanie sygnału SIGINT - nie możliwe jest przerwanie procesu uruchomionego w danej powłoce wywołaniem ctrl+c. Podobnie nie działa przesyłanie sygnału SIGINT z innej konsoli.

```sh
usux5@cad10[~]$ sleep 100 &       
[1] 24634
usux5@cad10[~]$ kill -SIGINT 24634
[1]  + interrupt  sleep 100
```

W przypadku procesów uruchomionych w tle dalej jest możliwe przerwanie.

```sh
usux5@cad10[~]$ (trap '' SIGINT; sleep 100) &
[1] 24881
usux5@cad10[~]$ kill -SIGINT 24881
usux5@cad10[~]$ kill -SIGINT 24881
usux5@cad10[~]$ jobs              
[1]  + running    ( trap '' SIGINT; sleep 100; )
usux5@cad10[~]$ ps
  PID TTY          TIME CMD
23709 pts/0    00:00:00 zsh
24881 pts/0    00:00:00 sleep
24914 pts/0    00:00:00 ps
```

Dopiero jeśli w procesie potomnym ustawimy ignorowanie sygnału przestanie działać przesyłanie SIGINT.

> Zmienić domyślną obsługę sygnału SIGINT w bieżącej powłoce - ustawić wykonywanie polecenia w reakcji na sygnał. Sprawdzić, czy zmieni się obsługa sygnału w nowych procesach uruchamianych przez bieżącą.
```sh
$ trap 'echo SIGINT' SIGINT
```

```sh
$ SIGINT
SIGINT
SIGINT
SIGINT
SIGINT

usux5@cad10[~]$ 
```

```sh
$ sleep 10
^C
SIGINT
```

```sh
usux5@cad10[~]$ sleep 1000
^Z
zsh: suspended  sleep 1000
usux5@cad10[~]$ jobs -l
[1]  + 28677 suspended  sleep 1000
usux5@cad10[~]$ bg
[1]  + continued  sleep 1000
usux5@cad10[~]$ jobs -l
[1]  + 28677 running    sleep 1000
usux5@cad10[~]$ kill -SIGINT 28677
[1]  + interrupt  sleep 1000
```

```sh
usux5@cad10[~]$ (trap 'echo test' SIGINT; sleep 10)
^Ctest
usux5@cad10[~]$ (trap 'echo test' SIGINT; sleep 100) &
[1] 25650
usux5@cad10[~]$ kill -SIGINT 25650
usux5@cad10[~]$ kill -SIGINT 25650
usux5@cad10[~]$ kill -SIGINT 25650
usux5@cad10[~]$ fg
[1]  + running    ( trap 'echo test' SIGINT; sleep 100; )
^Ctest
test
test
test

```

```sh
usux5@cad10[~]$ sleep 100
^C
SIGINT
usux5@cad10[~]$
```

```sh                             
usux5@cad10[~]$ trap
trap -- 'echo SIGINT'
usux5@cad10[~]$ sleep 100 &
[1] 25810
usux5@cad10[~]$ kill -SIGINT 25810
[1]  + interrupt  sleep 100                        
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

```sh
$ jobs -l         
[2]  + 25974 suspended (signal)  sleep 2000
[3]    25979 running    sleep 3000
[4]    25985 running    sleep 4000
[5]  - 25990 running    sleep 5000
```
```sh
$ jobs -lr
[3]    25979 running    sleep 3000
[4]    25985 running    sleep 4000
[5]  - 25990 running    sleep 5000
```

> W jaki sposób przenieść proces z pierwszego planu do tła?

```sh
usux5@cad10[~]$ sleep 1000
^Z
zsh: suspended  sleep 1000
usux5@cad10[~]$ jobs
[1]  + suspended  sleep 1000
[2]  - suspended (signal)  sleep 2000
[3]    running    sleep 3000
[4]    running    sleep 4000
[5]    running    sleep 5000
usux5@cad10[~]$ bg %1
[1]    continued  sleep 1000
```

```sh
usux5@cad10[~]$ sleep 6000
^Z
zsh: suspended  sleep 6000
usux5@cad10[~]$ bg
[6]  - continued  sleep 6000
```

Można wcisnąć kombinację `ctrl+z`, aby wysłać do procesu sygnał SIGSTP i przenieść go do tła. Następnie można wywołać `bg`, aby ponownie wystartować proces.

> W jaki sposób przenieść proces z powrotem z tła do pierwszego planu?

```sh
usux5@cad10[~]$ jobs
[1]    running    sleep 1000
[3]    running    sleep 3000
[4]    running    sleep 4000
[5]  - running    sleep 5000
[6]  + running    sleep 6000
usux5@cad10[~]$ fg
[6]  - running    sleep 6000
```

```sh
usux5@cad10[~]$ fg %3
[3]    running    sleep 3000
```

Można wywołać program `fg`, aby przywrócić proces z tła.

5. Uruchomić proces (np. sleep 100) w tle z obniżonym priorytem. 
Następnie zmienić priorytet działającego procesu. 
Obserwować wartości atrybutów: nice i priorytet. 
Czy priorytet można zmieniać dowolnie? (1 pkt)

```sh
usux5@cad10[~]$ nice -10 sleep 1000 &
[1] 26728
usux5@cad10[~]$ ps -o pid,pri,nice,command
  PID PRI  NI COMMAND
26667  19   0 zsh
26728   4  15 sleep 1000
26742  19   0 ps -o pid,pri,nice,command
```

> Następnie zmienić priorytet działającego procesu.

```sh
$ renice -n 9 27328
27328 (ID procesu): stary priorytet 5, nowy priorytet 9
usux5@cad10[~]$ renice -n 5 27328
renice: nie udało się ustawić priorytetu dla 27328 (ID procesu): Brak dostępu
```

> Czy priorytet można zmieniać dowolnie?

```sh
usux5@cad10[~]$ nice 10 sleep 1000&
[2] 26957
usux5@cad10[~]$ : Brak dostępu

[2]  + exit 126   nice 10 sleep 1000
```

```sh
usux5@cad10[~]$ nice -30 sleep 2000 &
[2] 27046
usux5@cad10[~]$ ps -o pid,pri,nice,command
  PID PRI  NI COMMAND
26667  19   0 zsh
26728   4  15 sleep 1000
27046   0  19 sleep 2000
27052  19   0 ps -o pid,pri,nice,command
```

```sh
usux5@cad10[~]$ ps -o pid,pri,nice,command -e
  PID PRI  NI COMMAND
    1  19   0 /usr/lib/systemd/systemd --switched-root --system --deserialize 22
    2  19   0 [kthreadd]
    4  39 -20 [kworker/0:0H]
```

Parametr nice może przyjmować wartości z zakresu jedynie -20-19.
Maksymalną wartością jaką zwykły użytkownik może nadać jest wartość 0.

```sh
usux5@cad10[~]$ sleep 3000 &
[3] 27328
usux5@cad10[~]$ ps -o pid,pri,nice,command   
  PID PRI  NI COMMAND
26667  19   0 zsh
26728   4  15 sleep 1000
27046   0  19 sleep 2000
27328  14   5 sleep 3000
27333  19   0 ps -o pid,pri,nice,command
```

Uruchomienie programu w tle automatycznie ustawia wartość nice na 5.

Zwykły użytkownik może jedynie zwiększać wartość nice (zmniejszać priorytet). Jeśli priorytet zostanie podwyższony, to nie może go przywrócić do poprzedniego stanu.

Administrator ma prawo dowolnie podnosić i obniżać wartość nice.
