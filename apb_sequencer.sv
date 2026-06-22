`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.06.2026 12:00:42
// Design Name: 
// Module Name: apb_sequencer
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




class apb_sequencer extends uvm_sequencer #(apb_transaction);

  `uvm_component_utils(apb_sequencer)

  function new(string name="apb_sequencer", uvm_component parent=null);
    super.new(name, parent);
  endfunction

  // ? REMOVE build_phase printing (not useful here)

endclass