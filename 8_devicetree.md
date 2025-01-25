# DTO - ręcznie

Stwórz nowy katalog w workspace/

    cd workspace
    mkdir overlay

Skopiuj szablon overlaya:

    cp devicetree/overlay_template.dts <SCIEZKA>/workspace

Wypełnij pola oznaczone symbolami XXX. 

Skorzystaj z dokumentacji: 

https://github.com/raspberrypi/linux/blob/rpi-6.6.y/Documentation/devicetree/bindings/leds/common.yaml 

Oraz przykładów overlayów od Raspberry Pi Foundation:

https://github.com/raspberrypi/linux/tree/rpi-6.6.y/arch/arm/boot/dts/overlays


Skompiluj za pomocą: 

    dtc -@ -I dts -O dtb -o ${DTBO_TARGET} ${DTS_SOURCE}


# DTO - w buildroot

Wracamy do Buildroota

Przenieś plik do boards/raspberrypi

    cp led_overlay.dts buildroot/board/raspberrypi/overlays

Zmodyfikuj post-build.sh

    # Sciezki do overlayów
    DTS_SOURCE="board/raspberrypi/overlays/led_overlay.dts"
    DTBO_TARGET="${BINARIES_DIR}/rpi-firmware/overlays/led_overlay.dtbo"

    # Kompilacja overlaya
    dtc -@ -I dts -O dtb -o ${DTBO_TARGET} ${DTS_SOURCE}

Zmodyfikuj config.txt dla platformy

    dtoverlay=led_overlay

Przebuduj

    make
    sudo dd if=sdcard.img of=/dev/<SDXXXX>

Zweryfikuj czy pliki są tam gdzie trzeba:

- Nasz nowy, skompilowany overlay jest w katalogu overlays w folderze rpi-firmware

- config.txt zawiera odpowiednią linijkę:

        dtoverlay=custom-overlay line.

- Zaprogramuj płytkę, obserwuj czy działa tak jak powinna.