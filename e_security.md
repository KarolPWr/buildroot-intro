# Security - system hardening

## Read-only rootfs

    menu System configuration
    menu Filesystem images

## Wyłączanie niepotrzebnych ficzerów 

Zmniejszenie obrazu oraz mniejsza powierzchnia ataku

## Wyłączanie interfejsów

Koniecznie disable UART

## Zmiana portu SSH 

Mało kto atakuje poza portem domyślnym

## Używanie haseł 

## Linux kernel hardening
USB_USBNET
PAGE_POISON
DEVMEM

## Secure boot 

Więcej informacji: https://pip.raspberrypi.com/categories/685-whitepapers-app-notes-compliance-guides/documents/RP-003466-WP/Boot-Security-Howto.pdf

## Apparmor, SELinux

# Build options w Buildroot

make menuconfig -> build options -> na samym dole security hardening 

# Zadanie - Analiza CVE 

Wywołaj polecenie 

    make pkg-stats

Otwórz w przeglądarce raport, plik output/pkg-stats.html