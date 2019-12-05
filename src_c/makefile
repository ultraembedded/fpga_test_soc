TARGET       = hello_world
ARCH         = riscv
PLATFORM     = machine-fpga

EXTRA_CFLAGS+= -DCPU_KHZ=50000

SRC_DIR      = ./ 
SRC_DIR     += ./include
SRC_DIR     += ../soc/core_soc/src_c

# UART driver
EXTRA_CFLAGS += -DCONFIG_UARTLITE
EXTRA_CFLAGS += -DCONFIG_UARTLITE_BASE=0x92000000
SRC_DIR     += ./drivers/uart

BASE_ADDRESS  = 0x0
OPT           = 2

TARGET_PORT ?= /dev/ttyUSB1
RUN_PREFIX  := ../run.py -d $(TARGET_PORT) -b 1000000 -f 

MAKE_DIR=./make
include $(MAKE_DIR)/makefile.exe
