
set_part XC7A100TCSG324-1
create_ip -name mig_7series -dir ../ip -vendor xilinx.com -library ip -version 4.2 -module_name mig_7series_0
exec cp ../ip/mig.prj ../ip/mig_7series_0/
set_property -dict [list CONFIG.XML_INPUT_FILE {mig.prj}] [get_ips mig_7series_0]

generate_target {instantiation_template} [get_files ./src/ip/mig_7series_0/mig_7series_0.xci]
generate_target all [get_files ../ip/mig_7series_0/mig_7series_0.xci]
synth_ip [get_ips mig_7series_0] 