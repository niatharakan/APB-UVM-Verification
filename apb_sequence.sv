`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.06.2026 12:29:51
// Design Name: 
// Module Name: apb_sequence
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



import uvm_pkg::*;
`include "uvm_macros.svh"

class apb_sequence extends uvm_sequence #(apb_transaction);
  `uvm_object_utils(apb_sequence)

  function new(string name="apb_sequence");
    super.new(name);
  endfunction

  task body();
    apb_transaction req;
    bit [31:0] saved_addr [0:2];
    bit [31:0] saved_data [0:2];
    int i;

    // 3 randomised writes to random word-aligned addresses within mem[0:15]
    for (i = 0; i < 3; i++) begin
      req = apb_transaction::type_id::create("req");
      start_item(req);
      assert(req.randomize() with {
        write == 1;
        addr[5:2] inside {[0:15]};
      });
      finish_item(req);

      // remember what we wrote so we can read it back correctly
      saved_addr[i] = req.addr;
      saved_data[i] = req.data;
    end

    // 3 reads back from the same addresses we just wrote to
    for (i = 0; i < 3; i++) begin
      req = apb_transaction::type_id::create("req");
      start_item(req);
      req.addr  = saved_addr[i];
      req.write = 0;
      req.data  = 32'h0;   // no data on a read, keep it clean
      finish_item(req);
    end

  endtask
endclass