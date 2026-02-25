`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/30/2025 08:59:29 PM
// Design Name: 
// Module Name: 4_1_mux
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module mux4_to_1 (out, i0, i1, i2, i3, s1, s0);
    output out;
    input i0, i1, i2, i3;
    input s1, s0;
    wire s1n, s0n;
    wire y0, y1, y2, y3;

    // Invert select lines
    not (s1n, s1);
    not (s0n, s0);

    // AND gates for each input
    and (y0, i0, s1n, s0n); // when s1s0 = 00
    and (y1, i1, s1n, s0);     // when s1s0 = 01
    and (y2, i2, s1, s0n);     // when s1s0 = 10
    and (y3, i3, s1, s0);         // when s1s0 = 11

    // OR gate to combine all AND outputs
    or (out, y0, y1, y2, y3);
endmodule
