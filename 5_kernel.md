# Konfiguracja kernela

## Pierwsze modyfikacje

    make linux-menuconfig

Zmień następujące parametry:
1. Show caller information on printks 
2. Zmień loglevel debug messages

Użyj szukajki (`/`) 

Zbuduj i przetestuj czy działa. Jaki jest efekt zmian?

## Zapisanie konfiguracji

W tym momencie nie można zapisać configa, bo używamy domyślnego defconfiga.

    make menuconfig

Zmień opcję na custom configuration file dla kernela. Buildroot stworzy ją automatycznie.
Dodaj ścieżkę do zapisu defconfiga

    Hint: podstawą ścieżki jest katalog buildroot/

Sprawdź gdzie została zapisana.

Zaktualizuj:

    make linux-update-defconfig

Stworzy konfigurację jako plik defconfig

## Test

Porównaj log z bootowania kernela z logiem przed modyfikacjami. 

Jakie są różnice? 

Czy jest jakiś wpływ na performance?