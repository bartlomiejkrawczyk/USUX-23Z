# Użytkowanie systemu UNIX (USUX) - Ćwiczenie 8

## Student
```md
Bartłomiej Krawczyk, 310774
```

## Narzędzia programistyczne

1. Wykorzystując kompilator `gcc` wykonać następujące czynności:
    - przenieść prywatne pliki nagłówkowe (`*.h`) do innego katalogu niż pliki źródłowe `*.c`,
    - skompilować wszystkie pliki źródłowe i utworzyć z nich program wynikowy o nazwie `prog`,
    - porównać rozmiar pliku wynikowego otrzymanego po kompilacji z włączoną i wyłączoną optymalizacją,
    - znaleźć w kodzie źródłowym makro sterujące procesem prekompilacji i wykorzystując odpowiednią opcję programu `gcc` wykonać punkt 1b w dwóch wersjach.

> przenieść prywatne pliki nagłówkowe (`*.h`) do innego katalogu niż pliki źródłowe `*.c`,
```sh
$ tar -xaf przyklad2.tar.gz
$ mkdir include
$ mkdir src
$ mv p2/*.h include/
$ mv p2/*.c src/
```

```sh
$ tree
.
├── README.md
├── include
│   ├── fun.h
│   └── rkw.h
└── src
    └── p2
        ├── delta.c
        ├── pierw.c
        └── rkw.c
```

> skompilować wszystkie pliki źródłowe i utworzyć z nich program wynikowy o nazwie `prog`,

```sh
$ gcc src/*.c -Iinclude -Wall -Wextra -pedantic -Werror -lm -o prog
```

```sh
$ ./prog 1 -2 1
x1 = 1.000000
x2 = 1.000000
```

> porównać rozmiar pliku wynikowego otrzymanego po kompilacji z włączoną i wyłączoną optymalizacją,

```sh
$ gcc src/*.c -O0 -Iinclude -Wall -Wextra -pedantic -Werror -lm -o prog
$ ls -la prog
-rwxr-xr-x 1 bartlomiejkrawczyk bartlomiejkrawczyk 16312 Nov 16 13:12 prog
$ gcc src/*.c -O3 -Iinclude -Wall -Wextra -pedantic -Werror -lm -o prog
$ ls -la prog
-rwxr-xr-x 1 bartlomiejkrawczyk bartlomiejkrawczyk 16312 Nov 16 13:13 prog
```

> znaleźć w kodzie źródłowym makro sterujące procesem prekompilacji i wykorzystując odpowiednią opcję programu `gcc` wykonać punkt 1b w dwóch wersjach

```sh
$ gcc -DZESPOLONE src/*.c -Iinclude -Wall -Wextra -pedantic -Werror  -lm -o prog
$ ./prog 1 1 1
x1 = -0.500000 + -0.866025j
x2 = -0.500000 + 0.866025j
```

```sh
$ gcc -UZESPOLONE src/*.c -Iinclude -Wall -Wextra -pedantic -Werror  -lm -o prog
$ ./prog 1 1 1
Brak pierwiastkow rzeczywistych.
```

2. Posługując się programem `ar` wykonać operacje:
    - zbudować własną bibliotekę statyczną `libusux.a` z wybranych plików obiektowych,
    - wykorzystać stworzoną bibliotekę do utworzenia tego samego programu co w punkcie 1b.

> zbudować własną bibliotekę statyczną `libusux.a` z wybranych plików obiektowych,
```sh
$ gcc -c src/delta.c src/pierw.c -Iinclude
$ ar -rv libusux.a delta.o pierw.o
```

> wykorzystać stworzoną bibliotekę do utworzenia tego samego programu co w punkcie 1b.
```sh
$ gcc src/rkw.c libusux.a -Iinclude -lm -o prog_libusux_a
```

3. Posługując się programem `gcc` wykonać operacje:
    - zbudować własną bibliotekę dzieloną (dynamiczną) `libusux.so` z wybranych plików obiektowych,
    - wykorzystać stworzoną bibliotekę do utworzenia tego samego programu co w punkcie 1b.
    - zmodyfikować ścieżkę poszukiwań bibliotek, aby umożliwić wykonywanie programu.

> zbudować własną bibliotekę dzieloną (dynamiczną) `libusux.so` z wybranych plików obiektowych,

<!-- flagą pic (position independent code) -->
```sh
$ gcc -c -fpic src/delta.c src/pierw.c
$ gcc -shared *.o -o libusux.so
```

> wykorzystać stworzoną bibliotekę do utworzenia tego samego programu co w punkcie 1b.

```sh
$ gcc src/rkw.c -L. -Iinc -lm -lusux -o prog_libusux_so
```

> zmodyfikować ścieżkę poszukiwań bibliotek, aby umożliwić wykonywanie programu.

```sh
$ export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$(pwd)
```

```sh
$ ./prog_libusux_so 1 -3 1
x1 = 0.381966
x2 = 2.618034
```

4. Obejrzeć tablicę symboli programu `prog` i biblioteki `libusux.a`. Usunąć tablicę symboli z obu tych plików. Sprawdzić działanie programu po usunięciu tablicy symboli. Powtórzyć punkt 2b i wytłumaczyć ewentualne różnice w działaniu kompilatora.

> Obejrzeć tablicę symboli programu `prog` i biblioteki `libusux.a`

```sh
$ nm prog
TODO
$ nm libusux.a
TODO
```

> Usunąć tablicę symboli z obu tych plików.

```sh
$ strip prog
$ strip libusux.a
```

> Powtórzyć punkt 2b i wytłumaczyć ewentualne różnice w działaniu kompilatora.

TODO

Kompilacja bez tablicy symboli jest nie możliwa.

5. Używając programów `gcc` i `gdb` wykonać następujące polecenia:
    - stworzyć program `prog` w taki sposób by umożliwić śledzenie jego pracy za pomocą `gdb`,
    - obejrzeć kod źródłowy przy pomocy `gdb`, wybrać miejsca dla kilku pułapek i je ustawić,
    - używając odpowiedniego polecenia programu `gdb` podać argumenty wywołania programu,
    - ustawić tryb śledzenia dla wybranej zmiennej,
    - uruchomić program,
    - w trakcie krokowego wykonywania programu zmienić wartość zmiennej z punktu 4d.

> stworzyć program `prog` w taki sposób by umożliwić śledzenie jego pracy za pomocą `gdb`,

```sh
$ gcc src/*.c -Iinclude -Wall -Wextra -pedantic -Werror -ggdb -lm -o prog
```
-ggdb lub -g


> obejrzeć kod źródłowy przy pomocy `gdb`, wybrać miejsca dla kilku pułapek i je ustawić,

```sh
$ gdb prog
(gdb) set listsize 1000
(gdb) list
1       #include "rkw.h"
2
3       int main(int argc, char* argv[])
4       {
5               double a, b, c, delta;
6               double x1, x2;
7       #ifdef ZESPOLONE
8               double *x1z, *x2z;
9       #endif
10
11              if (argc != 4)
12              {
13                      printf("Poprawna skladnia:\t%s a b c\n", argv[0]);
14                      exit(1);
15              }
...
(gdb) break 16
Breakpoint 1 at 0x1333: file src/rkw.c, line 16.
(gdb) break 19
Breakpoint 2 at 0x13a5: file src/rkw.c, line 19.
```

> używając odpowiedniego polecenia programu `gdb` podać argumenty wywołania programu,

```sh
(gdb) set args 1 -3 1
(gdb) show args
Argument list to give program being debugged when it is started is "1 -3 1".
```

> uruchomić program,

```sh
(gdb) run
Starting program: /home/bartlomiejkrawczyk/USUX/lab_08/prog 1 -3 1
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".

Breakpoint 1, main (argc=4, argv=0x7fffffffd648) at src/rkw.c:16
16              sscanf(argv[1], "%lf", &a);
```

> ustawić tryb śledzenia dla wybranej zmiennej,

```sh
(gdb) watch x1
Hardware watchpoint 3: x1
(gdb) next

Breakpoint 2, main (argc=4, argv=0x7fffffffd648) at src/rkw.c:19
19              delta = Delta(a, b, c);
(gdb) 
20              if (delta >= 0)
(gdb) 
22                      x1 = Pierw(a, b, delta, 1);
(gdb) 

Hardware watchpoint 3: x1

Old value = 4.9406564584124654e-322
New value = 0.3819660112501051
main (argc=4, argv=0x7fffffffd648) at src/rkw.c:23
23                      x2 = Pierw(a, b, delta, 2);

```

> w trakcie krokowego wykonywania programu zmienić wartość zmiennej z punktu 4d.

```sh
(gdb) set variable x1 = -1
(gdb) next
24                      printf("x1 = %lf\nx2 = %lf\n", x1, x2);
(gdb) 
x1 = -1.000000
x2 = 2.618034
```