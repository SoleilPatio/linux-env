#!/bin/bash
SEPARATOR="---------------------------------"

MSG_no_mrv_pdk()
{
	echo "Try \"\$module load MDSP_PDK/SCP/1.4.0\" or later."
}


cls_dev_symbol_info()
{
	if [ $# -lt 2 ]
	then
		cls_color_HEAD
		echo command: ${FUNCNAME[ 0 ]} elf symbol
		cls_color_reset

	else
		_cmd="gdb -batch -q $1 -ex \"info line $2\" -ex \"ptype $2\" "
		cls_color_HEAD
		echo -e "command:" $_cmd
		cls_color_reset
		eval $_cmd
	fi 

}

cls_dev_sources_info()
{
	if [ $# -lt 1 ]
	then
		cls_color_HEAD
		echo command: ${FUNCNAME[ 0 ]} elf
		cls_color_reset

	else
		_cmd="gdb -batch -q $1 -ex \"info sources\" "
		cls_color_HEAD
		echo -e "command:" $_cmd
		cls_color_reset
		eval $_cmd
	fi 

}



cls_dev_disfun_mrv()
{
	if [ -z ${MRV_PDK_LLDB_HOME+x} ]
	then
		echo "MRV_PDK_LLDB_HOME is not set."
		MSG_no_mrv_pdk
		return
	fi
		
	if [ $# -lt 2 ]
	then
		cls_color_HEAD
		echo command: ${FUNCNAME[ 0 ]} elf function_name
		cls_color_reset
	else
		_lldb_exe=$MRV_PDK_LLDB_HOME/bin/lldb
		_cmd="$_lldb_exe -batch $1 -o \"disassemble -mixed -name  $2\" "
		cls_color_HEAD
		echo -e "command:" $_cmd
		cls_color_reset
		eval $_cmd
	fi 

}


