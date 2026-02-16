# CCACHE

Włącz CCACHE w make menuconfig

make menuconfig

    Build options -> Enable compiler cache

# Checklista optymalizacyjna

Czy korzystam z VM?

Czy korzystam z NFS?

Toolchain w wersji external?

Włączone CCACHE? 

Wiem kiedy przebudować projekt? 

Więcej informacji: https://buildroot.org/downloads/manual/manual.html#full-rebuild

## Pre-built ccache
Ściągnij ccache z linku (ok 3 GB):

https://drive.google.com/file/d/1C33ejCUt_5Ez5FH3bgnocEmZvDClXO32/view?usp=sharing

Rozpakuj:

    mkdir -p $HOME/.buildroot-ccache/
    tar -xvzf ccache_backup.tar.gz -C $HOME/ --strip-components=2

Sprawdź czy rozpakowało się poprawnie

    ls -la $HOME/.buildroot-ccache/
   

## Pierwszy build

Budowanie 

    make 2>&1 | tee build.log

Wgranie na kartę SD (poza kontenerem!)

Sprawdż pod jaki DEVICE podłączy się karta pamięci

    dmesg -w
    # Włóż kartę pamięci do slotu
    Na podstawie outputu z dmesg podmień <DEVICE> w komendzie (np. na sda)

    cd workspace/buildroot
    dd if=output/images/sdcard.img of=/dev/<DEVICE> status=progress && sync

## Test na Raspberry 

Włóż kartę SD do slotu na płytce. Obserwuj co wyświetli się na połączeniu szeregowym. Po kilku sekundach pojawią się pierwsze logi.

    login: root