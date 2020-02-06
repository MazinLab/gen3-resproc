//Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2019.2.1 (win64) Build 2729669 Thu Dec  5 04:49:17 MST 2019
//Date        : Wed Feb  5 22:36:22 2020
//Host        : guybrush running 64-bit major release  (build 9200)
//Command     : generate_target phase_and_match.bd
//Design      : phase_and_match
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CORE_GENERATION_INFO = "phase_and_match,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=phase_and_match,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=3,numReposBlks=3,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=0,numPkgbdBlks=0,bdsource=USER,synth_mode=OOC_per_IP}" *) (* HW_HANDOFF = "phase_and_match.hwdef" *) 
module phase_and_match
   (M_AXIS_PHASE_tdata,
    M_AXIS_PHASE_tlast,
    M_AXIS_PHASE_tuser,
    M_AXIS_PHASE_tvalid,
    S_AXIS_CONFIG_tdata,
    S_AXIS_CONFIG_tlast,
    S_AXIS_CONFIG_tready,
    S_AXIS_CONFIG_tvalid,
    S_AXIS_IQ512TDM_aclk,
    S_AXIS_IQ512TDM_tdata,
    S_AXIS_IQ512TDM_tuser,
    S_AXIS_IQ512TDM_tvalid,
    S_AXIS_RELOAD_tdata,
    S_AXIS_RELOAD_tlast,
    S_AXIS_RELOAD_tready,
    S_AXIS_RELOAD_tvalid,
    filter_interrupts);
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M_AXIS_PHASE " *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME M_AXIS_PHASE, CLK_DOMAIN phase_and_match_aclk, FREQ_HZ 524994750, HAS_TKEEP 0, HAS_TLAST 1, HAS_TREADY 0, HAS_TSTRB 0, INSERT_VIP 0, LAYERED_METADATA xilinx.com:interface:datatypes:1.0 {TDATA {datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type automatic dependency {} format long minimum {} maximum {}} value 12282} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0} array_type {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value chan} size {attribs {resolve_type generated dependency chan_size format long minimum {} maximum {}} value 512} stride {attribs {resolve_type generated dependency chan_stride format long minimum {} maximum {}} value 24} datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type automatic dependency {} format long minimum {} maximum {}} value 18} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0} array_type {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value path} size {attribs {resolve_type generated dependency path_size format long minimum {} maximum {}} value 1} stride {attribs {resolve_type generated dependency path_stride format long minimum {} maximum {}} value 24} datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type generated dependency out_width format long minimum {} maximum {}} value 18} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0} real {fixed {fractwidth {attribs {resolve_type generated dependency out_fractwidth format long minimum {} maximum {}} value 2} signed {attribs {resolve_type generated dependency out_signed format bool minimum {} maximum {}} value true}}}}}}}}} TDATA_WIDTH 24 TUSER {datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type automatic dependency {} format long minimum {} maximum {}} value 9} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0} struct {field_data_valid {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value data_valid} enabled {attribs {resolve_type generated dependency data_valid_enabled format bool minimum {} maximum {}} value false} datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type generated dependency data_valid_bitwidth format long minimum {} maximum {}} value 0} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0}}} field_chanid {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value chanid} enabled {attribs {resolve_type generated dependency chanid_enabled format bool minimum {} maximum {}} value true} datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type generated dependency chanid_bitwidth format long minimum {} maximum {}} value 9} bitoffset {attribs {resolve_type generated dependency chanid_bitoffset format long minimum {} maximum {}} value 0} integer {signed {attribs {resolve_type immediate dependency {} format bool minimum {} maximum {}} value false}}}} field_user {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value user} enabled {attribs {resolve_type generated dependency user_enabled format bool minimum {} maximum {}} value false} datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type generated dependency user_bitwidth format long minimum {} maximum {}} value 0} bitoffset {attribs {resolve_type generated dependency user_bitoffset format long minimum {} maximum {}} value 9}}}}}} TUSER_WIDTH 9}, PHASE 0.000, TDATA_NUM_BYTES 3, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 9" *) output [23:0]M_AXIS_PHASE_tdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M_AXIS_PHASE " *) output M_AXIS_PHASE_tlast;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M_AXIS_PHASE " *) output [8:0]M_AXIS_PHASE_tuser;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M_AXIS_PHASE " *) output M_AXIS_PHASE_tvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_CONFIG TDATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME S_AXIS_CONFIG, CLK_DOMAIN phase_and_match_aclk, FREQ_HZ 524994750, HAS_TKEEP 0, HAS_TLAST 1, HAS_TREADY 1, HAS_TSTRB 0, INSERT_VIP 0, LAYERED_METADATA undef, PHASE 0.000, TDATA_NUM_BYTES 2, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0" *) input [15:0]S_AXIS_CONFIG_tdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_CONFIG TLAST" *) input S_AXIS_CONFIG_tlast;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_CONFIG TREADY" *) output S_AXIS_CONFIG_tready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_CONFIG TVALID" *) input S_AXIS_CONFIG_tvalid;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.S_AXIS_IQ512TDM_ACLK CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.S_AXIS_IQ512TDM_ACLK, ASSOCIATED_BUSIF S_AXIS_IQ512TDM:M_AXIS_PHASE:S_AXIS_RELOAD:S_AXIS_CONFIG, ASSOCIATED_RESET ARESETN, CLK_DOMAIN phase_and_match_aclk, FREQ_HZ 524994750, INSERT_VIP 0, PHASE 0.000" *) input S_AXIS_IQ512TDM_aclk;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_IQ512TDM TDATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME S_AXIS_IQ512TDM, CLK_DOMAIN phase_and_match_aclk, FREQ_HZ 524994750, HAS_TKEEP 0, HAS_TLAST 0, HAS_TREADY 0, HAS_TSTRB 0, INSERT_VIP 0, LAYERED_METADATA undef, PHASE 0.000, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 9" *) input [31:0]S_AXIS_IQ512TDM_tdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_IQ512TDM TUSER" *) input [8:0]S_AXIS_IQ512TDM_tuser;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_IQ512TDM TVALID" *) input S_AXIS_IQ512TDM_tvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_RELOAD TDATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME S_AXIS_RELOAD, CLK_DOMAIN phase_and_match_aclk, FREQ_HZ 524994750, HAS_TKEEP 0, HAS_TLAST 1, HAS_TREADY 1, HAS_TSTRB 0, INSERT_VIP 0, LAYERED_METADATA undef, PHASE 0.000, TDATA_NUM_BYTES 3, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0" *) input [23:0]S_AXIS_RELOAD_tdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_RELOAD TLAST" *) input S_AXIS_RELOAD_tlast;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_RELOAD TREADY" *) output S_AXIS_RELOAD_tready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_RELOAD TVALID" *) input S_AXIS_RELOAD_tvalid;
  (* X_INTERFACE_INFO = "xilinx.com:signal:interrupt:1.0 INTR.FILTER_INTERRUPTS INTERRUPT" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME INTR.FILTER_INTERRUPTS, PortWidth 7, SENSITIVITY EDGE_RISING:EDGE_RISING:EDGE_RISING:EDGE_RISING:EDGE_RISING:EDGE_RISING:EDGE_RISING" *) output [6:0]filter_interrupts;

  wire [31:0]IQ_512_TDM_1_TDATA;
  wire [8:0]IQ_512_TDM_1_TUSER;
  wire IQ_512_TDM_1_TVALID;
  wire [15:0]S_AXIS_CONFIG_1_TDATA;
  wire S_AXIS_CONFIG_1_TLAST;
  wire S_AXIS_CONFIG_1_TREADY;
  wire S_AXIS_CONFIG_1_TVALID;
  wire [23:0]S_AXIS_RELOAD_1_TDATA;
  wire S_AXIS_RELOAD_1_TLAST;
  wire S_AXIS_RELOAD_1_TREADY;
  wire S_AXIS_RELOAD_1_TVALID;
  wire aclk_1;
  wire [23:0]arctan_phase_M_AXIS_DOUT_TDATA;
  wire [8:0]arctan_phase_M_AXIS_DOUT_TUSER;
  wire arctan_phase_M_AXIS_DOUT_TVALID;
  wire [23:0]matched_filter_512x_M_AXIS_DATA_TDATA;
  wire matched_filter_512x_M_AXIS_DATA_TLAST;
  wire [8:0]matched_filter_512x_M_AXIS_DATA_TUSER;
  wire matched_filter_512x_M_AXIS_DATA_TVALID;
  wire matched_filter_512x_event_s_config_tlast_missing;
  wire matched_filter_512x_event_s_config_tlast_unexpected;
  wire matched_filter_512x_event_s_data_chanid_incorrect;
  wire matched_filter_512x_event_s_data_tlast_missing;
  wire matched_filter_512x_event_s_data_tlast_unexpected;
  wire matched_filter_512x_event_s_reload_tlast_missing;
  wire matched_filter_512x_event_s_reload_tlast_unexpected;
  wire [6:0]xlconcat_0_dout;

  assign IQ_512_TDM_1_TDATA = S_AXIS_IQ512TDM_tdata[31:0];
  assign IQ_512_TDM_1_TUSER = S_AXIS_IQ512TDM_tuser[8:0];
  assign IQ_512_TDM_1_TVALID = S_AXIS_IQ512TDM_tvalid;
  assign M_AXIS_PHASE_tdata[23:0] = matched_filter_512x_M_AXIS_DATA_TDATA;
  assign M_AXIS_PHASE_tlast = matched_filter_512x_M_AXIS_DATA_TLAST;
  assign M_AXIS_PHASE_tuser[8:0] = matched_filter_512x_M_AXIS_DATA_TUSER;
  assign M_AXIS_PHASE_tvalid = matched_filter_512x_M_AXIS_DATA_TVALID;
  assign S_AXIS_CONFIG_1_TDATA = S_AXIS_CONFIG_tdata[15:0];
  assign S_AXIS_CONFIG_1_TLAST = S_AXIS_CONFIG_tlast;
  assign S_AXIS_CONFIG_1_TVALID = S_AXIS_CONFIG_tvalid;
  assign S_AXIS_CONFIG_tready = S_AXIS_CONFIG_1_TREADY;
  assign S_AXIS_RELOAD_1_TDATA = S_AXIS_RELOAD_tdata[23:0];
  assign S_AXIS_RELOAD_1_TLAST = S_AXIS_RELOAD_tlast;
  assign S_AXIS_RELOAD_1_TVALID = S_AXIS_RELOAD_tvalid;
  assign S_AXIS_RELOAD_tready = S_AXIS_RELOAD_1_TREADY;
  assign aclk_1 = S_AXIS_IQ512TDM_aclk;
  assign filter_interrupts[6:0] = xlconcat_0_dout;
  phase_and_match_arctan_phase_0 arctan_phase
       (.aclk(aclk_1),
        .m_axis_dout_tdata(arctan_phase_M_AXIS_DOUT_TDATA),
        .m_axis_dout_tuser(arctan_phase_M_AXIS_DOUT_TUSER),
        .m_axis_dout_tvalid(arctan_phase_M_AXIS_DOUT_TVALID),
        .s_axis_cartesian_tdata(IQ_512_TDM_1_TDATA),
        .s_axis_cartesian_tuser(IQ_512_TDM_1_TUSER),
        .s_axis_cartesian_tvalid(IQ_512_TDM_1_TVALID));
  phase_and_match_matched_filter_512x_0 matched_filter_512x
       (.aclk(aclk_1),
        .event_s_config_tlast_missing(matched_filter_512x_event_s_config_tlast_missing),
        .event_s_config_tlast_unexpected(matched_filter_512x_event_s_config_tlast_unexpected),
        .event_s_data_chanid_incorrect(matched_filter_512x_event_s_data_chanid_incorrect),
        .event_s_data_tlast_missing(matched_filter_512x_event_s_data_tlast_missing),
        .event_s_data_tlast_unexpected(matched_filter_512x_event_s_data_tlast_unexpected),
        .event_s_reload_tlast_missing(matched_filter_512x_event_s_reload_tlast_missing),
        .event_s_reload_tlast_unexpected(matched_filter_512x_event_s_reload_tlast_unexpected),
        .m_axis_data_tdata(matched_filter_512x_M_AXIS_DATA_TDATA),
        .m_axis_data_tlast(matched_filter_512x_M_AXIS_DATA_TLAST),
        .m_axis_data_tuser(matched_filter_512x_M_AXIS_DATA_TUSER),
        .m_axis_data_tvalid(matched_filter_512x_M_AXIS_DATA_TVALID),
        .s_axis_config_tdata(S_AXIS_CONFIG_1_TDATA),
        .s_axis_config_tlast(S_AXIS_CONFIG_1_TLAST),
        .s_axis_config_tready(S_AXIS_CONFIG_1_TREADY),
        .s_axis_config_tvalid(S_AXIS_CONFIG_1_TVALID),
        .s_axis_data_tdata(arctan_phase_M_AXIS_DOUT_TDATA),
        .s_axis_data_tlast(1'b0),
        .s_axis_data_tuser(arctan_phase_M_AXIS_DOUT_TUSER),
        .s_axis_data_tvalid(arctan_phase_M_AXIS_DOUT_TVALID),
        .s_axis_reload_tdata(S_AXIS_RELOAD_1_TDATA),
        .s_axis_reload_tlast(S_AXIS_RELOAD_1_TLAST),
        .s_axis_reload_tready(S_AXIS_RELOAD_1_TREADY),
        .s_axis_reload_tvalid(S_AXIS_RELOAD_1_TVALID));
  phase_and_match_xlconcat_0_0 xlconcat_0
       (.In0(matched_filter_512x_event_s_data_chanid_incorrect),
        .In1(matched_filter_512x_event_s_config_tlast_missing),
        .In2(matched_filter_512x_event_s_config_tlast_unexpected),
        .In3(matched_filter_512x_event_s_reload_tlast_missing),
        .In4(matched_filter_512x_event_s_reload_tlast_unexpected),
        .In5(matched_filter_512x_event_s_data_tlast_missing),
        .In6(matched_filter_512x_event_s_data_tlast_unexpected),
        .dout(xlconcat_0_dout));
endmodule
