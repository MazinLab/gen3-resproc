
################################################################
# This is a generated script based on design: resproc
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
# source resproc_script.tcl

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
set design_name resproc

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
xilinx.com:ip:axi_intc:4.1\
xilinx.com:ip:axi_mcdma:1.1\
xilinx.com:ip:axis_broadcaster:1.1\
xilinx.com:ip:axis_switch:1.1\
MazinLab:mkidgen3:phase_and_match:1.0\
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
  set S_AXIS [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S_AXIS ]
  set_property -dict [ list \
   CONFIG.HAS_TKEEP {0} \
   CONFIG.HAS_TLAST {0} \
   CONFIG.HAS_TREADY {1} \
   CONFIG.HAS_TSTRB {0} \
   CONFIG.LAYERED_METADATA {undef} \
   CONFIG.TDATA_NUM_BYTES {1} \
   CONFIG.TDEST_WIDTH {0} \
   CONFIG.TID_WIDTH {0} \
   CONFIG.TUSER_WIDTH {0} \
   ] $S_AXIS


  # Create ports

  # Create instance: axi_intc_0, and set properties
  set axi_intc_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_intc:4.1 axi_intc_0 ]

  # Create instance: axi_mcdma_0, and set properties
  set axi_mcdma_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_mcdma:1.1 axi_mcdma_0 ]
  set_property -dict [ list \
   CONFIG.c_group1_mm2s {0000000011111111} \
   CONFIG.c_group1_s2mm {0000000000000000} \
   CONFIG.c_group2_mm2s {0000000000000000} \
   CONFIG.c_group3_mm2s {0000000000000000} \
   CONFIG.c_group4_mm2s {0000000000000000} \
   CONFIG.c_group5_mm2s {0000000000000000} \
   CONFIG.c_group6_mm2s {0000000000000000} \
   CONFIG.c_include_mm2s {1} \
   CONFIG.c_include_s2mm {0} \
   CONFIG.c_m_axi_mm2s_data_width {64} \
   CONFIG.c_m_axis_mm2s_tdata_width {16} \
   CONFIG.c_mm2s_burst_size {8} \
   CONFIG.c_num_mm2s_channels {8} \
   CONFIG.c_num_s2mm_channels {1} \
 ] $axi_mcdma_0

  # Create instance: axis_broadcaster_0, and set properties
  set axis_broadcaster_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0 ]
  set_property -dict [ list \
   CONFIG.M02_TDATA_REMAP {tdata[7:0]} \
   CONFIG.M03_TDATA_REMAP {tdata[7:0]} \
   CONFIG.NUM_MI {4} \
 ] $axis_broadcaster_0

  # Create instance: axis_switch_0, and set properties
  set axis_switch_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_switch:1.1 axis_switch_0 ]
  set_property -dict [ list \
   CONFIG.DECODER_REG {1} \
   CONFIG.NUM_MI {8} \
   CONFIG.NUM_SI {1} \
 ] $axis_switch_0

  # Create instance: phase_and_match_0, and set properties
  set phase_and_match_0 [ create_bd_cell -type ip -vlnv MazinLab:mkidgen3:phase_and_match:1.0 phase_and_match_0 ]

  # Create instance: phase_and_match_1, and set properties
  set phase_and_match_1 [ create_bd_cell -type ip -vlnv MazinLab:mkidgen3:phase_and_match:1.0 phase_and_match_1 ]

  # Create instance: phase_and_match_2, and set properties
  set phase_and_match_2 [ create_bd_cell -type ip -vlnv MazinLab:mkidgen3:phase_and_match:1.0 phase_and_match_2 ]

  # Create instance: phase_and_match_3, and set properties
  set phase_and_match_3 [ create_bd_cell -type ip -vlnv MazinLab:mkidgen3:phase_and_match:1.0 phase_and_match_3 ]

  # Create instance: xlconcat_0, and set properties
  set xlconcat_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 xlconcat_0 ]
  set_property -dict [ list \
   CONFIG.NUM_PORTS {4} \
 ] $xlconcat_0

  # Create interface connections
  connect_bd_intf_net -intf_net S_AXIS_1 [get_bd_intf_ports S_AXIS] [get_bd_intf_pins axis_broadcaster_0/S_AXIS]
  connect_bd_intf_net -intf_net axi_mcdma_0_M_AXIS_MM2S [get_bd_intf_pins axi_mcdma_0/M_AXIS_MM2S] [get_bd_intf_pins axis_switch_0/S00_AXIS]
  connect_bd_intf_net -intf_net axis_broadcaster_0_M00_AXIS [get_bd_intf_pins axis_broadcaster_0/M00_AXIS] [get_bd_intf_pins phase_and_match_0/S_AXIS_IQ512TDM]
  connect_bd_intf_net -intf_net axis_broadcaster_0_M01_AXIS [get_bd_intf_pins axis_broadcaster_0/M01_AXIS] [get_bd_intf_pins phase_and_match_1/S_AXIS_IQ512TDM]
  connect_bd_intf_net -intf_net axis_broadcaster_0_M02_AXIS [get_bd_intf_pins axis_broadcaster_0/M02_AXIS] [get_bd_intf_pins phase_and_match_2/S_AXIS_IQ512TDM]
  connect_bd_intf_net -intf_net axis_broadcaster_0_M03_AXIS [get_bd_intf_pins axis_broadcaster_0/M03_AXIS] [get_bd_intf_pins phase_and_match_3/S_AXIS_IQ512TDM]
  connect_bd_intf_net -intf_net axis_switch_0_M00_AXIS [get_bd_intf_pins axis_switch_0/M00_AXIS] [get_bd_intf_pins phase_and_match_0/S_AXIS_RELOAD]
  connect_bd_intf_net -intf_net axis_switch_0_M01_AXIS [get_bd_intf_pins axis_switch_0/M01_AXIS] [get_bd_intf_pins phase_and_match_0/S_AXIS_CONFIG]
  connect_bd_intf_net -intf_net axis_switch_0_M02_AXIS [get_bd_intf_pins axis_switch_0/M02_AXIS] [get_bd_intf_pins phase_and_match_1/S_AXIS_RELOAD]
  connect_bd_intf_net -intf_net axis_switch_0_M03_AXIS [get_bd_intf_pins axis_switch_0/M03_AXIS] [get_bd_intf_pins phase_and_match_1/S_AXIS_CONFIG]
  connect_bd_intf_net -intf_net axis_switch_0_M04_AXIS [get_bd_intf_pins axis_switch_0/M04_AXIS] [get_bd_intf_pins phase_and_match_2/S_AXIS_RELOAD]
  connect_bd_intf_net -intf_net axis_switch_0_M05_AXIS [get_bd_intf_pins axis_switch_0/M05_AXIS] [get_bd_intf_pins phase_and_match_2/S_AXIS_CONFIG]
  connect_bd_intf_net -intf_net axis_switch_0_M06_AXIS [get_bd_intf_pins axis_switch_0/M06_AXIS] [get_bd_intf_pins phase_and_match_3/S_AXIS_RELOAD]
  connect_bd_intf_net -intf_net axis_switch_0_M07_AXIS [get_bd_intf_pins axis_switch_0/M07_AXIS] [get_bd_intf_pins phase_and_match_3/S_AXIS_CONFIG]

  # Create port connections
  connect_bd_net -net Net [get_bd_pins axis_broadcaster_0/aclk] [get_bd_pins axis_switch_0/aclk] [get_bd_pins phase_and_match_0/S_AXIS_IQ512TDM_aclk] [get_bd_pins phase_and_match_1/S_AXIS_IQ512TDM_aclk] [get_bd_pins phase_and_match_2/S_AXIS_IQ512TDM_aclk] [get_bd_pins phase_and_match_3/S_AXIS_IQ512TDM_aclk]
  connect_bd_net -net Net1 [get_bd_pins axis_broadcaster_0/aresetn] [get_bd_pins axis_switch_0/aresetn]
  connect_bd_net -net phase_and_match_0_filter_interrupts [get_bd_pins phase_and_match_0/filter_interrupts] [get_bd_pins xlconcat_0/In0]
  connect_bd_net -net phase_and_match_1_filter_interrupts [get_bd_pins phase_and_match_1/filter_interrupts] [get_bd_pins xlconcat_0/In1]
  connect_bd_net -net phase_and_match_2_filter_interrupts [get_bd_pins phase_and_match_2/filter_interrupts] [get_bd_pins xlconcat_0/In2]
  connect_bd_net -net phase_and_match_3_filter_interrupts [get_bd_pins phase_and_match_3/filter_interrupts] [get_bd_pins xlconcat_0/In3]
  connect_bd_net -net xlconcat_0_dout [get_bd_pins axi_intc_0/intr] [get_bd_pins xlconcat_0/dout]

  # Create address segments


  # Restore current instance
  current_bd_instance $oldCurInst

  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


common::send_msg_id "BD_TCL-1000" "WARNING" "This Tcl script was generated from a block design that has not been validated. It is possible that design <$design_name> may result in errors during validation."

