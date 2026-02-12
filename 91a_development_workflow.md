# Używanie Buildroota w developmencie

Żeby ułatwić pracę developerską, zamiast ściągać za każdym razem remote source, możemy korzystać z plików w lokalnym folderze. 

Plik config definiujący override jest ustawiany przez symbol BR2_PACKAGE_OVERRIDE_FILE (jest domyślnie ustawiony ale plik nie istnieje, trzeba go stworzyć)

Stwórz plik local.mk w buildroot/

Wpisz do niego override dla danej paczki (np. hello):

    HELLO_OVERRIDE_SRCDIR = <SCIEZKA>/aahed

Przebuduj za pomocą 

    make hello-rebuild

Roboczo można przerzucić aplikację na target przez SCP

    scp -O /path/to/local/file username@remote_host:/path/to/remote/destination

czyli np.

    scp -O output/build/hello-custom/src/hello root@<IP ADDRESS TARGETU>:/tmp


Więcej informacji:

https://buildroot.org/downloads/manual/manual.html#_advanced_usage

