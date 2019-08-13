### FPGA Test SoC

Github:   [https://github.com/ultraembedded/fpga_test_soc](https://github.com/ultraembedded/fpga_test_soc)

A small test SoC for various soft-CPUs (Cortex-M0, RISC-V).

![](doc/block_diagram.png)

## Cloning

This repo contains submodules.  
Make sure to clone them with the following command;

```
git clone --recursive https://github.com/ultraembedded/fpga_test_soc.git

```

## Features
* Support for RISC-V or ARM Cortex-M0 CPU
* Load SW via UART/USB serial.
* Multi-channel timer peripheral.
* UART peripheral.
* SPI (master mode) peripheral with 8 chip selects.
* 32 I/O GPIO controller.
* Interrupt controller (combines peripheral IRQs into single IRQ).

## Memory Map

| Range                     | Description                                         |
| ------------------------- | --------------------------------------------------- |
| 0x0000_0000 - 0x0000_ffff | 64-KB Memory (RISC-V)                               |
| 0x0000_0000 - 0x0000_7fff | 32-KB Instruction Memory (Cortex-M0)                |
| 0x2000_0000 - 0x2000_7fff | 32-KB Data Memory (Cortex-M0)                       |
| 0x9000_0000 - 0x90ff_ffff | Peripheral - IRQ controller                         |
| 0x9100_0000 - 0x91ff_ffff | Peripheral - Timer                                  |
| 0x9200_0000 - 0x92ff_ffff | Peripheral - UART                                   |
| 0x9300_0000 - 0x93ff_ffff | Peripheral - SPI                                    |
| 0x9400_0000 - 0x94ff_ffff | Peripheral - GPIO                                   |

## Project Files

This project is constructed from various sub-projects;
* [CPU - RISC-V](https://github.com/ultraembedded/riscv)
* [CPU - Cortex-M0 Wrapper](https://github.com/ultraembedded/cortex_m0_wrapper)
* [Peripherals](https://github.com/ultraembedded/core_soc)
* [UART -> AXI Debug Bridge](https://github.com/ultraembedded/core_dbg_bridge)

```
├── cpu
│   ├── cortex_m0
│   │   └── src_v
│   │       ├── ahb_dport.v
│   │       ├── cortexm0ds_logic.v       [NOT SUPPLIED]
│   │       ├── CORTEXM0INTEGRATION.v    [NOT SUPPLIED]
│   │       ├── cortex_m0.v
│   │       ├── cortex_m0_wrapper.v
│   │       ├── dport_axi.v
│   │       ├── dport_mem_pmem.v
│   │       ├── dport_mem_ram13.v
│   │       ├── dport_mem.v
│   │       └── dport_mux.v
│   └── riscv
│       ├── core
│       │   ├── rv32i
│       │   │   ├── riscv_alu.v
│       │   │   ├── riscv_core.v
│       │   │   ├── riscv_csr.v
│       │   │   ├── riscv_decode.v
│       │   │   ├── riscv_defs.v
│       │   │   ├── riscv_exec.v
│       │   │   ├── riscv_fetch.v
│       │   │   ├── riscv_lsu.v
│       │   │   └── riscv_regfile.v
│       │   ├── rv32im
│       │   │   ├── riscv_alu.v
│       │   │   ├── riscv_core.v
│       │   │   ├── riscv_csr.v
│       │   │   ├── riscv_decode.v
│       │   │   ├── riscv_defs.v
│       │   │   ├── riscv_exec.v
│       │   │   ├── riscv_fetch.v
│       │   │   ├── riscv_lsu.v
│       │   │   ├── riscv_muldiv.v
│       │   │   └── riscv_regfile.v
│       │   ├── rv32imsu
│       │   │   ├── riscv_alu.v
│       │   │   ├── riscv_core.v
│       │   │   ├── riscv_csr.v
│       │   │   ├── riscv_decode.v
│       │   │   ├── riscv_defs.v
│       │   │   ├── riscv_exec.v
│       │   │   ├── riscv_fetch.v
│       │   │   ├── riscv_lsu.v
│       │   │   ├── riscv_mmu_arb.v
│       │   │   ├── riscv_mmu.v
│       │   │   ├── riscv_muldiv.v
│       │   │   └── riscv_regfile.v
│       │   └── rv32i_spartan6
│       │       ├── riscv_alu.v
│       │       ├── riscv_core.v
│       │       ├── riscv_csr.v
│       │       ├── riscv_decode.v
│       │       ├── riscv_defs.v
│       │       ├── riscv_exec.v
│       │       ├── riscv_fetch.v
│       │       ├── riscv_lsu.v
│       │       └── riscv_regfile.v
│       └── top_tcm_wrapper
│           ├── dport_axi.v
│           ├── dport_mux.v
│           ├── riscv_tcm_wrapper.v
│           ├── tcm_mem_pmem.v
│           ├── tcm_mem_ram.v
│           └── tcm_mem.v
├── fpga
│   ├── arty_a7
│   │   ├── artix7_pll.v
│   │   ├── arty_revb.xdc
│   │   ├── makefile
│   │   └── top.v
│   ├── common
│   │   ├── axi4_axi4lite_conv.v
│   │   ├── fpga_top.v
│   │   ├── makefile.fpga_ise
│   │   ├── makefile.fpga_vivado
│   │   └── reset_gen.v
│   ├── minispartan6
│   │   ├── fpga.ucf
│   │   ├── makefile
│   │   └── top.v
│   └── qmtech_a7
│       ├── makefile
│       ├── top.v
│       └── xc7m.xdc
└── soc
    ├── core_soc
    │   └── src_v
    │       ├── axi4lite_dist.v
    │       ├── core_soc.v
    │       ├── gpio_defs.v
    │       ├── gpio.v
    │       ├── irq_ctrl_defs.v
    │       ├── irq_ctrl.v
    │       ├── spi_lite_defs.v
    │       ├── spi_lite.v
    │       ├── timer_defs.v
    │       ├── timer.v
    │       ├── uart_lite_defs.v
    │       └── uart_lite.v
    └── dbg_bridge
        └── src_v
            ├── dbg_bridge_fifo.v
            ├── dbg_bridge_uart.v
            └── dbg_bridge.v
```

## Getting Started

#### Building a FPGA target (RISC-V)

```
# Choose target board
cd fpga/arty_a7

# Make sure Vivado environmental variables setup
source /opt/Xilinx/Vivado/XXXX.X/settings64.sh

# Build bitstream
make CPU=riscv

# Load bitstream onto target board
make run
```

#### Building a FPGA target (Cortex-M0)

```

# Download ARM Cortex-M0 DesignStart from ARM

# Copy CPU core files into this project
cp CORTEXM0INTEGRATION.v cpu/cortex_m0/src_v/
cp cortexm0ds_logic.v cpu/cortex_m0/src_v/

# Choose target board
cd fpga/arty_a7

# Make sure Vivado environmental variables setup
source /opt/Xilinx/Vivado/XXXX.X/settings64.sh

# Build bitstream
make CPU=armv6m

# Load bitstream onto target board
make run
```

#### Running helloworld on the target

```

# Find correct tty port (replace /dev/ttyUSB1 as appropriate)...

# Run FW on target
./run.py -d /dev/ttyUSB1 -f prebuilt/helloworld_riscv.elf 
ELF: Loading 0x0 - size 15KB
 |XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX| 100.0% 
helloworld!
helloworld!
helloworld!
helloworld!
helloworld!
helloworld!
helloworld!
helloworld!
```
