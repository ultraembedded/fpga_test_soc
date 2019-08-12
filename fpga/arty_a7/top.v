//-----------------------------------------------------------------
// TOP
//-----------------------------------------------------------------
module top
(
     input           clk100_i

    // UART
    ,input           uart_txd_i
    ,output          uart_rxd_o

    // SPI-Flash
    ,output          flash_sck_o
    ,output          flash_cs_o
    ,output          flash_si_o
    ,input           flash_so_i

    // Pmod Headers
    ,inout  [7:0]    ja
    ,inout  [7:0]    jb
    ,inout  [7:0]    jc
    ,inout  [7:0]    jd
);

//-----------------------------------------------------------------
// PLL
//-----------------------------------------------------------------
wire clk;

artix7_pll
u_pll
(
    .clkref_i(clk100_i),
    .clkout0_o(clk)
);

//-----------------------------------------------------------------
// Reset
//-----------------------------------------------------------------
wire rst;

reset_gen
u_rst
(
    .clk_i(clk),
    .rst_o(rst)
);

//-----------------------------------------------------------------
// Core
//-----------------------------------------------------------------
wire        dbg_txd_w;
wire        uart_txd_w;

wire        spi_clk_w;
wire        spi_so_w;
wire        spi_si_w;
wire [7:0]  spi_cs_w;

wire [31:0] gpio_in_w;
wire [31:0] gpio_out_w;
wire [31:0] gpio_out_en_w;

fpga_top
#(
    .CLK_FREQ(50000000)
   ,.BAUDRATE(1000000)   // SoC UART baud rate
   ,.UART_SPEED(1000000) // Debug bridge UART baud (should match BAUDRATE)
   ,.C_SCK_RATIO(50)     // SPI clock divider (SPI_CLK=CLK_FREQ/C_SCK_RATIO)
`ifdef CPU_SELECT_ARMV6M
   ,.CPU("armv6m")       // riscv or armv6m
`else
   ,.CPU("riscv")        // riscv or armv6m
`endif
)
u_top
(
     .clk_i(clk)
    ,.rst_i(rst)

    ,.dbg_rxd_o(dbg_txd_w)
    ,.dbg_txd_i(uart_txd_i)

    ,.uart_tx_o(uart_txd_w)
    ,.uart_rx_i(uart_txd_i)

    ,.spi_clk_o(spi_clk_w)
    ,.spi_mosi_o(spi_si_w)
    ,.spi_miso_i(spi_so_w)
    ,.spi_cs_o(spi_cs_w)

    ,.gpio_input_i(gpio_in_w)
    ,.gpio_output_o(gpio_out_w)
    ,.gpio_output_enable_o(gpio_out_en_w)
);

//-----------------------------------------------------------------
// SPI Flash
//-----------------------------------------------------------------
assign flash_sck_o = spi_clk_w;
assign flash_si_o  = spi_si_w;
assign flash_cs_o  = spi_cs_w[0];
assign spi_so_w    = flash_so_i;

//-----------------------------------------------------------------
// GPIO (PMOD JA=gpio[7:0],...,JD=gpio[31:24])
//-----------------------------------------------------------------
genvar i;
generate  
for (i=0; i < 8; i=i+1)
begin
    assign ja[i]           = gpio_out_en_w[0+i]  ? gpio_out_w[0+i]  : 1'bz;
    assign jb[i]           = gpio_out_en_w[8+i]  ? gpio_out_w[8+i]  : 1'bz;
    assign jc[i]           = gpio_out_en_w[16+i] ? gpio_out_w[16+i] : 1'bz;
    assign jd[i]           = gpio_out_en_w[24+i] ? gpio_out_w[24+i] : 1'bz;

    assign gpio_in_w[0+i]  = ja[i];
    assign gpio_in_w[8+i]  = jb[i];
    assign gpio_in_w[16+i] = jc[i];
    assign gpio_in_w[24+i] = jd[i];
end  
endgenerate

//-----------------------------------------------------------------
// UART Tx combine
//-----------------------------------------------------------------
// Xilinx placement pragmas:
//synthesis attribute IOB of txd_q is "TRUE"
reg txd_q;

always @ (posedge clk or posedge rst)
if (rst)
    txd_q <= 1'b1;
else
    txd_q <= dbg_txd_w & uart_txd_w;

// 'OR' two UARTs together
assign uart_rxd_o  = txd_q;

endmodule
