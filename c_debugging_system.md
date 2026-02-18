# Debugowanie systemu i aplikacji

## Logi

Dostępne formy logowania na naszym systemie:

- dmesg (kernel buffer)
- pliki w /var/log

Bardziej zaawansowane możliwości:

- logread (na openwrt)
- journalctl (wchodzi w skład systemd)
- syslog 


## strace | ltrace 

strace -f time echo “Hello”


## performance issues

top | free | cat /proc/meminfo