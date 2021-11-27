set_part XC7A100TCSG324-1

create_ip -name clk_wiz -dir ../ip -vendor xilinx.com -library ip -version 6.0 -module_name clk_wiz_test
set_property -dict [list CONFIG.CLKOUT2_USED {true} CONFIG.CLKOUT3_USED {true} CONFIG.CLK_OUT1_PORT {clk_100_o} CONFIG.CLK_OUT2_PORT {clk_166_o} CONFIG.CLK_OUT3_PORT {clk_200_o} CONFIG.CLKOUT2_REQUESTED_OUT_FREQ {167} CONFIG.CLKOUT3_REQUESTED_OUT_FREQ {200} CONFIG.MMCM_CLKOUT1_DIVIDE {6} CONFIG.MMCM_CLKOUT2_DIVIDE {5} CONFIG.NUM_OUT_CLKS {3} CONFIG.CLKOUT2_JITTER {118.758} CONFIG.CLKOUT2_PHASE_ERROR {98.575} CONFIG.CLKOUT3_JITTER {114.829} CONFIG.CLKOUT3_PHASE_ERROR {98.575}] [get_ips clk_wiz_test]

generate_target {instantiation_template} [get_files ./src/ip/clk_wiz_test/clk_wiz_test.xci]
update_compile_order
generate_target all [get_files ./src/ip/clk_wiz_test/clk_wiz_test.xci]
catch { config_ip_cache -export [get_ips -all clk_wiz_test] }
synth_ip [get_ips clk_wiz_test] 