# Debugowanie systemu i aplikacji

## Logi

Dostępne formy logowania na naszym systemie:

- dmesg (kernel buffer)
- pliki w /var/log

Bardziej zaawansowane możliwości:

- logread (na openwrt)
- journalctl (wchodzi w skład systemd)
- syslog 

## gdb, gdbserver 

Korzystamy z narzędzi wyprodukowanych przez crosstool-ng 

Przerzucamy gdbserver na target

    cd crosstool-ng/x-tools/aarch64-rpi4-linux-gnu/aarch64-rpi4-linux-gnu/debug-root/usr/bin
    scp gdbserver  root@<TARGET IP>:/tmp

Odpalamy gdbserver na targecie (port 1234)

    cd /tmp
    ./gdbserver :1234 <SCIEZKA DO BINARKI>

Odpalamy gdb na hoście (laptopie)

    cd crosstool-ng/x-tools/aarch64-rpi4-linux-gnu/bin
    ./aarch64-rpi4-linux-gnu-gdb <SCIEZKA DO BINARKI>

Uwaga: Żeby zadziałało, nasz program musi być skompilowany z symbolami debugowania.

Następnie po zalogowaniu do GDB, możemy połączyć się do targetu

    target remote <IP TARGETU>>:1234

Powinniśmy zobaczyć tekst naszego programu


### Zadanie

- Ustaw breakpoint 
- Ustaw watch na jednej ze zmiennych 
- Ustaw zmienną
- Spróbuj spowodować crash programu


## strace | ltrace 

strace -f time echo “Hello”


## performance issues

top | free | cat /proc/meminfo