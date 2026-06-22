`timescale 1ns / 1ps

import uvm_pkg::*;
`include "uvm_macros.svh"

`include "apb_transaction.sv"
`include "apb_sequence.sv"
`include "apb_sequencer.sv"
`include "apb_driver.sv"
`include "apb_monitor.sv"
`include "apb_scoreboard.sv"
`include "apb_agent.sv"
`include "apb_env.sv"
`include "apb_base_test.sv"

interface apb_if;
  logic        PCLK;
  logic        PRESETn;
  logic        PSEL;
  logic        PENABLE;
  logic        PWRITE;
  logic [31:0] PADDR;
  logic [31:0] PWDATA;
  logic [31:0] PRDATA;
  logic        PREADY;
endinterface

module tb;
  apb_if dut_if();

  // clock
  initial dut_if.PCLK = 0;
  always #5 dut_if.PCLK = ~dut_if.PCLK;

  // reset
  initial begin
    dut_if.PRESETn = 1;
  end

  // instantiate slave DUT
  apb_slave dut (
    .PCLK    (dut_if.PCLK),
    .PRESETn (dut_if.PRESETn),
    .PSEL    (dut_if.PSEL),
    .PENABLE (dut_if.PENABLE),
    .PWRITE  (dut_if.PWRITE),
    .PADDR   (dut_if.PADDR),
    .PWDATA  (dut_if.PWDATA),
    .PRDATA  (dut_if.PRDATA),
    .PREADY  (dut_if.PREADY)
  );

  initial begin
    uvm_config_db #(virtual apb_if)::set(null, "uvm_test_top.*", "vif", dut_if);
    run_test("apb_base_test");
  end
endmodule
