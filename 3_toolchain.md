# Toolchain

## Konfiguracja

    cd buildroot
    make menuconfig

Poruszamy się w menuconfigu.

    Toolchain -> Toolchain Type -> External 

Konfiguracja Toolchaina

    menu Toolchain

## crosstool-ng - full external

Ściąganie źródeł

    cd workspace/
    git clone https://github.com/crosstool-ng/crosstool-ng
    cd crosstool-ng/

Konfiguracja środowiska

    ./bootstrap
    ./configure --enable-local

Kompilacja wstępna

    make

Sprawdzenie konfiguracji

    ./ct-ng list-samples | grep -i rpi
    ./ct-ng show-aarch64-rpi4-linux-gnu

Wpisanie configa

    ./ct-ng aarch64-rpi4-linux-gnu

Zmiana ścieżki gdzie będzie zbudowany toolchain

    sed -i '/^CT_PREFIX_DIR=/s/.*/CT_PREFIX_DIR="${CT_PREFIX:-${PWD}\/x-tools}\/${CT_HOST:+HOST-${CT_HOST}\/}${CT_TARGET}"/' .config

## Zadanie

Za pomocą 

    ./ct-ng menuconfig

Znajdź i zmień parametr:

    Wersja glibc: 2.39

Sprawdź czy wszystko się zgadza za pomocą komendy:

    ./ct-ng show-config

## Tip: nawigacja w menuconfig

/ - szukanie

(1) - po naciśnięciu numeru przy wyniku wyszukiwania, menuconfig nas tam przeniesie

## Budowanie
Toolchain można zbudować za pomocą komendy:

    ./ct-ng build

Proces budowania zajmie około 20 minut
    
    
## Ustawienie external toolchaina w menu Buildroota (praca grupowa)

Przejdź do katalogu gdzie są źródła Buildroota

    cd buildroot/

Wybierz w make menuconfig Custom toolchain w menu Toolchain

    Toolchain type -> External toolchain
    Tolchain (Custom toolchain)

Trzeba wypełnić:

- toolchain path:

    <SCIEZKA>/crosstool-ng/x-tools/aarch64-rpi4-linux-gnu

- toolchain prefix:

    aarch64-rpi4-linux-gnu

- C library options:

gcc version: 14.x

kernel headers: 6.x 

C library: glibc

brak RPC support

istnieje C++ support

## Budowanie

    make 2>&1 | tee build.log

Test na targecie (wgranie softu na kartę SD, sprawdzenie seriala)


