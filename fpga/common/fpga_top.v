//-----------------------------------------------------------------
//                        FPGA Test Soc
//                           V0.1
//                     Ultra-Embedded.com
//                       Copyright 2019
//
//                 Email: admin@ultra-embedded.com
//
//                         License: GPL
// If you would like a version with a more permissive license for
// use in closed source commercial applications please contact me
// for details.
//-----------------------------------------------------------------
//
// This file is open source HDL; you can redistribute it and/or 
// modify it under the terms of the GNU General Public License as 
// published by the Free Software Foundation; either version 2 of 
// the License, or (at your option) any later version.
//
// This file is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public 
// License along with this file; if not, write to the Free Software
// Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307
// USA
//-----------------------------------------------------------------

//-----------------------------------------------------------------
//                          Generated File
//-----------------------------------------------------------------

module fpga_top
//-----------------------------------------------------------------
// Params
//-----------------------------------------------------------------
#(
     parameter CLK_FREQ         = 50000000
    ,parameter BAUDRATE         = 1000000
    ,parameter UART_SPEED       = 1000000
    ,parameter C_SCK_RATIO      = 50
    ,parameter CPU              = "riscv" // riscv or armv6m
)
//-----------------------------------------------------------------
// Ports
//-----------------------------------------------------------------
(
    // Inputs
     input           clk_i
    ,input           rst_i
    ,input           dbg_txd_i
    ,input           spi_miso_i
    ,input           uart_rx_i
    ,input  [ 31:0]  gpio_input_i

    // Outputs
    ,output          dbg_rxd_o
    ,output          spi_clk_o
    ,output          spi_mosi_o
    ,output [  7:0]  spi_cs_o
    ,output          uart_tx_o
    ,output [ 31:0]  gpio_output_o
    ,output [ 31:0]  gpio_output_enable_o
);

wire  [  3:0]  axi_t_awid_w;
wire           axi_l_awvalid_w;
wire           axi_l_arvalid_w;
wire  [  1:0]  axi_i_bresp_w;
wire  [  1:0]  axi_l_bresp_w;
wire  [ 31:0]  axi_t_wdata_w;
wire           axi_t_rlast_w;
wire  [  3:0]  axi_i_wstrb_w;
wire  [ 31:0]  axi_t_rdata_w;
wire           axi_t_bvalid_w;
wire           axi_t_awready_w;
wire           axi_l_wvalid_w;
wire  [  3:0]  axi_t_arid_w;
wire  [ 31:0]  axi_t_awaddr_w;
wire  [  1:0]  axi_i_rresp_w;
wire  [  7:0]  axi_t_arlen_w;
wire           axi_l_bvalid_w;
wire           axi_i_wlast_w;
wire           axi_i_arready_w;
wire           axi_t_wvalid_w;
wire  [ 31:0]  axi_t_araddr_w;
wire  [  3:0]  axi_i_bid_w;
wire  [  1:0]  axi_t_rresp_w;
wire           axi_l_awready_w;
wire           axi_t_wlast_w;
wire  [ 31:0]  axi_l_rdata_w;
wire  [  1:0]  axi_i_awburst_w;
wire           axi_t_rvalid_w;
wire           axi_i_rvalid_w;
wire           axi_t_arvalid_w;
wire           axi_t_arready_w;
wire  [  1:0]  axi_i_arburst_w;
wire           axi_t_awvalid_w;
wire  [  7:0]  axi_i_arlen_w;
wire           axi_l_rready_w;
wire  [  1:0]  axi_l_rresp_w;
wire  [ 31:0]  axi_i_rdata_w;
wire           axi_i_rlast_w;
wire  [ 31:0]  cpu_intr_w;
wire  [  3:0]  axi_i_awid_w;
wire  [ 31:0]  axi_l_awaddr_w;
wire  [  7:0]  axi_t_awlen_w;
wire           axi_i_wready_w;
wire  [ 31:0]  axi_l_wdata_w;
wire  [ 31:0]  enable_w;
wire  [ 31:0]  axi_l_araddr_w;
wire  [  3:0]  axi_l_wstrb_w;
wire           soc_intr_w;
wire  [  1:0]  axi_t_arburst_w;
wire  [  1:0]  axi_t_awburst_w;
wire  [  3:0]  axi_i_rid_w;
wire  [  7:0]  axi_i_awlen_w;
wire           axi_l_wready_w;
wire           axi_i_arvalid_w;
wire           axi_l_bready_w;
wire  [ 31:0]  axi_i_awaddr_w;
wire           axi_t_rready_w;
wire           axi_i_bready_w;
wire  [ 31:0]  axi_i_wdata_w;
wire           axi_t_bready_w;
wire  [  3:0]  axi_i_arid_w;
wire           axi_i_bvalid_w;
wire           axi_l_rvalid_w;
wire  [  3:0]  axi_t_bid_w;
wire           axi_l_arready_w;
wire           axi_i_rready_w;
wire  [  3:0]  axi_t_wstrb_w;
wire  [  1:0]  axi_t_bresp_w;
wire           axi_i_wvalid_w;
wire           axi_i_awready_w;
wire           rst_cpu_w;
wire           axi_i_awvalid_w;
wire  [ 31:0]  axi_i_araddr_w;
wire           axi_t_wready_w;
wire  [  3:0]  axi_t_rid_w;


dbg_bridge
#(
     .CLK_FREQ(CLK_FREQ)
    ,.UART_SPEED(UART_SPEED)
)
u_dbg
(
    // Inputs
     .clk_i(clk_i)
    ,.rst_i(rst_i)
    ,.uart_rxd_i(dbg_txd_i)
    ,.mem_awready_i(axi_t_awready_w)
    ,.mem_wready_i(axi_t_wready_w)
    ,.mem_bvalid_i(axi_t_bvalid_w)
    ,.mem_bresp_i(axi_t_bresp_w)
    ,.mem_bid_i(axi_t_bid_w)
    ,.mem_arready_i(axi_t_arready_w)
    ,.mem_rvalid_i(axi_t_rvalid_w)
    ,.mem_rdata_i(axi_t_rdata_w)
    ,.mem_rresp_i(axi_t_rresp_w)
    ,.mem_rid_i(axi_t_rid_w)
    ,.mem_rlast_i(axi_t_rlast_w)
    ,.gpio_inputs_i(32'b0)

    // Outputs
    ,.uart_txd_o(dbg_rxd_o)
    ,.mem_awvalid_o(axi_t_awvalid_w)
    ,.mem_awaddr_o(axi_t_awaddr_w)
    ,.mem_awid_o(axi_t_awid_w)
    ,.mem_awlen_o(axi_t_awlen_w)
    ,.mem_awburst_o(axi_t_awburst_w)
    ,.mem_wvalid_o(axi_t_wvalid_w)
    ,.mem_wdata_o(axi_t_wdata_w)
    ,.mem_wstrb_o(axi_t_wstrb_w)
    ,.mem_wlast_o(axi_t_wlast_w)
    ,.mem_bready_o(axi_t_bready_w)
    ,.mem_arvalid_o(axi_t_arvalid_w)
    ,.mem_araddr_o(axi_t_araddr_w)
    ,.mem_arid_o(axi_t_arid_w)
    ,.mem_arlen_o(axi_t_arlen_w)
    ,.mem_arburst_o(axi_t_arburst_w)
    ,.mem_rready_o(axi_t_rready_w)
    ,.gpio_outputs_o(enable_w)
);


axi4_axi4lite_conv
u_conv
(
    // Inputs
     .clk_i(clk_i)
    ,.rst_i(rst_i)
    ,.inport_awvalid_i(axi_i_awvalid_w)
    ,.inport_awaddr_i(axi_i_awaddr_w)
    ,.inport_awid_i(axi_i_awid_w)
    ,.inport_awlen_i(axi_i_awlen_w)
    ,.inport_awburst_i(axi_i_awburst_w)
    ,.inport_wvalid_i(axi_i_wvalid_w)
    ,.inport_wdata_i(axi_i_wdata_w)
    ,.inport_wstrb_i(axi_i_wstrb_w)
    ,.inport_wlast_i(axi_i_wlast_w)
    ,.inport_bready_i(axi_i_bready_w)
    ,.inport_arvalid_i(axi_i_arvalid_w)
    ,.inport_araddr_i(axi_i_araddr_w)
    ,.inport_arid_i(axi_i_arid_w)
    ,.inport_arlen_i(axi_i_arlen_w)
    ,.inport_arburst_i(axi_i_arburst_w)
    ,.inport_rready_i(axi_i_rready_w)
    ,.outport_awready_i(axi_l_awready_w)
    ,.outport_wready_i(axi_l_wready_w)
    ,.outport_bvalid_i(axi_l_bvalid_w)
    ,.outport_bresp_i(axi_l_bresp_w)
    ,.outport_arready_i(axi_l_arready_w)
    ,.outport_rvalid_i(axi_l_rvalid_w)
    ,.outport_rdata_i(axi_l_rdata_w)
    ,.outport_rresp_i(axi_l_rresp_w)

    // Outputs
    ,.inport_awready_o(axi_i_awready_w)
    ,.inport_wready_o(axi_i_wready_w)
    ,.inport_bvalid_o(axi_i_bvalid_w)
    ,.inport_bresp_o(axi_i_bresp_w)
    ,.inport_bid_o(axi_i_bid_w)
    ,.inport_arready_o(axi_i_arready_w)
    ,.inport_rvalid_o(axi_i_rvalid_w)
    ,.inport_rdata_o(axi_i_rdata_w)
    ,.inport_rresp_o(axi_i_rresp_w)
    ,.inport_rid_o(axi_i_rid_w)
    ,.inport_rlast_o(axi_i_rlast_w)
    ,.outport_awvalid_o(axi_l_awvalid_w)
    ,.outport_awaddr_o(axi_l_awaddr_w)
    ,.outport_wvalid_o(axi_l_wvalid_w)
    ,.outport_wdata_o(axi_l_wdata_w)
    ,.outport_wstrb_o(axi_l_wstrb_w)
    ,.outport_bready_o(axi_l_bready_w)
    ,.outport_arvalid_o(axi_l_arvalid_w)
    ,.outport_araddr_o(axi_l_araddr_w)
    ,.outport_rready_o(axi_l_rready_w)
);

generate 
if (CPU == "riscv")
begin
    riscv_tcm_wrapper
    u_cpu
    (
        // Inputs
         .clk_i(clk_i)
        ,.rst_i(rst_i)
        ,.rst_cpu_i(rst_cpu_w)
        ,.axi_i_awready_i(axi_i_awready_w)
        ,.axi_i_wready_i(axi_i_wready_w)
        ,.axi_i_bvalid_i(axi_i_bvalid_w)
        ,.axi_i_bresp_i(axi_i_bresp_w)
        ,.axi_i_bid_i(axi_i_bid_w)
        ,.axi_i_arready_i(axi_i_arready_w)
        ,.axi_i_rvalid_i(axi_i_rvalid_w)
        ,.axi_i_rdata_i(axi_i_rdata_w)
        ,.axi_i_rresp_i(axi_i_rresp_w)
        ,.axi_i_rid_i(axi_i_rid_w)
        ,.axi_i_rlast_i(axi_i_rlast_w)
        ,.axi_t_awvalid_i(axi_t_awvalid_w)
        ,.axi_t_awaddr_i(axi_t_awaddr_w)
        ,.axi_t_awid_i(axi_t_awid_w)
        ,.axi_t_awlen_i(axi_t_awlen_w)
        ,.axi_t_awburst_i(axi_t_awburst_w)
        ,.axi_t_wvalid_i(axi_t_wvalid_w)
        ,.axi_t_wdata_i(axi_t_wdata_w)
        ,.axi_t_wstrb_i(axi_t_wstrb_w)
        ,.axi_t_wlast_i(axi_t_wlast_w)
        ,.axi_t_bready_i(axi_t_bready_w)
        ,.axi_t_arvalid_i(axi_t_arvalid_w)
        ,.axi_t_araddr_i(axi_t_araddr_w)
        ,.axi_t_arid_i(axi_t_arid_w)
        ,.axi_t_arlen_i(axi_t_arlen_w)
        ,.axi_t_arburst_i(axi_t_arburst_w)
        ,.axi_t_rready_i(axi_t_rready_w)
        ,.intr_i(cpu_intr_w)

        // Outputs
        ,.axi_i_awvalid_o(axi_i_awvalid_w)
        ,.axi_i_awaddr_o(axi_i_awaddr_w)
        ,.axi_i_awid_o(axi_i_awid_w)
        ,.axi_i_awlen_o(axi_i_awlen_w)
        ,.axi_i_awburst_o(axi_i_awburst_w)
        ,.axi_i_wvalid_o(axi_i_wvalid_w)
        ,.axi_i_wdata_o(axi_i_wdata_w)
        ,.axi_i_wstrb_o(axi_i_wstrb_w)
        ,.axi_i_wlast_o(axi_i_wlast_w)
        ,.axi_i_bready_o(axi_i_bready_w)
        ,.axi_i_arvalid_o(axi_i_arvalid_w)
        ,.axi_i_araddr_o(axi_i_araddr_w)
        ,.axi_i_arid_o(axi_i_arid_w)
        ,.axi_i_arlen_o(axi_i_arlen_w)
        ,.axi_i_arburst_o(axi_i_arburst_w)
        ,.axi_i_rready_o(axi_i_rready_w)
        ,.axi_t_awready_o(axi_t_awready_w)
        ,.axi_t_wready_o(axi_t_wready_w)
        ,.axi_t_bvalid_o(axi_t_bvalid_w)
        ,.axi_t_bresp_o(axi_t_bresp_w)
        ,.axi_t_bid_o(axi_t_bid_w)
        ,.axi_t_arready_o(axi_t_arready_w)
        ,.axi_t_rvalid_o(axi_t_rvalid_w)
        ,.axi_t_rdata_o(axi_t_rdata_w)
        ,.axi_t_rresp_o(axi_t_rresp_w)
        ,.axi_t_rid_o(axi_t_rid_w)
        ,.axi_t_rlast_o(axi_t_rlast_w)
    );
end
else
begin
    cortex_m0_wrapper
    u_cpu
    (
        // Inputs
         .clk_i(clk_i)
        ,.rst_i(rst_i)
        ,.rst_cpu_i(rst_cpu_w)
        ,.axi_i_awready_i(axi_i_awready_w)
        ,.axi_i_wready_i(axi_i_wready_w)
        ,.axi_i_bvalid_i(axi_i_bvalid_w)
        ,.axi_i_bresp_i(axi_i_bresp_w)
        ,.axi_i_bid_i(axi_i_bid_w)
        ,.axi_i_arready_i(axi_i_arready_w)
        ,.axi_i_rvalid_i(axi_i_rvalid_w)
        ,.axi_i_rdata_i(axi_i_rdata_w)
        ,.axi_i_rresp_i(axi_i_rresp_w)
        ,.axi_i_rid_i(axi_i_rid_w)
        ,.axi_i_rlast_i(axi_i_rlast_w)
        ,.axi_t_awvalid_i(axi_t_awvalid_w)
        ,.axi_t_awaddr_i(axi_t_awaddr_w)
        ,.axi_t_awid_i(axi_t_awid_w)
        ,.axi_t_awlen_i(axi_t_awlen_w)
        ,.axi_t_awburst_i(axi_t_awburst_w)
        ,.axi_t_wvalid_i(axi_t_wvalid_w)
        ,.axi_t_wdata_i(axi_t_wdata_w)
        ,.axi_t_wstrb_i(axi_t_wstrb_w)
        ,.axi_t_wlast_i(axi_t_wlast_w)
        ,.axi_t_bready_i(axi_t_bready_w)
        ,.axi_t_arvalid_i(axi_t_arvalid_w)
        ,.axi_t_araddr_i(axi_t_araddr_w)
        ,.axi_t_arid_i(axi_t_arid_w)
        ,.axi_t_arlen_i(axi_t_arlen_w)
        ,.axi_t_arburst_i(axi_t_arburst_w)
        ,.axi_t_rready_i(axi_t_rready_w)
        ,.intr_i(cpu_intr_w)

        // Outputs
        ,.axi_i_awvalid_o(axi_i_awvalid_w)
        ,.axi_i_awaddr_o(axi_i_awaddr_w)
        ,.axi_i_awid_o(axi_i_awid_w)
        ,.axi_i_awlen_o(axi_i_awlen_w)
        ,.axi_i_awburst_o(axi_i_awburst_w)
        ,.axi_i_wvalid_o(axi_i_wvalid_w)
        ,.axi_i_wdata_o(axi_i_wdata_w)
        ,.axi_i_wstrb_o(axi_i_wstrb_w)
        ,.axi_i_wlast_o(axi_i_wlast_w)
        ,.axi_i_bready_o(axi_i_bready_w)
        ,.axi_i_arvalid_o(axi_i_arvalid_w)
        ,.axi_i_araddr_o(axi_i_araddr_w)
        ,.axi_i_arid_o(axi_i_arid_w)
        ,.axi_i_arlen_o(axi_i_arlen_w)
        ,.axi_i_arburst_o(axi_i_arburst_w)
        ,.axi_i_rready_o(axi_i_rready_w)
        ,.axi_t_awready_o(axi_t_awready_w)
        ,.axi_t_wready_o(axi_t_wready_w)
        ,.axi_t_bvalid_o(axi_t_bvalid_w)
        ,.axi_t_bresp_o(axi_t_bresp_w)
        ,.axi_t_bid_o(axi_t_bid_w)
        ,.axi_t_arready_o(axi_t_arready_w)
        ,.axi_t_rvalid_o(axi_t_rvalid_w)
        ,.axi_t_rdata_o(axi_t_rdata_w)
        ,.axi_t_rresp_o(axi_t_rresp_w)
        ,.axi_t_rid_o(axi_t_rid_w)
        ,.axi_t_rlast_o(axi_t_rlast_w)
    );
end
endgenerate

core_soc
#(
     .CLK_FREQ(CLK_FREQ)
    ,.BAUDRATE(BAUDRATE)
    ,.C_SCK_RATIO(C_SCK_RATIO)
)
u_soc
(
    // Inputs
     .clk_i(clk_i)
    ,.rst_i(rst_i)
    ,.inport_awvalid_i(axi_l_awvalid_w)
    ,.inport_awaddr_i(axi_l_awaddr_w)
    ,.inport_wvalid_i(axi_l_wvalid_w)
    ,.inport_wdata_i(axi_l_wdata_w)
    ,.inport_wstrb_i(axi_l_wstrb_w)
    ,.inport_bready_i(axi_l_bready_w)
    ,.inport_arvalid_i(axi_l_arvalid_w)
    ,.inport_araddr_i(axi_l_araddr_w)
    ,.inport_rready_i(axi_l_rready_w)
    ,.spi_miso_i(spi_miso_i)
    ,.uart_rx_i(uart_rx_i)
    ,.gpio_input_i(gpio_input_i)

    // Outputs
    ,.intr_o(soc_intr_w)
    ,.inport_awready_o(axi_l_awready_w)
    ,.inport_wready_o(axi_l_wready_w)
    ,.inport_bvalid_o(axi_l_bvalid_w)
    ,.inport_bresp_o(axi_l_bresp_w)
    ,.inport_arready_o(axi_l_arready_w)
    ,.inport_rvalid_o(axi_l_rvalid_w)
    ,.inport_rdata_o(axi_l_rdata_w)
    ,.inport_rresp_o(axi_l_rresp_w)
    ,.spi_clk_o(spi_clk_o)
    ,.spi_mosi_o(spi_mosi_o)
    ,.spi_cs_o(spi_cs_o)
    ,.uart_tx_o(uart_tx_o)
    ,.gpio_output_o(gpio_output_o)
    ,.gpio_output_enable_o(gpio_output_enable_o)
);


assign rst_cpu_w       = ~enable_w[0];
assign cpu_intr_w      = {31'b0, soc_intr_w};


endmodule
