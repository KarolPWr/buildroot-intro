# Automatyzacja konfiguracji u-boota

## Przeniesienie u-boot.bin na kartę pamięci

Zmodyfikuj buildroot/board/raspberrypi/post-image.sh

    UBOOT="${BINARIES_DIR}"/u-boot.bin
    FILES+=( "${UBOOT}" )

## Przeniesienie bootscriptu

Przenieś boot_cmd.txt do katalogu buildroot/board/raspberrypi

Zmodyfikuj post-image.sh

    ubootName=`find $BASE_DIR/build -name 'uboot-*' -type d`
    $ubootName/tools/mkimage -A arm64 -O linux -T script -C none -d $BOARD_DIR/boot_cmd.txt $BINARIES_DIR/boot.scr

Dodaj w pętli głównej w post-image.sh:

    BOOTSCRIPT="${BINARIES_DIR}"/boot.scr
    FILES+=( "${BOOTSCRIPT}" )

## Zmiana config.txt

### Zadanie

Musimy wskazać w pliku config.txt że pierwszym programem wykonywalnym będzie u-boot.bin zamiast Image (kernel image)

    sed -i 's/^kernel=Image$/kernel=u-boot.bin/' "${BINARIES_DIR}/rpi-firmware/config.txt"

## Test

Przetestuj zmianę:

    make 2>&1 | tee build.log

- Czy występują problemy przy budowaniu?
- Czy system bootuje się prawidłowo, tzn. u-boot -> kernel -> login prompt? 