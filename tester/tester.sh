#!/bin/bash
# Embedded Linux with Buildroot - Training Exercises Script

set -e  # Exit immediately if a command exits with a non-zero status.

USE_CROSSTOOL=0

# Helper function to use utils/config
# Usage: br_config --enable/--disable/--set-str/--set-val KEY [VALUE]
br_config() {
    ./utils/config --file .config "$@"
}

# --- Configuration ---
WORKSPACE_DIR="$(pwd)"
BUILDROOT_DIR="${WORKSPACE_DIR}/buildroot"
CT_NG_DIR="${WORKSPACE_DIR}/crosstool-ng"
REFBOARD_DIR="${WORKSPACE_DIR}/refboard"
ROOT_PASSWORD="1234"

echo "=== Starting Buildroot Training Exercises ==="
echo "Current directory: ${WORKSPACE_DIR}"

# # ==========================================
# # 1. Container Setup (1_container.md)
# # ==========================================
# # Assuming execution inside the container (workspace/).

# # ==========================================
# # 2. Buildroot Basics (2_buildroot_podstawy.md)
# # ==========================================
# echo "--- Exercise 2: Setting up Buildroot ---"

if [ ! -d "${BUILDROOT_DIR}" ]; then
    git clone https://gitlab.com/buildroot.org/buildroot.git "${BUILDROOT_DIR}"

    cd "${BUILDROOT_DIR}"
    # Using master as fallback or specific version if known (training docs mention 2025.11, using master for now)
    echo "Checking out stable branch..."
    git checkout -b my_root origin/2024.11.x

    echo "Listing defconfigs for Raspberry Pi..."
    make list-defconfigs | grep raspberrypi

    echo "Applying Raspberry Pi 4 64-bit defconfig..."
    make raspberrypi4_64_defconfig
fi

# ==========================================
# 3. Toolchain (3_toolchain.md)
# ==========================================

echo "--- Exercise 3: Crosstool-NG Toolchain ---"

# cd "${WORKSPACE_DIR}"
# if [ ! -d "${CT_NG_DIR}" ]; then
#     git clone https://github.com/crosstool-ng/crosstool-ng "${CT_NG_DIR}"

#     cd "${CT_NG_DIR}"
#     echo "Checking out stable branch..."
#     git checkout -b my_crosstool tags/crosstool-ng-1.28.0
#     if [ ! -f "./ct-ng" ]; then
#         ./bootstrap
#         ./configure --enable-local
#         make
#     fi

#     # Configure for RPi4
#     ./ct-ng aarch64-rpi4-linux-gnu

#     # Fix CT_PREFIX_DIR path to be absolute in the container
#     #sed -i '/^CT_PREFIX_DIR=/s/.*/CT_PREFIX_DIR="${CT_PREFIX:-${PWD}\/x-tools}\/${CT_HOST:+HOST-${CT_HOST}\/}${CT_TARGET}"/' .config

#     echo "Building toolchain (This may take ~30+ minutes)..."
#     ./ct-ng build || echo "Toolchain build failed or already exists. Continuing..."
# fi

cd "${BUILDROOT_DIR}"
if [ "${USE_CROSSTOOL}" -ne 0 ]; then
    # --- Configure Buildroot to use External Toolchain ---
    echo "Configuring Buildroot to use the external toolchain using utils/config..."

    # TOOLCHAIN CONFIG
    # ❯ ./ct-ng show-aarch64-rpi4-linux-gnu
    # [L...]   aarch64-rpi4-linux-gnu
    #     Languages       : C,C++
    #     OS              : linux-6.16
    #     Binutils        : binutils-2.45
    #     Compiler        : gcc-15.2.0
    #     Linkers         :
    #     C library       : glibc-2.42
    #     Debug tools     : gdb-16.3
    #     Companion libs  : expat-2.7.1 gettext-0.26 gmp-6.3.0 isl-0.27 libiconv-1.18 mpc-1.3.1 mpfr-4.2.2 ncurses-6.5 zlib-1.3.1 zstd-1.5.7
    #     Companion tools :


    br_config --enable BR2_TOOLCHAIN_EXTERNAL
    br_config --enable BR2_TOOLCHAIN_EXTERNAL_CUSTOM
    br_config --set-str BR2_TOOLCHAIN_EXTERNAL_PATH "${CT_NG_DIR}/x-tools/aarch64-rpi4-linux-gnu"
    br_config --set-str BR2_TOOLCHAIN_EXTERNAL_CUSTOM_PREFIX "aarch64-rpi4-linux-gnu"
    br_config --enable BR2_TOOLCHAIN_EXTERNAL_GCC_15
    br_config --enable BR2_TOOLCHAIN_EXTERNAL_HEADERS_6_11
    br_config --enable BR2_TOOLCHAIN_EXTERNAL_GLIBC
    br_config --enable BR2_TOOLCHAIN_EXTERNAL_CXX

    make olddefconfig
else
    echo "--- Konfiguracja Pre-built Toolchain ---"

    # 1. Ustawienie lepszego mirrora (Primary download site)
    # Build options -> Mirrors and download location -> Primary download site
    br_config --set-str BR2_PRIMARY_SITE "https://ftp.gnu.org/gnu"

    # 2. Zmiana toolchaina na prebuilt (External)
    # Toolchain type -> External toolchain
    br_config --enable BR2_TOOLCHAIN_EXTERNAL

    # 3. Wybór źródła toolchaina (Toolchain to be downloaded and installed)
    # Toolchain origin -> Toolchain to be downloaded and installed
    br_config --enable BR2_TOOLCHAIN_EXTERNAL_DOWNLOAD

    # 4. Wybór konkretnego toolchaina: Arm AArch64 13.3.rel1
    # Toolchain -> Arm AArch64 13.3.rel1
    br_config --enable BR2_TOOLCHAIN_EXTERNAL_ARM_AARCH64

    make olddefconfig
fi

# ==========================================
# 3a. Optimization (3a_optymalizacja.md)
# ==========================================
echo "--- Exercise 3a: Optimization (CCACHE) ---"
br_config --enable BR2_CCACHE
make olddefconfig

echo "Starting first build (This will take a while)..."
# make 2>&1 | tee build.log

# ==========================================
# 4. Bootloader (4_bootloader.md & 4a_bootloader_automat.md)
# ==========================================
echo "--- Exercise 4: Bootloader Configuration ---"
cd "${BUILDROOT_DIR}"

# Enable U-Boot
br_config --enable BR2_TARGET_UBOOT
br_config --set-str BR2_TARGET_UBOOT_BOARD_DEFCONFIG "rpi_4"
br_config --enable BR2_TARGET_UBOOT_NEEDS_DTC
make olddefconfig

# Create boot_cmd.txt
echo "Creating boot_cmd.txt..."
cat << 'EOF' > board/raspberrypi/boot_cmd.txt
fatload mmc 0:1 ${kernel_addr_r} Image
setenv bootargs root=/dev/mmcblk0p2 rootwait console=tty1 console=ttyAMA0,115200
booti ${kernel_addr_r} - ${fdtcontroladdr}
EOF

# Overwrite post-image.sh with the automated solution
echo "Updating post-image.sh..."
cat << 'EOF' > board/raspberrypi/post-image.sh
#!/bin/bash
set -e

BOARD_DIR="$(dirname $0)"
BOARD_NAME="$(basename ${BOARD_DIR})"
GENIMAGE_CFG="${BOARD_DIR}/genimage-${BOARD_NAME}.cfg"
GENIMAGE_TMP="${BUILD_DIR}/genimage.tmp"

ubootName=`find $BASE_DIR/build -name 'uboot-*' -type d | head -n 1`
if [ -n "$ubootName" ]; then
    $ubootName/tools/mkimage -A arm64 -O linux -T script -C none -d $BOARD_DIR/boot_cmd.txt $BINARIES_DIR/boot.scr
fi

if [ ! -e "${GENIMAGE_CFG}" ]; then
	GENIMAGE_CFG="${BINARIES_DIR}/genimage.cfg"
	FILES=()
	for i in "${BINARIES_DIR}"/*.dtb "${BINARIES_DIR}"/rpi-firmware/*; do
		FILES+=( "${i#${BINARIES_DIR}/}" )
	done
	UBOOT="${BINARIES_DIR}"/u-boot.bin
	FILES+=( "${UBOOT}" )
	BOOTSCRIPT="${BINARIES_DIR}"/boot.scr
	FILES+=( "${BOOTSCRIPT}" )
	KERNEL="Image"
	FILES+=( "${KERNEL}" )

	sed -i 's/^kernel=Image$/kernel=u-boot.bin/' "${BINARIES_DIR}/rpi-firmware/config.txt"

	BOOT_FILES=$(printf '\\t\\t\\t"%s",\\n' "${FILES[@]}")
	sed "s|#BOOT_FILES#|${BOOT_FILES}|" "${BOARD_DIR}/genimage.cfg.in" > "${GENIMAGE_CFG}"
fi

trap 'rm -rf "${ROOTPATH_TMP}"' EXIT
ROOTPATH_TMP="$(mktemp -d)"
rm -rf "${GENIMAGE_TMP}"

genimage \
	--rootpath "${ROOTPATH_TMP}"   \
	--tmppath "${GENIMAGE_TMP}"    \
	--inputpath "${BINARIES_DIR}"  \
	--outputpath "${BINARIES_DIR}" \
	--config "${GENIMAGE_CFG}"

exit $?
EOF
# chmod +x board/raspberrypi/post-image.sh
# make 2>&1 | tee build.log
# exit 0

# ==========================================
# 6. Rootfs & Initscripts (6_rootfs.md)
# ==========================================
echo "--- Exercise 6: Rootfs & Overlay ---"

OVERLAY_DIR="board/raspberrypi4/rootfs_overlay"
mkdir -p "${OVERLAY_DIR}/etc/init.d"
mkdir -p "${OVERLAY_DIR}/usr/sbin"

# Create resource_monitor.sh
cat << 'EOF' > "${OVERLAY_DIR}/usr/sbin/resource_monitor.sh"
#!/bin/sh
while true; do
    echo "Uptime: $(busybox uptime), Memory: $(free -m | grep Mem: | awk '{print $3}') MB used" >> /var/log/resource_monitor.log
    sleep 60
done
EOF
chmod +x "${OVERLAY_DIR}/usr/sbin/resource_monitor.sh"

# Create S99stats service
cat << 'EOF' > "${OVERLAY_DIR}/etc/init.d/S99stats"
#!/bin/sh
case "$1" in
  start)
    echo "Starting my_service..."
    /usr/sbin/resource_monitor.sh &
    ;;
  stop)
    echo "Stopping my_service..."
    killall resource_monitor.sh
    ;;
  restart)
    $0 stop
    $0 start
    ;;
  *)
    echo "Usage: $0 {start|stop|restart}"
    exit 1
    ;;
esac
exit 0
EOF
chmod +x "${OVERLAY_DIR}/etc/init.d/S99stats"


# Configure Buildroot for Overlay and Packages
br_config --set-str BR2_ROOTFS_OVERLAY "${OVERLAY_DIR}"
br_config --enable BR2_PACKAGE_NANO
br_config --enable BR2_PACKAGE_DROPBEAR

br_config --set-str BR2_TARGET_GENERIC_ROOT_PASSWD "${ROOT_PASSWORD}"
# Set dynamic device creation
br_config --enable BR2_ROOTFS_DEVICE_CREATION_DYNAMIC_MDEV
make olddefconfig

# ==========================================
# 8. Device Tree (8_devicetree.md)
# ==========================================
echo "--- Exercise 8: Device Tree Overlay ---"

mkdir -p board/raspberrypi/overlays

cat << 'EOF' > board/raspberrypi/overlays/led_overlay.dts
/dts-v1/;
/plugin/;

/ {
	compatible = "brcm,bcm2835";

	fragment@0 {
		// Configure the gpio pin controller
		target = <&gpio>;
		__overlay__ {
            led_pin1: led_pins@26 {
				brcm,pins = <26>; // gpio number
				brcm,function = <1>; // 0 = input, 1 = output
				brcm,pull = <0>; // 0 = none, 1 = pull down, 2 = pull up
			};
		};
	};
	fragment@1 {
		target-path = "/";
		__overlay__ {
            leds1: leds@1 {
				compatible = "gpio-leds";
				pinctrl-names = "default";
				pinctrl-0 = <&led_pin1>;
				status = "okay";

				led1: led {
			                label = "karol";
					        gpios = <&gpio 26 0>;  // GPIO26
			                linux,default-trigger = "heartbeat";
				};
			};
		};
	};
};
EOF

cat << 'EOF' > board/raspberrypi/post-build.sh
#!/bin/sh

set -u
set -e

DTS_SOURCE="board/raspberrypi/overlays/led_overlay.dts"
DTBO_TARGET="${BINARIES_DIR}/rpi-firmware/overlays/led_overlay.dtbo"

# Add a console on tty1
if [ -e ${TARGET_DIR}/etc/inittab ]; then
    grep -qE '^tty1::' ${TARGET_DIR}/etc/inittab || \
	sed -i '/GENERIC_SERIAL/a\
tty1::respawn:/sbin/getty -L  tty1 0 vt100 # HDMI console' ${TARGET_DIR}/etc/inittab
# systemd doesn't use /etc/inittab, enable getty.tty1.service instead
elif [ -d ${TARGET_DIR}/etc/systemd ]; then
    mkdir -p "${TARGET_DIR}/etc/systemd/system/getty.target.wants"
    ln -sf /lib/systemd/system/getty@.service \
       "${TARGET_DIR}/etc/systemd/system/getty.target.wants/getty@tty1.service"
fi

dtc -@ -I dts -O dtb -o ${DTBO_TARGET} ${DTS_SOURCE}
echo "dtoverlay=led_overlay" >> "${BINARIES_DIR}"/rpi-firmware/config.txt

EOF
chmod +x board/raspberrypi/post-build.sh

br_config --set-str BR2_POST_BUILD_SCRIPT "board/raspberrypi/post-build.sh"
make olddefconfig

# ==========================================
# 91. Custom Package (91_package.md)
# ==========================================
echo "--- Exercise 91: Creating 'Hello' Package ---"

mkdir -p package/hello

cat << 'EOF' > package/hello/Config.in
config BR2_PACKAGE_HELLO
    bool "hello"
    help
        Hello world package.
        http://example.com
EOF

cat << 'EOF' > package/hello/hello.mk
HELLO_VERSION = 1.0
HELLO_SITE = $(call github,KarolPWr,aahed,v$(HELLO_VERSION))
define HELLO_BUILD_CMDS
    $(MAKE) CC="$(TARGET_CC)" LD="$(TARGET_LD)" -C $(@D)/src
endef
define HELLO_INSTALL_TARGET_CMDS
    $(INSTALL) -D -m 0755 $(@D)/src/hello $(TARGET_DIR)/usr/bin
endef
$(eval $(generic-package))
EOF

if ! grep -q "package/hello/Config.in" package/Config.in; then
    sed -i '/menu "Target packages"/,/endmenu/ s|endmenu|    source "package/hello/Config.in"\nendmenu|' package/Config.in
fi

br_config --enable BR2_PACKAGE_HELLO
make olddefconfig

echo "Building Hello package..."
make hello

# Build everything from scratch (mostly for dynamic DEV MGMGT
make 2>&1 | tee build.log
exit 0

# # ==========================================
# # 93. Cross Compile (93_cross_compile.md)
# # ==========================================
# echo "--- Exercise 93: Manual Cross Compilation ---"

# cd "${WORKSPACE_DIR}"
# if [ ! -d "aahed" ]; then
#     git clone https://github.com/KarolPWr/aahed.git
# fi
# cd aahed/src

# export PATH="${CT_NG_DIR}/x-tools/aarch64-rpi4-linux-gnu/bin:$PATH"

# make clean
# make CC=aarch64-rpi4-linux-gnu-gcc
# file hello

# # ==========================================
# # D. BR2_EXTERNAL (d_br2_external.md)
# # ==========================================
# echo "--- Exercise D: BR2_EXTERNAL Setup ---"

# cd "${WORKSPACE_DIR}"
# mkdir -p refboard
# cd refboard

# cat << 'EOF' > external.desc
# name: REFBOARD
# desc: Custom training board
# EOF

# cat << 'EOF' > external.mk
# include $(sort $(wildcard $(BR2_EXTERNAL_REFBOARD_PATH)/package/*/*.mk))
# EOF

# cat << 'EOF' > Config.in
# # source "$BR2_EXTERNAL_REFBOARD_PATH/package/package1/Config.in"
# EOF

# mkdir -p board
# if [ -d "${BUILDROOT_DIR}/board/raspberrypi" ]; then
#     cp -r "${BUILDROOT_DIR}/board/raspberrypi" board/refboard
# fi

# echo "=== All Exercises Prepared ==="
# echo "To finalize the build with all changes, run: cd buildroot && make"