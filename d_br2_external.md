# BR2_EXTERNAL

Development poza głównym drzewem Buildroota

Stwórz directory o nazwie refboard poza głównym drzewem

    cd workspace
    mkdir refboard

Dodaj pliki: external.desc, external.mk oraz Config.in

external.desc:

    name: REFBOARD
    desc: Custom training board

external.mk:

    include $(sort $(wildcard $(BR2_EXTERNAL_BAR_42_PATH)/package/*/*.mk))

Config.in (na razie tylko dla referencji)

    #source "$BR2_EXTERNAL_BAR_42_PATH/package/package1/Config.in"
    #source "$BR2_EXTERNAL_BAR_42_PATH/package/package2/Config.in"

## Tworzenie nowych konfiguracji

Najłatwiej zacząć od już dostępnych. Skopiuj boards/raspberrypi i wklej do refboard
Skopiuj defconfig do configs/refboard_defconfig

Ostatecznie refboard/ powiinien wyglądać w ten sposób:

    karol.przybylski:~/workspace/refboard$ tree
        .
        ├── board
        │   └── refboard
        │       ├── cmdline.txt
        │       ├── config_4_64bit.txt
        │       ├── genimage.cfg.in
        │       ├── patches
        │       │   ├── linux
        │       │   │   └── linux.hash
        │       │   └── linux-headers
        │       │       └── linux-headers.hash -> ../linux/linux.hash
        │       ├── post-build.sh
        │       ├── post-image.sh
        │       └── readme.txt
        ├── Config.in
        ├── configs
        │   └── refboard_defconfig
        ├── external.desc
        └── external.mk

