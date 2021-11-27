// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.2 (lin64) Build 3064766 Wed Nov 18 09:12:47 MST 2020
// Date        : Sat Nov 27 13:05:32 2021
// Host        : marco running 64-bit Ubuntu 21.10
// Command     : write_verilog -force -mode synth_stub
//               /home/marco/entwicklung/projekte/arty7-sdram/ip/clk_wiz_test/clk_wiz_test_stub.v
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
