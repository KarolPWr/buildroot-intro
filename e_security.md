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

Więcej informacji: https://pip-assets.raspberrypi.com/categories/1260-security/documents/RP-003466-WP-3-Boot%20Security%20Howto.pdf?disposition=inline

## Apparmor, SELinux

# Build options w Buildroot

make menuconfig -> build options -> na samym dole security hardening 

# Zadanie - Analiza CVE 

Wywołaj polecenie 

    make pkg-stats

Otwórz w przeglądarce raport, plik output/pkg-stats.html