# Rootfs

# Internet
Dzięki odpowiednim ustawieniom w defconfig mamy od razu dostęp do internetu przez ethernet

Konkretnie: BR2_SYSTEM_DHCP="eth0" oraz narzędzia od busybox'a

Uwaga: W przypadku udostępniania połączenia z laptopa, możliwe że trzeba będzie odpowiednio ustawić firewall na własnym komputerze

    iptables -P FORWARD ACCEPT

Skrypt obsługujący start połączenia z siecią:

    /etc/init.d/S40network

Sprawdź czy na Twoim targecie działa internet:
[Polecenie odpal na Rasperry Pi]

    ping 8.8.8.8
    ip address


## Initscripts 
Pisanie serwisów odpalanych automatycznie po starcie systemu

Na początku bez Buildroota. Tworzymy ręcznie pliki na targecie i patrzymy czy działa.

### Skrypt - resource monitor

    vi /usr/sbin/resource_monitor.sh

ZADANIE - Napisz skrypt, który będzie co 60 sekund drukował podstawowe informacje o systemie (uptime, data, wolna pamięć)

Output powinien być zapisany do pliku o nazwie 

    /var/log/resource_monitor.log

Nadaj uprawnienia do wykonywania

    chmod +x /usr/sbin/resource_monitor.sh

### Serwis - S99stats

Stwórz plik w /etc/init.d o nazwie S99stats

Kod:

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

Nadaj uprawnienia do wykonywania:

    chmod +x S99stats

### Test

Odpal ręcznie oba skrypty - jaki jest efekt działania? Czy taki jak oczekiwany?

Zresetuj płytkę (np. komenda reboot) i sprawdź czy Twój serwis zaczyna działać automatycznie po starcie.

## Zadanie - Dodawanie gotowych paczek

Przechodzimy do buildroota

    cd workspace/buildroot

Za pomocą make menuconfig dodaj edytor tekstowy 

    nano

## root password

Skonfiguruj hasło dla użytkownika root (dowolne, najlepiej krótkie np. 1234)

## Narzędzia do networkingu
Dodaj dodatkowe narzędzia dla networkingu

    Target packages -> Networking applications

    Enable ethtool

## firmware 

W przypadku WiFi należy ustawić odpowiednie wsparcie firmware. Dla ethernetu już wszystko jest gotowe.

## dev management 

Dodaj wsparcie dla devtmpfs + mdev

    System configuration -> /dev management

## Obsługa SSH
Dodaj klienta SSH. Dzięki temu ułatwimy połączenie z płytką.

    Networking applications -> dropbear

## Rootfs overlay

Wiemy że ręcznie nasz skrypt i serwis działają. Teraz czas na stworzenie rootfs overlay i zintegrowanie naszych pomysłów w build systemie. 

Posłużymy się w tym celu rootfs overlay'em

Stwórz rootfs overlay

    mkdir -p board/raspberrypi4/rootfs_overlay/etc/init.d

Napisz kod serwisu

    nano board/raspberrypi4/rootfs_overlay/etc/init.d/S99stats


Nadaj uprawnienia wykonywania dla skryptu

    chmod +x board/raspberrypi4/rootfs_overlay/etc/init.d/S99stats

Dodaj skrypt:

    mkdir -p board/raspberrypi4/rootfs_overlay/usr/sbin
    nano board/raspberrypi4/rootfs_overlay/usr/sbin/resource_monitor.sh
    chmod +x board/raspberrypi4/rootfs_overlay/usr/sbin/resource_monitor.sh


Włącz obsługę rootfs overlay:

    System configuration  --->
    Root filesystem overlay directories
        (board/raspberrypi4/rootfs_overlay)

## Przebudowa obrazu OD ZERA

    make clean all


## Test

Sprawdź czy wszystko działa zgodnie z oczekiwaniami

- Połączenie z internetem
- Połączenie SSH
- Logowanie skryptem i nowy serwis, S99