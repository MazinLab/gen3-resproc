
################################################################
# This is a generated script based on design: phase_and_match
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

namespace eval _tcl {
proc get_script_folder {} {
   set script_path [file normalize [info script]]
   set script_folder [file dirname $script_path]
   return $script_folder
}
}
variable script_folder
set script_folder [_tcl::get_script_folder]

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2019.2
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   catch {common::send_msg_id "BD_TCL-109" "ERROR" "This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."}

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source phase_and_match_script.tcl

# If there is no project opened, this script will create a
# project, but make sure you do not have an existing project
# <./myproj/project_1.xpr> in the current working folder.

set list_projs [get_projects -quiet]
if { $list_projs eq "" } {
   create_project project_1 myproj -part xczu28dr-ffvg1517-2-e
   set_property BOARD_PART xilinx.com:zcu111:part0:1.1 [current_project]
}


# CHANGE DESIGN NAME HERE
variable design_name
set design_name phase_and_match

# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design $design_name

# Creating design if needed
set errMsg ""
set nRet 0

set cur_design [current_bd_design -quiet]
set list_cells [get_bd_cells -quiet]

if { ${design_name} eq "" } {
   # USE CASES:
   #    1) Design_name not set

   set errMsg "Please set the variable <design_name> to a non-empty value."
   set nRet 1

} elseif { ${cur_design} ne "" && ${list_cells} eq "" } {
   # USE CASES:
   #    2): Current design opened AND is empty AND names same.
   #    3): Current design opened AND is empty AND names diff; design_name NOT in project.
   #    4): Current design opened AND is empty AND names diff; design_name exists in project.

   if { $cur_design ne $design_name } {
      common::send_msg_id "BD_TCL-001" "INFO" "Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
      set design_name [get_property NAME $cur_design]
   }
   common::send_msg_id "BD_TCL-002" "INFO" "Constructing design in IPI design <$cur_design>..."

} elseif { ${cur_design} ne "" && $list_cells ne "" && $cur_design eq $design_name } {
   # USE CASES:
   #    5) Current design opened AND has components AND same names.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 1
} elseif { [get_files -quiet ${design_name}.bd] ne "" } {
   # USE CASES: 
   #    6) Current opened design, has components, but diff names, design_name exists in project.
   #    7) No opened design, design_name exists in project.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 2

} else {
   # USE CASES:
   #    8) No opened design, design_name not in project.
   #    9) Current opened design, has components, but diff names, design_name not in project.

   common::send_msg_id "BD_TCL-003" "INFO" "Currently there is no design <$design_name> in project, so creating one..."

   create_bd_design $design_name

   common::send_msg_id "BD_TCL-004" "INFO" "Making design <$design_name> as current_bd_design."
   current_bd_design $design_name

}

common::send_msg_id "BD_TCL-005" "INFO" "Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
   catch {common::send_msg_id "BD_TCL-114" "ERROR" $errMsg}
   return $nRet
}

set bCheckIPsPassed 1
##################################################################
# CHECK IPs
##################################################################
set bCheckIPs 1
if { $bCheckIPs == 1 } {
   set list_check_ips "\ 
xilinx.com:ip:cordic:6.0\
xilinx.com:ip:fir_compiler:7.2\
xilinx.com:ip:xlconcat:2.1\
"

   set list_ips_missing ""
   common::send_msg_id "BD_TCL-006" "INFO" "Checking if the following IPs exist in the project's IP catalog: $list_check_ips ."

   foreach ip_vlnv $list_check_ips {
      set ip_obj [get_ipdefs -all $ip_vlnv]
      if { $ip_obj eq "" } {
         lappend list_ips_missing $ip_vlnv
      }
   }

   if { $list_ips_missing ne "" } {
      catch {common::send_msg_id "BD_TCL-115" "ERROR" "The following IPs are not found in the IP Catalog:\n  $list_ips_missing\n\nResolution: Please add the repository containing the IP(s) to the project." }
      set bCheckIPsPassed 0
   }

}

if { $bCheckIPsPassed != 1 } {
  common::send_msg_id "BD_TCL-1003" "WARNING" "Will not continue with creation of design due to the error(s) above."
  return 3
}

##################################################################
# DESIGN PROCs
##################################################################



# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  variable script_folder
  variable design_name

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports
  set M_AXIS_MATCHEDPHASE512TDM [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M_AXIS_MATCHEDPHASE512TDM ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {524994750} \
   ] $M_AXIS_MATCHEDPHASE512TDM

  set S_AXIS_FIRCFG [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S_AXIS_FIRCFG ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {300000000} \
   CONFIG.HAS_TKEEP {0} \
   CONFIG.HAS_TLAST {0} \
   CONFIG.HAS_TREADY {1} \
   CONFIG.HAS_TSTRB {0} \
   CONFIG.LAYERED_METADATA {undef} \
   CONFIG.TDATA_NUM_BYTES {1} \
   CONFIG.TDEST_WIDTH {1} \
   CONFIG.TID_WIDTH {0} \
   CONFIG.TUSER_WIDTH {0} \
   ] $S_AXIS_FIRCFG

  set S_AXIS_IQ512TDM [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S_AXIS_IQ512TDM ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {524994750} \
   CONFIG.HAS_TKEEP {0} \
   CONFIG.HAS_TLAST {0} \
   CONFIG.HAS_TREADY {0} \
   CONFIG.HAS_TSTRB {0} \
   CONFIG.LAYERED_METADATA {undef} \
   CONFIG.TDATA_NUM_BYTES {4} \
   CONFIG.TDEST_WIDTH {0} \
   CONFIG.TID_WIDTH {0} \
   CONFIG.TUSER_WIDTH {9} \
   ] $S_AXIS_IQ512TDM


  # Create ports
  set ARESETN [ create_bd_port -dir I -type rst ARESETN ]
  set_property -dict [ list \
   CONFIG.POLARITY {ACTIVE_LOW} \
 ] $ARESETN
  set ARESETN_CFG [ create_bd_port -dir I -type rst ARESETN_CFG ]
  set S_AXIS_FIRCFG_aclk [ create_bd_port -dir I -type clk -freq_hz 300000000 S_AXIS_FIRCFG_aclk ]
  set S_AXIS_IQ512TDM_aclk [ create_bd_port -dir I -type clk -freq_hz 524994750 S_AXIS_IQ512TDM_aclk ]
  set filter_interrupts [ create_bd_port -dir O -from 6 -to 0 -type intr filter_interrupts ]

  # Create instance: arctan_phase, and set properties
  set arctan_phase [ create_bd_cell -type ip -vlnv xilinx.com:ip:cordic:6.0 arctan_phase ]
  set_property -dict [ list \
   CONFIG.Architectural_Configuration {Parallel} \
   CONFIG.Data_Format {SignedFraction} \
   CONFIG.Functional_Selection {Arc_Tan} \
   CONFIG.Output_Width {18} \
   CONFIG.Pipelining_Mode {Maximum} \
   CONFIG.cartesian_has_tuser {true} \
 ] $arctan_phase

  # Create instance: axis_interconnect_0, and set properties
  set axis_interconnect_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_interconnect:2.1 axis_interconnect_0 ]

  # Create instance: matched_filter_512x, and set properties
  set matched_filter_512x [ create_bd_cell -type ip -vlnv xilinx.com:ip:fir_compiler:7.2 matched_filter_512x ]
  set_property -dict [ list \
   CONFIG.BestPrecision {true} \
   CONFIG.Clock_Frequency {300.0} \
   CONFIG.CoefficientSource {COE_File} \
   CONFIG.CoefficientVector {6,0,-4,-3,5,6,-6,-13,7,44,64,44,7,-13,-6,6,5,-3,-4,0,6} \
   CONFIG.Coefficient_File {../../../../imports/ip/30-tap-256-rid-opt-match.coe} \
   CONFIG.Coefficient_Fractional_Bits {10} \
   CONFIG.Coefficient_Reload {true} \
   CONFIG.Coefficient_Sets {512} \
   CONFIG.Coefficient_Sign {Signed} \
   CONFIG.Coefficient_Structure {Inferred} \
   CONFIG.Coefficient_Width {18} \
   CONFIG.ColumnConfig {30} \
   CONFIG.DATA_Has_TLAST {Vector_Framing} \
   CONFIG.Filter_Architecture {Systolic_Multiply_Accumulate} \
   CONFIG.Filter_Selection {1} \
   CONFIG.M_DATA_Has_TUSER {Chan_ID_Field} \
   CONFIG.Number_Channels {512} \
   CONFIG.Output_Rounding_Mode {Truncate_LSBs} \
   CONFIG.Output_Width {18} \
   CONFIG.Quantization {Maximize_Dynamic_Range} \
   CONFIG.RateSpecification {Input_Sample_Period} \
   CONFIG.S_CONFIG_Method {By_Channel} \
   CONFIG.S_DATA_Has_FIFO {false} \
   CONFIG.S_DATA_Has_TUSER {Chan_ID_Field} \
   CONFIG.SamplePeriod {1} \
   CONFIG.Sample_Frequency {0.001} \
   CONFIG.Select_Pattern {All} \
 ] $matched_filter_512x

  # Create instance: xlconcat_0, and set properties
  set xlconcat_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 xlconcat_0 ]
  set_property -dict [ list \
   CONFIG.NUM_PORTS {7} \
 ] $xlconcat_0

  # Create interface connections
  connect_bd_intf_net -intf_net IQ_512_TDM_1 [get_bd_intf_ports S_AXIS_IQ512TDM] [get_bd_intf_pins arctan_phase/S_AXIS_CARTESIAN]
  connect_bd_intf_net -intf_net S00_AXIS_1 [get_bd_intf_ports S_AXIS_FIRCFG] [get_bd_intf_pins axis_interconnect_0/S00_AXIS]
  connect_bd_intf_net -intf_net arctan_phase_M_AXIS_DOUT [get_bd_intf_pins arctan_phase/M_AXIS_DOUT] [get_bd_intf_pins matched_filter_512x/S_AXIS_DATA]
  connect_bd_intf_net -intf_net axis_interconnect_0_M00_AXIS [get_bd_intf_pins axis_interconnect_0/M00_AXIS] [get_bd_intf_pins matched_filter_512x/S_AXIS_RELOAD]
  connect_bd_intf_net -intf_net axis_interconnect_0_M01_AXIS [get_bd_intf_pins axis_interconnect_0/M01_AXIS] [get_bd_intf_pins matched_filter_512x/S_AXIS_CONFIG]
  connect_bd_intf_net -intf_net matched_filter_512x_M_AXIS_DATA [get_bd_intf_ports M_AXIS_MATCHEDPHASE512TDM] [get_bd_intf_pins matched_filter_512x/M_AXIS_DATA]

  # Create port connections
  connect_bd_net -net ARESETN_CFG_1 [get_bd_ports ARESETN_CFG] [get_bd_pins axis_interconnect_0/S00_AXIS_ARESETN]
  connect_bd_net -net M01_AXIS_ARESETN_1 [get_bd_ports ARESETN] [get_bd_pins axis_interconnect_0/ARESETN] [get_bd_pins axis_interconnect_0/M00_AXIS_ARESETN] [get_bd_pins axis_interconnect_0/M01_AXIS_ARESETN]
  connect_bd_net -net S00_AXIS_ACLK_1 [get_bd_ports S_AXIS_FIRCFG_aclk] [get_bd_pins axis_interconnect_0/S00_AXIS_ACLK]
  connect_bd_net -net aclk_1 [get_bd_ports S_AXIS_IQ512TDM_aclk] [get_bd_pins arctan_phase/aclk] [get_bd_pins axis_interconnect_0/ACLK] [get_bd_pins axis_interconnect_0/M00_AXIS_ACLK] [get_bd_pins axis_interconnect_0/M01_AXIS_ACLK] [get_bd_pins matched_filter_512x/aclk]
  connect_bd_net -net matched_filter_512x_event_s_config_tlast_missing [get_bd_pins matched_filter_512x/event_s_config_tlast_missing] [get_bd_pins xlconcat_0/In1]
  connect_bd_net -net matched_filter_512x_event_s_config_tlast_unexpected [get_bd_pins matched_filter_512x/event_s_config_tlast_unexpected] [get_bd_pins xlconcat_0/In2]
  connect_bd_net -net matched_filter_512x_event_s_data_chanid_incorrect [get_bd_pins matched_filter_512x/event_s_data_chanid_incorrect] [get_bd_pins xlconcat_0/In0]
  connect_bd_net -net matched_filter_512x_event_s_data_tlast_missing [get_bd_pins matched_filter_512x/event_s_data_tlast_missing] [get_bd_pins xlconcat_0/In5]
  connect_bd_net -net matched_filter_512x_event_s_data_tlast_unexpected [get_bd_pins matched_filter_512x/event_s_data_tlast_unexpected] [get_bd_pins xlconcat_0/In6]
  connect_bd_net -net matched_filter_512x_event_s_reload_tlast_missing [get_bd_pins matched_filter_512x/event_s_reload_tlast_missing] [get_bd_pins xlconcat_0/In3]
  connect_bd_net -net matched_filter_512x_event_s_reload_tlast_unexpected [get_bd_pins matched_filter_512x/event_s_reload_tlast_unexpected] [get_bd_pins xlconcat_0/In4]
  connect_bd_net -net xlconcat_0_dout [get_bd_ports filter_interrupts] [get_bd_pins xlconcat_0/dout]

  # Create address segments


  # Restore current instance
  current_bd_instance $oldCurInst

  validate_bd_design
  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


