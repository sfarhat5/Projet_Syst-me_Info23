#!/bin/bash -f
# ****************************************************************************
# Vivado (TM) v2018.2 (64-bit)
#
# Filename    : compile.sh
# Simulator   : Xilinx Vivado Simulator
# Description : Script for compiling the simulation design source files
#
# Generated by Vivado on Sun May 14 13:21:27 CEST 2023
# SW Build 2258646 on Thu Jun 14 20:02:38 MDT 2018
#
# Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
#
# usage: compile.sh
#
# ****************************************************************************
ExecStep()
{
"$@"
RETVAL=$?
if [ $RETVAL -ne 0 ]
then
exit $RETVAL
fi
}
echo "xvlog --incr --relax -prj MICROPROCESSOR_TEST_vlog.prj"
ExecStep xvlog --incr --relax -prj MICROPROCESSOR_TEST_vlog.prj 2>&1 | tee compile.log
echo "xvhdl --incr --relax -prj MICROPROCESSOR_TEST_vhdl.prj"
ExecStep xvhdl --incr --relax -prj MICROPROCESSOR_TEST_vhdl.prj 2>&1 | tee -a compile.log
