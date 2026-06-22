`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.06.2026 10:33:40
// Design Name: 
// Module Name: apb_driver
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







class apb_driver extends uvm_driver #(apb_transaction);

  `uvm_component_utils(apb_driver)

  virtual apb_if vif;

  function new(string name="apb_driver", uvm_component parent=null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
  super.build_phase(phase);
  if (!uvm_config_db #(virtual apb_if)::get(this, "", "vif", vif))
    `uvm_fatal("DRIVER", "No virtual interface in config_db!")
endfunction
  task run_phase(uvm_phase phase);

    apb_transaction req;

    forever begin

      seq_item_port.get_next_item(req);

      vif.PADDR  <= req.addr;
      vif.PWDATA <= req.data;
      vif.PWRITE <= req.write;

      vif.PSEL    <= 1'b1;
      vif.PENABLE <= 1'b0;

      @(posedge vif.PCLK);

      vif.PENABLE <= 1'b1;

      @(posedge vif.PCLK);

      `uvm_info("DRIVER",
        $sformatf("APB Drive -> PADDR=%0h PWDATA=%0h PWRITE=%0b",
                  req.addr, req.data, req.write),
        UVM_LOW)

      vif.PSEL    <= 1'b0;
      vif.PENABLE <= 1'b0;

      seq_item_port.item_done();

    end

  endtask

endclass