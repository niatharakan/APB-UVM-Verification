`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.06.2026 16:12:36
// Design Name: 
// Module Name: apb_agent
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

class apb_agent extends uvm_agent;
  `uvm_component_utils(apb_agent)

  apb_driver    drv;
  apb_sequencer seqr;
  apb_monitor   mon;

  function new(string name="apb_agent", uvm_component parent=null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    drv  = apb_driver::type_id::create("drv", this);
    seqr = apb_sequencer::type_id::create("seqr", this);
    mon  = apb_monitor::type_id::create("mon", this);
    `uvm_info("AGENT", "APB Agent built", UVM_LOW)
  endfunction

  function void connect_phase(uvm_phase phase);
    drv.seq_item_port.connect(seqr.seq_item_export);
  endfunction
endclass