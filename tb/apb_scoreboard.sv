`timescale 1ns / 1ps


import uvm_pkg::*;
`include "uvm_macros.svh"

class apb_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(apb_scoreboard)

  uvm_analysis_imp #(apb_transaction, apb_scoreboard) analysis_export;

  // shadow memory - mirrors the slave's internal mem[0:15]
  bit [31:0] shadow_mem [bit [31:0]];

  int unsigned write_count;
  int unsigned read_count;
  int unsigned pass_count;
  int unsigned fail_count;

  function new(string name="apb_scoreboard", uvm_component parent=null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    analysis_export = new("analysis_export", this);
  endfunction

  function void write(apb_transaction trans);
    if (trans.write) begin
      // store in shadow memory
      shadow_mem[trans.addr] = trans.data;
      write_count++;
      `uvm_info("SCOREBOARD",
        $sformatf("WRITE -> PADDR=%0h PWDATA=%0h  [stored in shadow]",
                  trans.addr, trans.data),
        UVM_LOW)
    end else begin
      read_count++;
      if (shadow_mem.exists(trans.addr)) begin
        // address was written before - check PRDATA
        if (trans.rdata === shadow_mem[trans.addr]) begin
          pass_count++;
          `uvm_info("SCOREBOARD",
            $sformatf("PASS -> PADDR=%0h Expected=%0h Got=%0h",
                      trans.addr, shadow_mem[trans.addr], trans.rdata),
            UVM_LOW)
        end else begin
          fail_count++;
          `uvm_error("SCOREBOARD",
            $sformatf("FAIL -> PADDR=%0h Expected=%0h Got=%0h",
                      trans.addr, shadow_mem[trans.addr], trans.rdata))
        end
      end else begin
        // address never written - expect 0
        if (trans.rdata === 32'h0) begin
          pass_count++;
          `uvm_info("SCOREBOARD",
            $sformatf("PASS -> PADDR=%0h unwritten addr returns 0",
                      trans.addr),
            UVM_LOW)
        end else begin
          fail_count++;
          `uvm_error("SCOREBOARD",
            $sformatf("FAIL -> PADDR=%0h expected 0 for unwritten addr, Got=%0h",
                      trans.addr, trans.rdata))
        end
      end
    end
  endfunction

  function void report_phase(uvm_phase phase);
    `uvm_info("SCOREBOARD",
      $sformatf("Test done. Writes=%0d Reads=%0d PASS=%0d FAIL=%0d",
                write_count, read_count, pass_count, fail_count),
      UVM_LOW)
    if (fail_count > 0)
      `uvm_error("SCOREBOARD", "TEST FAILED")
    else
      `uvm_info("SCOREBOARD", "TEST PASSED", UVM_LOW)
  endfunction

endclass
