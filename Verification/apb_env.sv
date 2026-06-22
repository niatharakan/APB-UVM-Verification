`timescale 1ns / 1ps

import uvm_pkg::*;
`include "uvm_macros.svh"

class apb_env extends uvm_env;
  `uvm_component_utils(apb_env)

  apb_agent      agent;
  apb_scoreboard sb;

  function new(string name="apb_env", uvm_component parent=null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    agent = apb_agent::type_id::create("agent", this);
    sb    = apb_scoreboard::type_id::create("sb", this);
    `uvm_info("ENV", "APB Env built", UVM_LOW)
  endfunction

  function void connect_phase(uvm_phase phase);
    agent.mon.ap.connect(sb.analysis_export);
  endfunction
endclass
