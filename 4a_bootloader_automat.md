# Automatyzacja konfiguracji u-boota

## Przeniesienie u-boot.bin na kartę pamięci

Zmodyfikuj buildroot/board/raspberrypi/post-image.sh
**[Dodaj po pętli FOR]**

    UBOOT="${BINARIES_DIR}"/u-boot.bin
    FILES+=( "${UBOOT}" )

## Przeniesienie bootscriptu

Przenieś boot_cmd.txt do katalogu buildroot/board/raspberrypi

### Zadanie

Zmodyfikuj post-image.sh

Musimy w skrypcie znaleźć narzędzie do budowania bootscriptów (mkimage) i następnie go użyć.

Jedna z możliwych metod jest zaimplementowana w repozytorium rockchipa: https://github.com/flatmax/buildroot.rockchip/blob/master/board/RK3308/post-image.sh 

Spróbuj użyć tego pliku jako inspiracji.

### Dodanie bootscriptu do listy plików

Dodaj poniżej definicji zmiennej FILES=() w post-image.sh:

    BOOTSCRIPT="${BINARIES_DIR}"/boot.scr
    FILES+=( "${BOOTSCRIPT}" )

## Zmiana config.txt

### Zadanie

Musimy wskazać w pliku config.txt że pierwszym programem wykonywalnym będzie u-boot.bin zamiast Image (kernel image)

Dodaj poniższą linijkę do post-image.sh:

    sed -i 's/^kernel=Image$/kernel=u-boot.bin/' "${BINARIES_DIR}/rpi-firmware/config.txt"

Zwróć również uwagę na zmienną KERNEL. W jaki sposób jest ustalana i czy wymaga zmiany?

## Test

Przetestuj zmianę:

    make 2>&1 | tee build.log

- Czy występują problemy przy budowaniu?
- Czy system bootuje się prawidłowo, tzn. u-boot -> kernel -> login prompt? 