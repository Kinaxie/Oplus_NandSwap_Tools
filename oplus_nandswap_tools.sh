#!/system/bin/sh

# Oplus_NandSwap_Tools - Android NAND Swap Partition Management Tool
# Copyright (C) 2025  Kinaxie
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program. If not, see <https://www.gnu.org/licenses/>.
#
# Contact: GitHub @Kinaxie | [Project Homepage](https://github.com/Kinaxie/Oplus_NandSwap_Tools)

comp_algorithm="lz4"
prop_nandswap_size=$(getprop persist.sys.oplus.nandswap.swapsize)
prop_nandswap_err="persist.sys.oplus.nandswap.err"
prop_condition="persist.sys.oplus.nandswap.condition"
prop_nandswap="persist.sys.oplus.nandswap"

function write_nandswap_err()
{
    setprop $prop_nandswap_err $1
    setprop $prop_condition true
}

function configure_zram_parameters()
{
    echo $comp_algorithm > /sys/block/zram0/comp_algorithm
    
    if [ -f /sys/block/zram0/disksize ]; then
        if [[ "$prop_nandswap_size" == "4" ]]; then
            swap_size_mb=4096
        elif [[ "$prop_nandswap_size" == "6" ]]; then
            swap_size_mb=6144
        elif [[ "$prop_nandswap_size" == "8" ]]; then
            swap_size_mb=8192
        elif [[ "$prop_nandswap_size" == "12" ]]; then
            swap_size_mb=12288
        elif [[ "$prop_nandswap_size" == "16" ]]; then
            swap_size_mb=16384
        else
            swap_size_mb=4096
        fi
        
        echo "${swap_size_mb}M" > /sys/block/zram0/disksize
    else
        write_nandswap_err 1005
        exit 1
    fi
}

function zram_init()
{
    if ! mkswap /dev/block/zram0; then
        write_nandswap_err 1006
        exit 1
    fi
    
    if ! swapon /dev/block/zram0; then
        write_nandswap_err 1007
        exit 1
    fi
}

function main()
{
    nandswap=$(getprop $prop_nandswap)
    if [ "$nandswap" == "true" ]; then
        configure_zram_parameters
        zram_init
    fi
}

main