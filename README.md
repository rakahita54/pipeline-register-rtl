# Single Stage Pipeline Register (Valid/Ready Handshake)

## Overview
This project implements a single-stage pipeline register in SystemVerilog using a standard valid/ready handshake protocol.

The module accepts input data when both valid and ready are asserted and forwards it to the downstream interface while handling backpressure correctly.

## Features
* Parameterized data width
* Fully synthesizable RTL
* Proper reset handling
* Backpressure support
* SystemVerilog assertions for protocol checking
* QuestaSim simulation
* Waveform verification

## Directory Structure
rtl/  -> RTL design  
testbench/   -> Testbench  
sim/  -> Simulation waveform screenshots  
run.do -> Simulation automation script  

## Interface Signals

### Inputs
* clk
* rst_n
* in_data
* in_valid
* out_ready

### Outputs
* in_ready
* out_data
* out_valid

## Transfer Rule
Data transfer occurs when: 
in_valid && in_ready

## Verification
The testbench verifies:
* Normal data transfer
* Backpressure stall handling
* Streaming operation
* Reset behavior

Waveforms demonstrate correct pipeline delay and protocol compliance.

## Author
Rakshita Y Kamadolli
