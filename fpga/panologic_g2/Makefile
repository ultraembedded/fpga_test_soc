###############################################################################
## Makefile
###############################################################################
CPU        ?= riscv
XILINX_ISE ?= /opt/Xilinx/14.7/ISE_DS/ISE/bin/lin64
CABLE 	   ?= jtaghs2
XC3SPROG_OPTS ?= -c $(CABLE) -v
XC3SPROG      ?= xc3sprog

# Choice: [rv32i, rv32i_spartan6, rv32im, rv32imsu]
RISCV_CORE  ?= rv32i_spartan6

PART_NAME    = xc6slx150
PART_PACKAGE = fgg484
PART_SPEED   = 2

SRC_DIR      = .
SRC_DIR     += ../common
SRC_DIR     += ../../soc/core_soc/src_v
SRC_DIR     += ../../soc/dbg_bridge/src_v

CORES_README = ../../soc/core_soc/README.md


# RISC-V
ifeq ($(CPU),riscv)
  SRC_DIR      += ../../cpu/riscv/core/$(RISCV_CORE)
  SRC_DIR      += ../../cpu/riscv/top_tcm_wrapper
  EXTRA_VFLAGS += CPU_SELECT_RISCV=1
else
  # Cortex M0
  SRC_DIR      += ../../cpu/cortex_m0/src_v
  EXTRA_VFLAGS += CPU_SELECT_ARMV6M=1
endif

.PHONY: init_and_build

init_and_build: ${CORES_README} all

include ../common/makefile.fpga_ise

BIT_FILE = project/${PROJECT}_routed.bit
load:
	$(XC3SPROG) $(XC3SPROG_OPTS) ${BIT_FILE}

prog_fpga:
	$(XC3SPROG) $(XC3SPROG_OPTS) -Ixc3sprog/$(PART_NAME).bit ${BIT_FILE}

${CORES_README}:
	git submodule init
	git submodule update

