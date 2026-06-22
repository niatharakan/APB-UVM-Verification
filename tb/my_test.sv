`timescale 1ns / 1ps

class my_test extends uvm_test;
  `uvm_component_utils(my_test)

  apb_env env;
  apb_sequence seq;

  function new(string name="my_test", uvm_component parent=null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = apb_env::type_id::create("env", this);
    `uvm_info("TEST", "Test build completed", UVM_LOW)
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    seq = apb_sequence::type_id::create("seq");
    `uvm_info("TEST", "Starting APB sequence", UVM_LOW)
    seq.start(env.agent.seqr);
    phase.drop_objection(this);
  endtask
endclass
