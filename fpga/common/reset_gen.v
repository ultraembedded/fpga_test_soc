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
module reset_gen
(
    input  clk_i,
    output rst_o
);

reg [3:0] count_q = 4'b0;
reg       rst_q   = 1'b1;

always @(posedge clk_i) 
if (count_q != 4'hF)
    count_q <= count_q + 4'd1;
else
    rst_q <= 1'b0;

assign rst_o = rst_q;

endmodule