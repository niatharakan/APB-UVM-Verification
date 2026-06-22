`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.06.2026 10:26:41
// Design Name: 
// Module Name: apb_transaction
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


class apb_transaction extends uvm_sequence_item;
  rand bit [31:0] addr;
  rand bit [31:0] data;
  rand bit        write;
  bit      [31:0] rdata;  // not rand - filled by monitor on reads

  constraint addr_align { addr[1:0] == 2'b00; }

  `uvm_object_utils(apb_transaction)

  function new(string name="apb_transaction");
    super.new(name);
  endfunction

  function void do_print(uvm_printer printer);
    super.do_print(printer);
    printer.print_field_int("addr",  addr,  32, UVM_HEX);
    printer.print_field_int("data",  data,  32, UVM_HEX);
    printer.print_field_int("write", write, 1,  UVM_DEC);
    printer.print_field_int("rdata", rdata, 32, UVM_HEX);
  endfunction
endclass