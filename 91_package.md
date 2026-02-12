# Tworzenie własnych paczek

Używamy workflow in-tree. Przechodzimy do źródeł Buildroota

    cd workspace/buildroot
    mkdir package/hello
    cd package/hello

Tworzymy następujacą hierarchię plików:

    .
    ├── Config.in
    ├── hello.mk

Config.in:


    config BR2_PACKAGE_HELLO
        bool "hello"
        help
            Hello world package.

            http://example.com

hello.mk:

    ################################################################################
    # Hello program
    ################################################################################

    HELLO_VERSION = 1.0
    HELLO_SITE = $(call github,KarolPWr,aahed,v$(HELLO_VERSION))

    # Build configuration
    define HELLO_BUILD_CMDS
        $(MAKE) CC="$(TARGET_CC)" LD="$(TARGET_LD)" -C $(@D)/src
    endef

    # Install target for your built binaries
    define HELLO_INSTALL_TARGET_CMDS
        $(INSTALL) -D -m 0755 $(@D)/src/hello $(TARGET_DIR)/usr/bin
    endef

    # Register the package
    $(eval $(generic-package))

Dodać do Config.in w buildroot/package/ (przed ostatnim endmenu)

    menu "Sterlet Packages"
        source "package/hello/Config.in"
    endmenu

Wejdź do make menuconfig i dodaj nową paczkę do buildu (pojawi się nowe menu w Target packages na dole)

## Budowanie

Zbuduj najpierw paczkę "na sucho", żeby sprawdzić czy w ogóle się buduje

    make <pkg-name>

Sprawdź w output/build czy wszystko wygląda tak jak powinno

Przebuduj obraz i wrzuć na target

    make
