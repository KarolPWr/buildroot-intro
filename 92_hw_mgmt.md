# Zarządzanie sprzętem

## Przygotowanie

Sprawdź czy moduł kernela dający wsparcie jest w naszym mernelu

    make linux-menuconfig

Co oznacza symbol M przy module? 

Podłącz czujnik zgodnie z pinoutem: 
https://www.raspberrypi.com/documentation/computers/images/GPIO-Pinout-Diagram-2.png?hash=df7d7847c57a1ca6d5b2617695de6d46

    SCL <-> SCL (GPIO 2)
    SDA <-> SDA (GPIO 3)
    VCC <-> 3v3 power (GPIO 1)
    GND <-> Dowolny ground

Dodaj overlay wspierający nasz czujnik (do pliku config.txt)

    dtoverlay=i2c-sensor,bmp280

Sprawdź logi na targecie po załadowaniu

    dmesg | grep -i bmp

Nowe pliki pojawią się w ścieżce:

    /sys/bus/iio/devices/iio:device0/

Przykład:

    # cat /sys/bus/iio/devices/iio:device0/in_temp_input 
    24260

## Zadanie
Napisz program w shell lub w C, który:

- odczyta temperaturę z czujnika 
- zapisze dane z ostatniego odczytu do pliku tekstowego

Zintegruj rozwiązanie z Buildrootem. Możesz bazować na recepcie hello lub stworzyć całkiem nową.

## Uwaga

- Bardzo dokładnie sprawdź połączenie z czujnikiem. Czy wybrałeś dobre SCL,SDA, czy jest podpięty do 3v3, czy kabelki nie są luźne. 

- Czujnik może się czasem zawiesić. Jeśli tak się stanie, sprawdź ponownie połączenie sprzętowe, ewentualnie zrób reboot.

- Spróbuj powtórzyć pomiar kilka razy pod rząd (aż nie "załapie")