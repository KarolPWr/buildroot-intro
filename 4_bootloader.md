# Konfiguracja u-boota w Buildroocie

    make menuconfig
    menu Bootloaders -> u-boot 

## Dodanie konfiguracji

    Board defconfig -> rpi_4 

Zbuduj nowe komponenty

    make 2>&1 | tee build.log

## Test

Sprawdź jakie nowe pliki pojawiły się w output/

Wgraj nowy obraz na Raspberry - co się dzieje po boocie?

## Modyfikacja config.txt 

Przenieś plik u-boot.bin na boot partycję

Uwaga: partycja może również pokazać się jako numeryczne UUID np. 6EBC-CFB7

SCIEZKA to ścieżka do zamontowanej partycji z plikami do bootowania, zazwyczaj w /media

    cp u-boot.bin <SCIEZKA>/<NUMER>

Zmodyfikuj plik config.txt na partycji bootfs

    kernel=u-boot.bin

## Komendy w u-boot

    fatload mmc 0:1 ${kernel_addr_r} Image
    setenv bootargs root=/dev/mmcblk0p2 rootwait console=tty1 console=ttyAMA0,115200
    booti ${kernel_addr_r} - ${fdtcontroladdr}

## Bootscripts

    cd workspace/
    vim boot_cmd.txt # przepisujemy to co u góry
    buildroot/output/build/uboot-2024.10/tools/mkimage -A arm64 -O linux -T script -C none -d boot_cmd.txt boot.scr
    cp boot.scr <karta_sd>/bootfs && sync

Jak to zautomatyzować?
