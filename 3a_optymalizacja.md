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

## Pierwszy build

Budowanie 

    make 2>&1 | tee build.log

Wgranie na kartę SD

    dd if=output/images/sdcard.img of=/dev/<DEVICE> && sync

## Test na Raspberry 

Włóż kartę SD do slotu na płytce. Obserwuj co wyświetli się na połączeniu szeregowym. Po kilku sekundach pojawią się pierwsze logi.

    login: root