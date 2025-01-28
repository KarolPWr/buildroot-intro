
# Sciezki do overlayów
DTS_SOURCE="board/raspberrypi/overlays/led_overlay.dts"
DTBO_TARGET="${BINARIES_DIR}/rpi-firmware/overlays/led_overlay.dtbo"

# Kompilacja overlaya
dtc -@ -I dts -O dtb -o ${DTBO_TARGET} ${DTS_SOURCE}

echo "dtoverlay=led_overlay" >> "${BINARIES_DIR}"/rpi-firmware/config.txt