#! /vendor/bin/sh

#
# Copyright (C) 2025 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

project_ver=$(cat /proc/oppoVersion/prjVersion)
operator_name=$(cat /proc/oppoVersion/operatorName)
pcb_version=$(cat /proc/oppoVersion/pcbVersion)

if [ $project_ver = 16017 ]; then # OPPO R9s
    # Set separate soft property
    setprop ro.separate.soft 16017

    # WiFi NV
    if [ $operator_name = 8 ]; then
        # China
        case $pcb_version in
            "4" | "5" )
                setprop ro.vendor.wifi.nv 16017_second
                ;;
            * )
                setprop ro.vendor.wifi.nv 16017
                ;;
        esac
    else
        # Global
        case $operator_name in
            "103" | "107" | "109" )
                setprop ro.vendor.wifi.nv 16317_second
                ;;
            * ) # 102, 106, 108
                setprop ro.vendor.wifi.nv 16317
                ;;
        esac
    fi
elif [ $project_ver = 16027 ]; then # OPPO R9sk
    # Set separate soft property
    setprop ro.separate.soft 16027

    # WiFi NV
    # China (device not released globally?)
    case $pcb_version in
        "4" )
            setprop ro.vendor.wifi.nv 16027_second
            ;;
        * )
            setprop ro.vendor.wifi.nv 16027
            ;;
    esac
fi
