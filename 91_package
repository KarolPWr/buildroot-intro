# Tworzenie własnych paczek

Używamy workflow in-tree 

mkdir packages/thermo
cd packages/thermo

Tworzymy następujacą hierarchię plików:

    .
    ├── Config.in
    ├── hello.mk
    └── src
        ├── hello.c
        └── Makefile

Config.in:


    config BR2_PACKAGE_HELLO
        bool "hello"
        help
            Hello world package.

            http://example.com

hello.mk:

    ################################################################################
    # Recepta
    ################################################################################

    # Replace 'your-package' with the actual name of your package.
    HELLO_VERSION = 1.0 
    HELLO_SITE = $(call github,KarolPWr,aahed,v$(HELLO_VERSION))

    # Build config
    define HELLO_BUILD_CMDS
        $(MAKE) CC="$(TARGET_CC)" LD="$(TARGET_LD)" -C $(@D)
    endef

    # Install target for your built binaries
    define HELLO_INSTALL_TARGET_CMDS
        $(INSTALL) -D -m 0755 $(@D)/src/hello $(TARGET_DIR)/usr/bin
    endef

    # Register the package
    $(eval $(generic-package))

Dodać linijkę do Config.in w packages/ (jaką?)

## Zaznaczyć w menuconfig, zbudować samą paczkę a następnie cały image i przetestować.
