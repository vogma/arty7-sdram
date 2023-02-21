// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.2 (lin64) Build 3064766 Wed Nov 18 09:12:47 MST 2020
// Date        : Mon Feb 20 21:11:03 2023
// Host        : xps running 64-bit Ubuntu 22.04.1 LTS
// Command     : write_verilog -force -mode synth_stub
//               /home/marco/entwicklung/fpga/arty7-sdram/ip/new/clk/output/clk_wiz_test_stub.v
// Design      : clk_wiz_test
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module clk_wiz_test(clk_100_o, clk_166_o, clk_200_o, reset, locked, 
  clk_in1)
/* synthesis syn_black_box black_box_pad_pin="clk_100_o,clk_166_o,clk_200_o,reset,locked,clk_in1" */;
  output clk_100_o;
  output clk_166_o;
  output clk_200_o;
  input reset;
  output locked;
  input clk_in1;
endmodule
