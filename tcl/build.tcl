set outputDir ./output             
file mkdir $outputDir

set_part XC7A100TCSG324-1

read_vhdl -library work [ glob ./src/uart/debounce.vhd ]  
read_vhdl -library work [ glob ./src/*.vhd ]  
read_vhdl -library work [glob ./src/sseg/*.vhd]
read_vhdl -library work [glob ./src/ddr/*.vhd]
#read_vhdl -library work [glob ./src/protocols/*.vhd]
#read_vhdl -library work [glob ./src/vga/*.vhd]
read_xdc ./constr/Arty-A7-100-Master.xdc       
read_ip ./src/ip/clk_wiz_test/clk_wiz_test.xci  
read_ip ./src/ip/blk_mem_gen_0_1/blk_mem_gen_0.xci  
read_ip ./src/ip/mig_7series_0/mig_7series_0.xci

synth_design -top top -part XC7A100TCSG324-1 -flatten rebuilt 
write_checkpoint -force $outputDir/post_synth
#report_timing_summary -file $outputDir/post_synth_timing_summary.rpt
#report_power -file $outputDir/post_synth_power.rpt

opt_design
power_opt_design
place_design
phys_opt_design
write_checkpoint -force $outputDir/post_place
#report_timing_summary -file $outputDir/post_place_timing_summary.rpt

route_design
write_checkpoint -force $outputDir/post_route
#report_timing_summary -file $outputDir/post_route_timing_summary.rpt
#report_timing -sort_by group -max_paths 100 -path_type summary -file $outputDir/post_route_timing.rpt
#report_clock_utilization -file $outputDir/clock_util.rpt
report_utilization -file $outputDir/post_route_util.rpt
#report_power -file $outputDir/post_route_power.rpt
#report_drc -file $outputDir/post_imp_drc.rpt
write_verilog -force $outputDir/top_impl_netlist.v
write_xdc -no_fixed_only -force $outputDir/top_impl.xdc

write_bitstream -force $outputDir/top.bit