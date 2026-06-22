`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.06.2026 15:02:14
// Design Name: 
// Module Name: apb_monitor
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

class apb_monitor extends uvm_monitor;
  `uvm_component_utils(apb_monitor)

  virtual apb_if vif;
  uvm_analysis_port #(apb_transaction) ap;

  function new(string name="apb_monitor", uvm_component parent=null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    ap = new("ap", this);
    if (!uvm_config_db #(virtual apb_if)::get(this, "", "vif", vif))
      `uvm_fatal("MONITOR", "No virtual interface found in config_db!")
  endfunction

  task run_phase(uvm_phase phase);
    apb_transaction trans;
    forever begin
      @(posedge vif.PCLK);
      if (vif.PSEL && vif.PENABLE && vif.PREADY) begin
        trans = apb_transaction::type_id::create("trans");
        trans.addr  = vif.PADDR;
        trans.data  = vif.PWDATA;
        trans.write = vif.PWRITE;
        trans.rdata = vif.PRDATA;
        `uvm_info("MONITOR",
          $sformatf("Observed -> PADDR=%0h PWDATA=%0h PRDATA=%0h PWRITE=%0b",
                    trans.addr, trans.data, trans.rdata, trans.write),
          UVM_LOW)
        ap.write(trans);
      end
    end
  endtask

endclass
