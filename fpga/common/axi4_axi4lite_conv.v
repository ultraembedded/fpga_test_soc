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

module axi4_axi4lite_conv
(
    // Inputs
     input           clk_i
    ,input           rst_i
    ,input           inport_awvalid_i
    ,input  [ 31:0]  inport_awaddr_i
    ,input  [  3:0]  inport_awid_i
    ,input  [  7:0]  inport_awlen_i
    ,input  [  1:0]  inport_awburst_i
    ,input           inport_wvalid_i
    ,input  [ 31:0]  inport_wdata_i
    ,input  [  3:0]  inport_wstrb_i
    ,input           inport_wlast_i
    ,input           inport_bready_i
    ,input           inport_arvalid_i
    ,input  [ 31:0]  inport_araddr_i
    ,input  [  3:0]  inport_arid_i
    ,input  [  7:0]  inport_arlen_i
    ,input  [  1:0]  inport_arburst_i
    ,input           inport_rready_i
    ,input           outport_awready_i
    ,input           outport_wready_i
    ,input           outport_bvalid_i
    ,input  [  1:0]  outport_bresp_i
    ,input           outport_arready_i
    ,input           outport_rvalid_i
    ,input  [ 31:0]  outport_rdata_i
    ,input  [  1:0]  outport_rresp_i

    // Outputs
    ,output          inport_awready_o
    ,output          inport_wready_o
    ,output          inport_bvalid_o
    ,output [  1:0]  inport_bresp_o
    ,output [  3:0]  inport_bid_o
    ,output          inport_arready_o
    ,output          inport_rvalid_o
    ,output [ 31:0]  inport_rdata_o
    ,output [  1:0]  inport_rresp_o
    ,output [  3:0]  inport_rid_o
    ,output          inport_rlast_o
    ,output          outport_awvalid_o
    ,output [ 31:0]  outport_awaddr_o
    ,output          outport_wvalid_o
    ,output [ 31:0]  outport_wdata_o
    ,output [  3:0]  outport_wstrb_o
    ,output          outport_bready_o
    ,output          outport_arvalid_o
    ,output [ 31:0]  outport_araddr_o
    ,output          outport_rready_o
);



//-----------------------------------------------------------------
// calculate_addr_next: AXI address calculation logic
//-----------------------------------------------------------------
function [31:0] calculate_addr_next;
    input  [31:0] addr;
    input  [1:0]  axtype;
    input  [7:0]  axlen;
    reg    [31:0] mask;
begin

    case (axtype)
    2'd0: // AXI4_BURST_FIXED
    begin
        calculate_addr_next = addr;
    end
    2'd2: // AXI4_BURST_WRAP
    begin
        case (axlen)
        8'd0:    mask = 32'h03;
        8'd1:    mask = 32'h07;
        8'd3:    mask = 32'h0F;
        8'd7:    mask = 32'h1F;
        8'd15:   mask = 32'h3F;
        default: mask = 32'h3F;
        endcase

        calculate_addr_next = (addr & ~mask) | ((addr + 32'd4) & mask);
    end
    default: // AXI4_BURST_INCR
        calculate_addr_next = addr + 32'd4;
    endcase
end
endfunction

//-----------------------------------------------------------------
// AXI logic
//-----------------------------------------------------------------
reg awvalid_mask_q;
reg wvalid_mask_q;
reg arvalid_mask_q;

reg awvalid_mask_r;
reg wvalid_mask_r;
reg arvalid_mask_r;
always @ *
begin
    awvalid_mask_r = awvalid_mask_q;
    wvalid_mask_r  = wvalid_mask_q;
    arvalid_mask_r = arvalid_mask_q;

    // (last) Write response provided to input port
    if (inport_bvalid_o && inport_bready_i)
    begin
        awvalid_mask_r = 1'b0;
        wvalid_mask_r  = 1'b0;
    end

    // Write address accept
    if (inport_awvalid_i && inport_awready_o)
        awvalid_mask_r = 1'b1;

    // Write data accept
    if (inport_wvalid_i && inport_wready_o)
        wvalid_mask_r = 1'b1;

    // (last) Read response provided to input port
    if (inport_rvalid_o && inport_rlast_o && inport_rready_i)
        arvalid_mask_r = 1'b0;

    // Read address accept
    if (inport_arvalid_i && inport_arready_o)
        arvalid_mask_r = 1'b1;
end

always @ (posedge clk_i )
if (rst_i)
begin
    awvalid_mask_q <= 1'b0;
    wvalid_mask_q  <= 1'b0;
    arvalid_mask_q <= 1'b0;
end
else
begin
    awvalid_mask_q <= awvalid_mask_r;
    wvalid_mask_q  <= wvalid_mask_r;
    arvalid_mask_q <= arvalid_mask_r;
end

reg        arvalid_q;
reg [31:0] araddr_q;
reg [7:0]  arcnt_q;
reg [3:0]  arid_q;
reg [7:0]  arlen_q;
reg [1:0]  arburst_q;

always @ (posedge clk_i )
if (rst_i)
begin
    arcnt_q    <= 8'b0;
    araddr_q   <= 32'd0;
    arvalid_q  <= 1'b0;
    arid_q     <= 4'b0;
    arlen_q    <= 8'b0;
    arburst_q  <= 2'b0;
end
else 
begin
    // AXI4-L request accept (or burst continuation)
    if (arvalid_q && outport_arvalid_o && outport_arready_i)
    begin
        araddr_q   <= calculate_addr_next(araddr_q, arburst_q, arlen_q);

        // Last tick in the burst
        if (arcnt_q == 8'd1)
            arvalid_q <= 1'b0;
            
        arcnt_q <= arcnt_q - 8'd1; 
    end
    // Read command accepted
    else if (inport_arvalid_i && inport_arready_o)
    begin
        arvalid_q  <= (inport_arlen_i != 8'b0);
        arcnt_q    <= inport_arlen_i;
        arlen_q    <= inport_arlen_i;
        arburst_q  <= inport_arburst_i;
        araddr_q   <= calculate_addr_next(inport_araddr_i, inport_arburst_i, inport_arlen_i);
        arid_q     <= inport_arid_i;
    end
end

reg        awvalid_q;
reg [31:0] awaddr_q;
reg [7:0]  awcnt_q;
reg [3:0]  awid_q;
reg [7:0]  awlen_q;
reg [1:0]  awburst_q;
reg        blast_q;

always @ (posedge clk_i )
if (rst_i)
begin
    awcnt_q    <= 8'b0;
    awaddr_q   <= 32'd0;
    awvalid_q  <= 1'b0;
    awid_q     <= 4'b0;
    awlen_q    <= 8'b0;
    awburst_q  <= 2'b0;
    blast_q    <= 1'b0;
end
else
begin
    // AXI4-L request accept (or burst continuation)
    // NOTE: This won't be presented until write data ready...
    if (awvalid_q && outport_awvalid_o && outport_awready_i)
    begin
        awaddr_q   <= calculate_addr_next(awaddr_q, awburst_q, awlen_q);

        // Last tick in the burst
        if (awcnt_q == 8'd1)
        begin
            awvalid_q <= 1'b0;
            blast_q   <= 1'b1;
        end
            
        awcnt_q <= awcnt_q - 8'd1; 
    end
    // Write command accepted
    else if (inport_awvalid_i && inport_awready_o)
    begin
        awid_q   <= inport_awid_i;

        // Data ready?
        if (inport_wvalid_i && inport_wready_o)
        begin
            awvalid_q  <= !inport_wlast_i;
            awcnt_q    <= inport_awlen_i;
            awaddr_q   <= calculate_addr_next(inport_awaddr_i, inport_awburst_i, inport_awlen_i);
            awlen_q    <= inport_awlen_i;
            awburst_q  <= inport_awburst_i;
            blast_q    <= inport_wlast_i;
        end
        // Data not ready
        else
        begin
            awvalid_q  <= 1'b1;
            awcnt_q    <= inport_awlen_i + 8'd1;
            awaddr_q   <= inport_awaddr_i;
            awlen_q    <= inport_awlen_i;
            awburst_q  <= inport_awburst_i;
            blast_q    <= 1'b0;
        end
    end
    // Reset last write response when accepted by input
    else if (inport_bvalid_o && inport_bready_i)
        blast_q <= 1'b0;
end

// NOTE: This IP expects AWREADY and WREADY to follow each other....
always @ (posedge clk_i )
if (rst_i)
begin
end
else if (outport_awvalid_o || outport_wvalid_o)
begin
    if (outport_awready_i != outport_wready_i)
    begin
        $display("ERROR: Unexpected flow control signals...");
    end
end

// Output port
assign outport_awvalid_o  = (inport_awvalid_i & inport_wvalid_i & !awvalid_mask_q) | (awvalid_q & inport_wvalid_i);
assign outport_awaddr_o   = awvalid_q ? awaddr_q : inport_awaddr_i;
assign outport_wvalid_o   = inport_wvalid_i;
assign outport_wdata_o    = inport_wdata_i;
assign outport_wstrb_o    = inport_wstrb_i;

assign outport_arvalid_o  = (inport_arvalid_i & !arvalid_mask_q) | arvalid_q;
assign outport_araddr_o   = arvalid_q ? araddr_q : inport_araddr_i;
assign outport_rready_o   = inport_rready_i;

assign inport_rvalid_o    = outport_rvalid_i;
assign inport_rdata_o     = outport_rdata_i;
assign inport_rid_o       = arid_q;
assign inport_rlast_o     = (arcnt_q == 8'd0);
assign inport_rresp_o     = outport_rresp_i;

assign inport_bvalid_o    = outport_bvalid_i & blast_q;
assign inport_bresp_o     = outport_bresp_i;
assign inport_bid_o       = awid_q;

assign outport_rready_o   = inport_rready_i;
assign outport_bready_o   = !blast_q || inport_bready_i;

// Handshaking
assign inport_awready_o = (outport_awready_i & !awvalid_mask_q);
assign inport_wready_o  = outport_wready_i;
assign inport_arready_o = (outport_arready_i & !arvalid_mask_q);



endmodule
