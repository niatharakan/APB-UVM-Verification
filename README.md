# APB UVM Verification Environment

## Overview

This project implements a UVM-based verification environment for an AMBA APB (Advanced Peripheral Bus) slave. The environment verifies APB read and write transactions, checks protocol compliance, and validates data integrity using a monitor and scoreboard architecture.

The project was developed using SystemVerilog and UVM and simulated in Vivado.

---

## APB Protocol

APB is a low-power, low-complexity bus protocol used for communication between processors and peripheral devices.

An APB transfer consists of two phases:

1. Setup Phase
   - PSEL = 1
   - PENABLE = 0
   - Address and control signals are driven

2. Access Phase
   - PENABLE = 1
   - Data transfer occurs
   - PREADY indicates completion

---



### Component Hierarchy

```
APB Base Test
      │
      ▼
    APB Env
      │
      ▼
   APB Agent
 ┌────┼────┐
 ▼    ▼    ▼
Seqr Driver Monitor

      DUT
       │
       ▼
 Scoreboard
```

---

## Transaction Flow

```
Sequence
   │
   ▼
Sequencer
   │
   ▼
Driver
   │
   ▼
APB Interface
   │
   ▼
APB Slave DUT
   │
   ▼
Monitor
   │
   ▼
Scoreboard
```

The sequence generates transactions, the driver converts them into APB bus activity, the monitor reconstructs completed transactions, and the scoreboard compares expected and observed behavior.


## Features

- APB Write Transaction Verification
- APB Read Transaction Verification
- UVM Sequence and Sequencer Architecture
- Driver-Based Bus Stimulus Generation
- Monitor-Based Transaction Reconstruction
- Scoreboard Data Checking
- Functional Simulation in Vivado
- Waveform-Based Debugging

---

## Tools Used

- SystemVerilog
- UVM (Universal Verification Methodology)
- Vivado Simulator

---

## Learning Outcomes

- Understanding of APB protocol operation
- UVM testbench architecture development
- Sequence and sequencer transaction flow
- Driver, monitor, and scoreboard implementation
- Waveform debugging and protocol analysis
- Functional verification methodology

---
