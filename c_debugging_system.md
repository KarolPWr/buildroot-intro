# Debugowanie systemu i aplikacji

## Logi

Dostępne formy logowania na naszym systemie:

- dmesg (kernel buffer)
- pliki w /var/log

Bardziej zaawansowane możliwości:

- logread (na openwrt)
- journalctl (wchodzi w skład systemd)
- syslog 

## gdb, gdbserver w Buildroot

Możemy skorzystać z GDB budowanego przy okazji budowania Toolchaina.
Potrzebujemy dwóch elementów: GDB (na hosta) oraz gdbserver (na target)

Zaznacz w menuconfig w Toolchain-> Copy gdb server to the Target

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