`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.06.2026 16:22:36
// Design Name: 
// Module Name: apb_slave
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


module apb_slave (
  input  logic        PCLK,
  input  logic        PRESETn,
  input  logic        PSEL,
  input  logic        PENABLE,
  input  logic        PWRITE,
  input  logic [31:0] PADDR,
  input  logic [31:0] PWDATA,
  output wire  [31:0] PRDATA,
  output wire         PREADY
);
  logic [31:0] mem [0:15];

  assign PREADY = PSEL && PENABLE;
  assign PRDATA = (PSEL && PENABLE && !PWRITE) ? mem[PADDR[5:2]] : 32'h0;

  always_ff @(posedge PCLK or negedge PRESETn) begin
    if (!PRESETn) begin
      // memory will be X on reset which is fine
    end else begin
      if (PSEL && PENABLE && PWRITE)
        mem[PADDR[5:2]] <= PWDATA;
    end
  end

endmodule
