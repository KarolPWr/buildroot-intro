# Podstawy Buildroota - pierwsza kompilacja

Ściągnij repo Buildroota:

    git clone https://git.buildroot.org/buildroot 
    cd buildroot
    git checkout -b my_root origin/2024.11.x

Lista wszystkich defconfigów:

    make list-defconfigs

### Zadanie 
Wylistuj defconfigi dla Raspberry Pi 

## Defconfigs

Wpisanie defconfiga:

    make raspberrypi4_64_defconfig

Budowanie 

    make 2>&1 | tee build.log

Wgranie na kartę SD

    dd if=output/images/sdcard.img of=/dev/<DEVICE> && sync

## Test na Raspberry 

Włóż kartę SD do slotu na płytce. Obserwuj co wyświetli się na połączeniu szeregowym. Po kilku sekundach pojawią się pierwsze logi.

login: root



