###############################################################################
## Makefile
###############################################################################
PART_NAME    = xc6slx9
PART_PACKAGE = ftg256
PART_SPEED   = 3

CPU         ?= riscv

# Choice: [rv32i, rv32i_spartan6, rv32im, rv32imsu]
RISCV_CORE  ?= rv32i_spartan6

SRC_DIR      = .
SRC_DIR     += ../common
SRC_DIR     += ../../soc/core_soc/src_v
SRC_DIR     += ../../soc/dbg_bridge/src_v

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

include ../common/makefile.fpga_ise