TARGET_DIR = bin
BOARD ?= GENERIC
USER_C_MODULES ?= ../../../usermods
MPY_DIR ?= micropython
FROZEN_MANIFEST_FULL ?= ../../../manifests/esp32.py
FROZEN_MANIFEST_UNIX ?= ../../../manifests/unix.py
DEBUG ?= 0

$(TARGET_DIR):
	mkdir -p $(TARGET_DIR)

# check submodules
$(MPY_DIR)/mpy-cross/Makefile:
	git submodule update --init --recursive

# cross-compiler
mpy-cross: $(TARGET_DIR) $(MPY_DIR)/mpy-cross/Makefile
	@echo Building cross-compiler
	make -C $(MPY_DIR)/mpy-cross \
	DEBUG=$(DEBUG) && \
	cp $(MPY_DIR)/mpy-cross/mpy-cross $(TARGET_DIR)


# esp32 board with bitcoin library
esp32: $(TARGET_DIR) mpy-cross $(MPY_DIR)/ports/stm32
	@echo Building binary with frozen files
	make -C $(MPY_DIR)/ports/esp32 \
		BOARD=$(BOARD) \
		USER_C_MODULES=$(USER_C_MODULES) \
		FROZEN_MANIFEST=$(FROZEN_MANIFEST_FULL) \
		DEBUG=$(DEBUG)

# unixport (simulator)
unix: $(TARGET_DIR) mpy-cross $(MPY_DIR)/ports/unix
	@echo Building binary with frozen files
	make -C $(MPY_DIR)/ports/unix \
		USER_C_MODULES=$(USER_C_MODULES) \
		FROZEN_MANIFEST=$(FROZEN_MANIFEST_UNIX) && \
	cp $(MPY_DIR)/ports/unix/micropython $(TARGET_DIR)/micropython_unix

simulate: unix
	$(TARGET_DIR)/micropython_unix

test: unix
	$(TARGET_DIR)/micropython_unix tests/run_tests.py

all: mpy-cross empty disco unix

clean:
	rm -rf $(TARGET_DIR)
	make -C $(MPY_DIR)/mpy-cross clean
	make -C $(MPY_DIR)/ports/esp32 \
		USER_C_MODULES=$(USER_C_MODULES) \
		FROZEN_MANIFEST=$(FROZEN_MANIFEST_UNIX) clean
	make -C $(MPY_DIR)/ports/stm32 \
		BOARD=$(BOARD) \
		USER_C_MODULES=$(USER_C_MODULES) clean

.PHONY: all clean