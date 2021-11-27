set outputDir ./output             

#Program Device
open_hw_manager
connect_hw_server -allow_non_jtag
open_hw_target


# Program and Refresh the XC7A100TCSG324 Device
set FPGA [get_hw_devices xc7a100t_0]
current_hw_device $FPGA
refresh_hw_device -update_hw_probes false [lindex $FPGA 0]
set_property PROBES.FILE {} $FPGA
set_property FULL_PROBES.FILE {} $FPGA
set_property PROGRAM.FILE {./output/top.bit} $FPGA

program_hw_devices $FPGA
refresh_hw_device [lindex $FPGA 0]

disconnect_hw_server



