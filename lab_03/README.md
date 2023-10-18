# Użytkowanie systemu UNIX (USUX) - Ćwiczenie 3

## Procesy i sygnały

1. Za pomocą polecenia ps obejrzeć listę procesów z bieżącej sesji
i zidentyfikować ich atrybuty (zwrócić uwagę na priorytet i wartość nice). (1 pkt)


2. Obejrzeć listę wszystkich procesów w systemie.
Zidentyfikować własne procesy i narysować drzewo dziedziczenia
od procesu o identyfikatorze PID=1 do tych procesów.
Zwrócić uwagę na stan poszczególnych procesów. (1 pkt)



3. Sprawdzić reakcję procesów działających na pierwszym planie i w tle na wybrane sygnały. 
Wykorzystując wbudowane polecenie powłoki trap (man zshbuiltins),
zmienić domyślną obsługę sygnału SIGINT w bieżącej powłoce
- ustawić ignorowanie sygnału oraz wykonywanie polecenia w reakcji na sygnał. 
Sprawdzić, czy zmieni się obsluga sygnału w nowych procesach uruchamianych przez bieżącą powłokę
w obydwu powyższych przypadkach. (1 pkt)



4. Uruchomić kilka prac (np. polecenie sleep n)
i sprawdzić działanie poleceń `jobs`, `fg`, `bg` wykorzystując różne argumenty. 
W jaki sposób przenieść proces z pierwszego planu do tła i z powrotem ? (1 pkt)


Ctrl+z / fg

5. Uruchomić proces (np. sleep 100) w tle z obniżonym priorytem. 
Następnie zmienić priorytet działającego procesu. 
Obserwować wartości atrybutów: nice i priorytet. 
Czy priorytet można zmieniać dowolnie? (1 pkt)



