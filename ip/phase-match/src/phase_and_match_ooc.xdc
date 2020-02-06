################################################################################

# This XDC is used only for OOC mode of synthesis, implementation
# This constraints file contains default clock frequencies to be used during
# out-of-context flows such as OOC Synthesis and Hierarchical Designs.
# This constraints file is not used in normal top-down synthesis (default flow
# of Vivado)
################################################################################
create_clock -name S_AXIS_IQ512TDM_aclk -period 1.905 [get_ports S_AXIS_IQ512TDM_aclk]

################################################################################