# Clocks
set_property -dict { PACKAGE_PIN N11    IOSTANDARD LVCMOS33 } [get_ports { clk50_i }];
create_clock -add -name sys_clk_pin -period 20.00 -waveform {0 10} [get_ports { clk50_i }];

# LED
set_property -dict { PACKAGE_PIN C8    IOSTANDARD LVCMOS33 } [get_ports { led_o }];

# UART
set_property -dict { PACKAGE_PIN T9     IOSTANDARD LVCMOS33 } [get_ports { uart_txd_i }];
set_property -dict { PACKAGE_PIN R10    IOSTANDARD LVCMOS33 } [get_ports { uart_rxd_o }];

# SPI Flash
set_property -dict { PACKAGE_PIN M15    IOSTANDARD LVCMOS33 } [get_ports { flash_sck_o }];
set_property -dict { PACKAGE_PIN L12    IOSTANDARD LVCMOS33 } [get_ports { flash_cs_o }];
set_property -dict { PACKAGE_PIN J13    IOSTANDARD LVCMOS33 } [get_ports { flash_si_o }];
set_property -dict { PACKAGE_PIN J14    IOSTANDARD LVCMOS33 } [get_ports { flash_so_i }];
