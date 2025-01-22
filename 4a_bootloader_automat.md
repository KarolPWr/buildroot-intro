# Automatyzacja konfiguracji u-boota

## Workflow z kontrolą wersji

1. Konto na github.com
2. fork na projekcie buildroot
3. Stworzenie brancha na sforkowanym projekcie (od wybranego brancha/releasu)
4. Wprowadzamy zmiany na branchu w trakcie szkolenia
5. Wystawienie MR (do zmergowania, ładnie widać zmiany wtedy)

## Przeniesienie u-boot.bin na kartę pamięci

Zmodyfikuj buildroot/board/raspberrypi/post-image.sh

    UBOOT="${BINARIES_DIR}"/u-boot.bin
    FILES+=( "${UBOOT}" )

## Przeniesienie bootscriptu

Zmodyfikuj post-image.sh

    ubootName=`find $BASE_DIR/build -name 'uboot-*' -type d`
    $ubootName/tools/mkimage -A arm64 -O linux -T script -C none -d $BOARD_DIR/boot_cmd.txt $BINARIES_DIR/boot.scr

Dodaj w pętli głównej w post-image.sh:

    BOOTSCRIPT="${BINARIES_DIR}"/boot.scr
    FILES+=( "${BOOTSCRIPT}" )

## Zmiana config.txt

Zmodyfikuj config.txt w katalogu boards/, wskaż u-boot jako pierwszy program wykonywalny (tak jak gdy robiliśmy to ręcznie)

## Test

Przetestuj zmianę:

- Czy występują problemy przy budowaniu?
- Czy system bootuje się prawidłowo, tzn. u-boot -> kernel -> login prompt? 