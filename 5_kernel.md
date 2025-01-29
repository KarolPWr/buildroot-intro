# Konfiguracja kernela

## Pierwsze modyfikacje

    make linux-menuconfig

Zmień następujące parametry:
1. Show caller information on printks 
2. Zmień Default console loglevel na poziom 15

Użyj szukajki (`/`) 

## Zapisanie konfiguracji

W tym momencie nie można zapisać configa, bo używamy domyślnego defconfiga. Buildroot nie zna ścieżki zapisu.

Wywołaj:

    make menuconfig

Następnie w menu

    Kernel -> Kernel configuration file -> Using custom (def)config file

i uzupełnij `Configuration file path` o nazwę pliku (wybierz samodzielnie, np my_config)

Zaktualizuj konfigurację:

    make linux-update-defconfig

Sprawdź czy plik został stworzony i czy nie jest pusty.

## Test

Porównaj log z bootowania kernela z logiem przed modyfikacjami. 

Jakie są różnice? 

Czy jest jakiś wpływ na performance (czas bootowania)?