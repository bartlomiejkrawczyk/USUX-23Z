# Użytkowanie systemu UNIX (USUX) - Ćwiczenie 4

## Student
```
Bartłomiej Krawczyk, 310774
```

## Środowisko

1. Zmodyfikować (lub stworzyć) lokalne pliki konfiguracyjne powłoki zsh w celu :
    - dodania do ścieżki poszukiwań katalogu ~/skrypt. (0,5 pkt)
    Wyjaśnić jak sposób wykonania tej modyfikacji wpływa na kolejność przeszukiwania katalogów.
    - dodania aliasa na polecenie wyświetlania listy wszystkich własnych procesów. (0,5 pkt)

> dodania do ścieżki poszukiwań katalogu ~/skrypt
`~/.zshrc`:
```sh
...
export PATH="$PATH:$HOME/skrypt"
```

```sh
[~/skrypt]$ source ~/.zshrc
[~/skrypt]$ nano test.sh
[~/skrypt]$ chmod +x ./test.sh 
[~/skrypt]$ cd ..
[~]$ test.sh
Test
```

> Wyjaśnić jak sposób wykonania tej modyfikacji wpływa na kolejność przeszukiwania katalogów

Katalogi wymienione w zmiennej $PATH są przeszukiwane od lewej do prawej. 

- `$PATH:$HOME/skrypt` - katalog ~/skrypt będzie przeszukiwany na końcu
- `$HOME/skrypt:$PATH` - katalog ~/skrypt będzie przeszukiwany w pierwszej kolejności

W trakcie wywoływania zostanie wykonany pierwszy napotkany program o zadanej nazwie.

> dodania aliasa na polecenie wyświetlania listy wszystkich własnych procesów

`~/.zshrc`:
```sh
...
alias psu='ps -lu "$USER"'
```

```sh
$ source ~/.zshrc
$ psu          
F S   UID   PID  PPID  C PRI  NI ADDR SZ WCHAN  TTY          TIME CMD
1 S  3005 27348     1  0  80   0 - 79439 poll_s ?        00:00:00 gnome-keyring-
4 S  3005 27394 27182  0  80   0 - 142589 poll_s ?       00:00:00 mate-session
1 S  3005 27403     1  0  80   0 - 17397 poll_s ?        00:00:00 dbus-launch
1 S  3005 27404     1  0  80   0 - 20063 ep_pol ?        00:00:00 dbus-daemon
0 S  3005 27427     1  0  80   0 - 97495 poll_s ?        00:00:00 imsettings-dae
```

2. Sprawdzić i zaprezentować podstawową różnicę między zmiennymi środowiska i zmiennymi lokalnymi shella. (1 pkt)

```sh
$ export TEST=var
$ echo $TEST
var
$ env | grep TEST
TEST=var
$ /bin/bash
$ env | grep TEST
TEST=var
$ echo $TEST
var
```

Zmienne środowiskowe:
- są dostępne w obrębie procesu oraz wszystkich jego dzieci

```sh
$ TEST=var
$ env | grep TEST
$ echo $TEST
var
$ /bin/bash
$ env | grep TEST
$ echo $TEST

$ ^D
exit
$ echo $TEST
var
```

Zmienne lokalne shella:
- są dostępne jedynie w obrębie powłoki, w ramach której zostały zdefiniowane

3. Skonstruować polecenie: `ls opcje wzorzec` tak, aby otrzymać informacje tylko o plikach ukrytych z bieżącego katalogu, z wyjątkiem pozycji: . (katalog bieżący) i .. (katalog nadrzędny). (1 pkt)

```sh
$ ls -dA .*
.bash_history  .gconfd          .icons         .ssh
.cache         .gimp-2.6        .lesshst       .themes
.cadence       .gnome2          .libmgr        .thumbnails
.cdsenv        .gnome2_private  .local         .viminfo
.cds_pvsui     .gnote           .mozilla       .vscode
.config        .gnupg           .nautilus      .xsession-errors
.dbus          .gtk-bookmarks   .nv            .xsession-errors.old
.esd_auth      .gtkrc           .pki           .zcompdump
.fontconfig    .gvfs            .pulse         .zshenv
.gconf         .ICEauthority    .pulse-cookie  .zshrc
```

Użyte flagi:
- `-d` - zamiast listować zawartość ukrytego katalogu listowanie nazwy
- `-A` - listowanie także ukrytych plików z wyjątkiem `.` i `..`

Ukryte pliki w linux rozpoczynają się od `.` - wzorzec `.*` pozwala na dopasowanie ukrytych plików.

4. Przedstawić przykłady ilustrujące działanie następujących znaków specjalnych:
" " (cudzysłów),
' ' (apostrof),
` ` (odwrotny apostrof),
\.

Wyjaśnić i zademonstrować jak zastosowanie powyższych znaków wpływa na interpretację znaków $, ` `, *. Wyniki przedstawić w postaci tabeli. (2 pkt)

> Przedstawić przykłady ilustrujące działanie

- cudzysłów - pozwala na grupowanie wyrazów. Tak powstałe wyrażenia są jeszcze rozwijane
```sh
$ VAR="* Current directory for user $USER: `pwd` *"
$ echo $VAR
* Current directory for user usux5: /lab/usux5/USUX *
```

- apostrof - pozwala na grupowanie wyrazów w wyrażenia. Nie prowadzi do rozwijania wyrażeń
```sh
$ echo 'sudo rm -rf $HOME/* && echo `pwd`'                     
sudo rm -rf $HOME/* && echo `pwd`
```

- odwrotny apostrof - pozwala na wywołanie innego programu, a jego rezultat umieszcza w wyrażeniu. Jest tożsame z wywołaniem poprzez `$(command)`
```sh
$ VAR=`echo Current directory for user $USER: \`pwd\`, it contains: *`
$ $ echo $VAR
Current directory for user usux5: /lab/usux5/USUX, it contains: lab_01 lab_02 lab_03 lab_04 lab_05
```

- backslash - zapobiega ewaluacji znaku następnego
```sh
$ echo *
README.md
$ echo \* \$ \`
* $ `
```

Ewaluacja | \$             | \` \`                                                          | \*
----------|----------------|----------------------------------------------------------------|-------------------------------------------
" "       | znak specjalny | wyrażenie wewnątrz jest interpretowane                         | znak gwiazdki \*
' '       | znak dolara \$ | wyrażenie nie interpretowane                                   | znak gwiazdki \*
\` \`     | znak specjalny | jeśli escapowany \\ to wewnętrzne wyrażenie też interpretowane | wildcard - dopasowuje dowolny ciąg symboli
\\        | znak dolara \$ | back tick \`                                                   | znak gwiazdki \*
