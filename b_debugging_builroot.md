# Debugowanie

## Make tips

Wyświetl komendy wykonywane przez make: 

    $ make V=1 <target>

Wyświetl wszystkie defconfigi: 

    $ make list-defconfigs

Wyświetl wszystkie możliwe targety: 

    $ make help
    make show-targets

"delete all build products (including build directories, host, staging and target trees, the images and the toolchain)":

    make clean

Nuke (czyszczenie build products i konfiguracji):

    make distclean

Dumping the internal make variables: One can dump the variables known to make, along with their values:

    make -s printvars VARS='VARIABLE1 VARIABLE2'

### Drukowanie wartości zmiennych

    make -s printvars VARS='VARIABLE1 VARIABLE2'

# Zadanie

Sprawdź wartość TARGET_DIR i dowolnej innej zmiennej

### Informacje o paczkach

Sprawdź działanie komend:

    make show-info
oraz
    make pkg-stats
oraz

### Zależności między paczkami

    make graph-depends
    make <pkg> graph-depends

### Sprawdzanie która paczka ile się buduje

    make graph-depends

### Ile zajmują paczki w rootfs

    make graph-size

### Porównanie rozmiarów dwóch dystrybucji (na bazie plików .csv)

    utils/size-stats-compare -h

## Instrumentation scripts

    make BR2_INSTRUMENTATION_SCRIPTS="/path/to/my/script1 /path/to/my/script2"

## Zadanie dodatkowe

Napisz skrypt, który wykona się przed i po każdym kroku budowania danej paczki

Więcej informacji: https://buildroot.org/downloads/manual/manual.html#debugging-buildroot 

## Logowanie

    make 2>&1 | tee build.log
    klogg build.log