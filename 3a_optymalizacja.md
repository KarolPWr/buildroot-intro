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

Flashowanie

- Podłączony kabel micro usb do komputera
- Jumper J2 w pozycji disable emmc boot
- Power ON 
- Wywołujemy polecenie: `sudo rpiboot`

Powinniśmy zobaczyć taki log:

    RPIBOOT: build-date Jan 31 2022 version 0~20220315+git6fa2ec0+nowin-0ubuntu1 
    Waiting for BCM2835/6/7/2711...
    Loading embedded: bootcode4.bin
    Sending bootcode.bin
    Successful read 4 bytes 
    Waiting for BCM2835/6/7/2711...
    Loading embedded: bootcode4.bin
    Second stage boot server
    Loading embedded: start4.elf
    File read: start4.elf
    Second stage boot server done

Uwaga: dmesg i dd wykonujemy poza kontenerem.

Sprawdzamy przez 

    dmesg

Pod jaki device podłączyła się nasza pamięć

Przerzucamy obraz:

    dd status=progress if=output/images/sdcard.img of=/dev/<DEVICE> && sync

- Power OFF
- Zdejmujemy jumper J2
- Power ON

## Test na Raspberry 

Obserwuj co wyświetli się na połączeniu szeregowym. Po kilku sekundach pojawią się pierwsze logi.

    login: root