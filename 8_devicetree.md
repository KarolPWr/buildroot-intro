# DTO - ręcznie
Zmodyfikuj plik led_overlay.dts

Skompiluj za pomocą: 
    dtc -@ -I dts -O dtb -o ${DTBO_TARGET} ${DTS_SOURCE}


# DTO - w buildroot

Stwórz plik w boards/raspberrypi

    cp led_overlay.dts /home/karol.przybylski/prv/buildroot_rpi/buildroot/board/raspberrypi/overlays

Zmodyfikuj post-build.sh

    # Path to the overlay source and target
    DTS_SOURCE="board/raspberrypi/overlays/led_overlay.dts"
    DTBO_TARGET="${BINARIES_DIR}/rpi-firmware/overlays/led_overlay.dtbo"

    # Compile the device tree overlay
    dtc -@ -I dts -O dtb -o ${DTBO_TARGET} ${DTS_SOURCE}

Zmodyfikuj config.txt

    dtoverlay=led_overlay

Przebuduj (Czy na pewno?)

    make clean && make -j8
    sudo dd if=sdcard.img of=/dev/<SDXXXX>

Zweryfikuj czy pliki są tam gdzie trzeba
The compiled custom-overlay.dtbo is present in the overlays directory in the rpi-firmware folder.
The config.txt includes the dtoverlay=custom-overlay line.