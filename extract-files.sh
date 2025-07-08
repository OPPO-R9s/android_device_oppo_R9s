#!/bin/bash
#
# Copyright (C) 2016 The CyanogenMod Project
# Copyright (C) 2017-2020 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

function blob_fixup() {
    case "${1}" in
        vendor/bin/rmt_storage)
            # Drop IO priority set-up
            sed -i "s|\xe0\x0f\x1f\x32|\x0e\x00\x00\x14|g" "${2}"
            ;;
        vendor/lib64/hw/fingerprint.msm8953.so)
            "${PATCHELF_0_17_2}" --add-needed "libbinder_shim.so" "${2}"
            ;;
        vendor/lib64/libalipay_factory.so|vendor/lib64/lib_fpc_tac_shared.so)
            sed -i 's|/system/etc/firmware|/vendor/firmware\x0\x0\x0\x0|g' "${2}"
            ;;
        vendor/bin/mm-qcamera-daemon|vendor/lib/libmmcamera2_cpp_module.so|vendor/lib/libmmcamera2_dcrf.so|vendor/lib/libmmcamera2_iface_modules.so|vendor/lib/libmmcamera2_imglib_modules.so|vendor/lib/libmmcamera2_mct.so|vendor/lib/libmmcamera2_pproc_modules.so|vendor/lib/libmmcamera2_q3a_core.so|vendor/lib/libmmcamera2_stats_algorithm.so|vendor/lib/libmmcamera_imglib.so|vendor/lib/libmmcamera_pdaf.so|vendor/lib/libmmcamera_pdafcamif.so|vendor/lib/libmmcamera_tintless_algo.so|vendor/lib/libmmcamera_tintless_bg_pca_algo.so|vendor/lib/libmmcamera_tuning.so|vendor/lib/libremosaic_daemon.so|vendor/lib64/libremosaic_daemon.so)
            sed -i "s|/data/misc/camera/|/data/vendor/qcam/|g" "${2}"
            ;;
        vendor/lib/libmmcamera2_sensor_modules.so)
            sed -i "s|/system/etc/camera/|/vendor/etc/camera/|g" "${2}"
            sed -i "s|/data/misc/camera/|/data/vendor/qcam/|g" "${2}"
            ;;
        vendor/lib/libmmcamera2_stats_modules.so)
            sed -i "s|libandroid.so|libcamshim.so|g" "${2}"
            "${PATCHELF}" --replace-needed "libgui.so" "libgui_vendor.so" "${2}"
            ;;
        vendor/lib/libchromaflash.so|vendor/lib/liboptizoom.so|vendor/lib/libmmcamera_hdr_gb_lib.so|vendor/lib/libts_detected_face_hal.so|vendor/lib/libts_face_beautify_hal.so|vendor/lib/libseemore.so|vendor/lib/libSonyIMX298PdafLibrary.so|vendor/lib/libSonyIMX371RmscLibrary.so|vendor/lib/libtrueportrait.so|vendor/lib/libubifocus.so)
            "${PATCHELF}" --replace-needed "libstdc++.so" "libstdc++_vendor.so" "${2}"
            ;;
        vendor/lib64/libremosaiclib.so|vendor/lib64/libremosaic_tuning.so)
            "${PATCHELF_0_17_2}" --replace-needed "libstdc++.so" "libstdc++_vendor.so" "${2}"
            ;;
        vendor/lib/libcvface_api.so)
            "${PATCHELF}" --replace-needed "libstdc++.so" "libstdc++_vendor.so" "${2}"
            "${PATCHELF}" --remove-needed "libjnigraphics.so" "${2}"
            ;;
        vendor/lib/libVDHDRAPI.so)
            sed -i "s|libandroid.so|libcamshim.so|g" "${2}"
            "${PATCHELF}" --replace-needed "libstdc++.so" "libstdc++_vendor.so" "${2}"
            "${PATCHELF}" --remove-needed "libjnigraphics.so" "${2}"
            ;;
    esac
}

# If we're being sourced by the common script that we called,
# stop right here. No need to go down the rabbit hole.
if [ "${BASH_SOURCE[0]}" != "${0}" ]; then
    return
fi

set -e

export DEVICE=R9s
export DEVICE_COMMON=thortanium-common
export VENDOR=oppo

"./../../${VENDOR}/${DEVICE_COMMON}/extract-files.sh" "$@"
