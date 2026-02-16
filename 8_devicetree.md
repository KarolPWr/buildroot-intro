# Podłączenie diody LED

Stwórz prosty układ z płytki stykowej, rezystora i diody LED. 

GPIO -> Rezystor -> LED -> GND

W podobny sposób jak tutaj:

https://cdn.shopify.com/s/files/1/0176/3274/files/raspberry_pi_led_breadboard_circuit.jpg?v=1683712372

Użyj pinoutu dla Raspberry Pi:

https://www.raspberrypi.com/documentation/computers/raspberry-pi.html


# DTO - ręcznie

Stwórz nowy katalog w workspace/

    cd workspace
    mkdir overlay && cd overlay

Skopiuj szablon overlaya z tego repozytorium:

    cp <SCIEZKA DO REPO>/devicetree/overlay_template.dts <SCIEZKA>/workspace

Wypełnij pola oznaczone symbolami XXX. 

Skorzystaj z dokumentacji: 

https://github.com/raspberrypi/linux/blob/rpi-6.6.y/Documentation/devicetree/bindings/leds/common.yaml 

Oraz przykładów overlayów od Raspberry Pi Foundation:

https://github.com/raspberrypi/linux/tree/rpi-6.6.y/arch/arm/boot/dts/overlays


Skompiluj za pomocą (zmienne trzeba podmienić na pliki): 

    dtc -@ -I dts -O dtb -o ${DTBO_TARGET} ${DTS_SOURCE}


# DTO - w buildroot

Wracamy do Buildroota

Przenieś plik do boards/raspberrypi

    mkdir buildroot/board/raspberrypi/overlays
    cp led_overlay.dts buildroot/board/raspberrypi/overlays

Zmodyfikuj post-build.sh

    # Sciezki do overlayów
    DTS_SOURCE="board/raspberrypi/overlays/led_overlay.dts"
    DTBO_TARGET="${BINARIES_DIR}/rpi-firmware/overlays/led_overlay.dtbo"

    # Kompilacja overlaya
    dtc -@ -I dts -O dtb -o ${DTBO_TARGET} ${DTS_SOURCE}

Zmodyfikuj config.txt dla platformy, dodaj linijkę:

    echo "dtoverlay=led_overlay" >> "${BINARIES_DIR}"/rpi-firmware/config.txt

do skryptu post-build.sh

Przebuduj

    make
    sudo dd if=sdcard.img of=/dev/<SDXXXX>

Zweryfikuj czy pliki są tam gdzie trzeba:

- Nasz nowy, skompilowany overlay jest w katalogu overlays w folderze rpi-firmware

- config.txt zawiera odpowiednią linijkę:

        dtoverlay=led_overlay

- Zaprogramuj płytkę, obserwuj czy działa tak jak powinna.

## Sprawdzanie DT w runtime

Wpisy dotyczące devicetree pojawiają się w /sys/firmware 

    cat /sys/firmware/devicetree/base/leds@1/led/label