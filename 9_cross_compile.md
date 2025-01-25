# Prosta cross kompilacja

Checkout repozytorium do workspace

    cd workspace
    git clone git@github.com:KarolPWr/aahed.git
    cd aahed/src

Cross compile z użyciem crosstool-ng:

    export PATH=<sciezka do bin/ toolchaina>:$PATH
    make CC=<toolchain tuple>-gcc

Sprzwdź za pomocą komendy $ file czy wygenerował się odpowiedni plik

    file hello

Przerzucić na target, na za pomocą scp:

    scp /path/to/local/file username@remote_host:/path/to/remote/destination

czyli np.

    scp hello root@<IP ADDRESS TARGETU>:/tmp

Przetestować na płytce czy działa. Program po odpaleniu powinien wyświetlić napis:

    Hello Buildroot



