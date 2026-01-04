# Praca z kontenerem 

## Sprawdzenie czy docker działa
    docker --version

Przykładowy output:

    docker --version

    Docker version 24.0.7, build 24.0.7-0ubuntu2~22.04.1

## Odpalanie kontenera

Klonujemy repozytorium:

    mkdir workspace && cd workspace
    git clone https://github.com/KarolPWr/docker-buildroot.git
    cd docker-buildroot

Budujemy obraz i uruchamiamy kontener:

    bash setup.sh

Po chwili powinniśmy zobaczyć prompt systemowy:

    <TWOJ USER>@21a872bee3e0:~$

Jesteśmy gotowi do pracy z Buildrootem.

Kontener domyślnie wchodzi do katalogu domowego bieżącego użytkownika. Jeśli folder workspace już istnieje, możesz teraz do niego przejść.
    
    cd workspace 
