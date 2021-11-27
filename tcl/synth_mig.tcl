
set_part XC7A100TCSG324-1

# create_ip -name clk_wiz -dir ./src/ip -vendor xilinx.com -library ip -version 6.0 -module_name clk_wiz_test
# set_property -dict [list CONFIG.Component_Name {clk_wiz_test} CONFIG.CLKOUT1_REQUESTED_OUT_FREQ {25} CONFIG.MMCM_CLKFBOUT_MULT_F {10.000} CONFIG.MMCM_CLKOUT0_DIVIDE_F {40.000} CONFIG.MMCM_CLKOUT1_DIVIDE {10} CONFIG.CLKOUT1_JITTER {175.402} CONFIG.CLKOUT1_PHASE_ERROR {98.575} CONFIG.CLKOUT2_JITTER {130.958} CONFIG.CLKOUT2_PHASE_ERROR {98.575}] [get_ips clk_wiz_test]

# generate_target {instantiation_template} [get_files ./src/ip/clk_wiz_test/clk_wiz_test.xci]
# update_compile_order
# generate_target all [get_files ./src/ip/clk_wiz_test/clk_wiz_test.xci]
# catch { config_ip_cache -export [get_ips -all clk_wiz_test] }
# synth_ip [get_ips clk_wiz_test] 


create_ip -name mig_7series -dir ./src/ip -vendor xilinx.com -library ip -version 4.2 -module_name mig_7series_1
exec cp mig.prj ./src/ip/mig_7series_1/
set_property -dict [list CONFIG.XML_INPUT_FILE {mig.prj}] [get_ips mig_7series_1]

generate_target {instantiation_template} [get_files ./src/ip/mig_7series_1/mig_7series_1.xci]
generate_target all [get_files ./src/ip/mig_7series_1/mig_7series_1.xci]
synth_ip [get_ips mig_7series_1] 