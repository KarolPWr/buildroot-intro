# Toolchain

## crosstool-ng - full external

Ściąganie źródeł

    cd workspace/
    git clone https://github.com/crosstool-ng/crosstool-ng
    cd crosstool-ng/
    git checkout -b my_crosstool tags/crosstool-ng-1.28.0

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

## Zadanie

Za pomocą 

    ./ct-ng menuconfig

Znajdź i zmień parametr:

    Wersja glibc: 2.39

Sprawdź czy wszystko się zgadza za pomocą komendy:

    ./ct-ng show-config

## Tip: nawigacja w menuconfig

SPACJA - zaznaczamy wybór opcji

[ ] - pustka, czyli nie jest włączone (enabled)

[*] - opcja zostanie zbudowana/włączona

/ - szukanie

(1) - po naciśnięciu numeru przy wyniku wyszukiwania, menuconfig nas tam przeniesie

## Opcjonalnie - Budowanie
Toolchain można zbudować za pomocą komendy:

    ./ct-ng build

Proces budowania zajmie około 30 minut

# Ustawienie pre-built toolchain

Ustaw lepszy mirror:

    make menuconfig # Wejście do menu konfiguracyjnego
    Build options -> Mirrors and download location -> Wpisz https://ftp.gnu.org/gnu w primary download site

Zmiana toolchaina na prebuilt

    Toolchain type -> External toolchain
    Toolchain -> Arm AArch64 13.3.rel1
    Toolchain origin (Toolchain to be downloaded and installed)

## Budowanie

W kolejnym ćwiczeniu
    
    



# Opcjonalnie - Ustawienie external toolchaina

Przejdź do katalogu gdzie są źródła Buildroota

    cd workspace/buildroot/

Wybierz w make menuconfig -> Custom toolchain w menu Toolchain

    Toolchain type -> External toolchain
    Toolchain (Custom toolchain)

Trzeba wypełnić:

- toolchain path:

    <SCIEZKA DO WORKSPACE>/crosstool-ng/x-tools/aarch64-rpi4-linux-gnu

lub jeśli korzystasz ze ściągniętego x-tools:

    <SCIEZKA DO WORKSPACE>/x-tools/aarch64-rpi4-linux-gnu

- toolchain prefix:

    aarch64-rpi4-linux-gnu

- C library options:

    gcc version: 14.x

    kernel headers: 6.11.x 

    C library: glibc

    brak RPC support

    istnieje C++ support




