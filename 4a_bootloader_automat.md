# Automatyzacja konfiguracji u-boota

## Przeniesienie u-boot.bin na kartę pamięci

Zmodyfikuj buildroot/board/raspberrypi/post-image.sh

    UBOOT="${BINARIES_DIR}"/u-boot.bin
    FILES+=( "${UBOOT}" )

## Przeniesienie bootscriptu

Przenieś boot_cmd.txt do katalogu boards/<PLATFORMA>

### Zadanie

Zmodyfikuj post-image.sh

Musimy w skrypcie znaleźć narzędzie do budowania bootscriptów (mkimage) i następnie go użyć.

Jedna z możliwych metod jest zaimplementowana w repozytorium rockchipa: https://github.com/flatmax/buildroot.rockchip/blob/master/board/RK3308/post-image.sh 

Spróbuj użyć tego pliku jako inspiracji.

### Dodanie bootscriptu do listy plików

Dodaj w pętli głównej w post-image.sh:

    BOOTSCRIPT="${BINARIES_DIR}"/boot.scr
    FILES+=( "${BOOTSCRIPT}" )

## Zmiana config.txt

Zmodyfikuj config.txt w katalogu boards/, wskaż u-boot jako pierwszy program wykonywalny (tak jak gdy robiliśmy to ręcznie)

### Zadanie

Musimy wskazać w pliku config.txt że pierwszym programem wykonywalnym będzie u-boot.bin zamiast Image (kernel image)

Jak to zrobić?

## Test

Przetestuj zmianę:

    make 2>&1 | tee build.log

- Czy występują problemy przy budowaniu?
- Czy system bootuje się prawidłowo, tzn. u-boot -> kernel -> login prompt? 