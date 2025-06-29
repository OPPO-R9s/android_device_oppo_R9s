/*
 * Copyright (C) 2021 The LineageOS Project
 *
 * SPDX-License-Identifier: Apache-2.0
 */

#include <libinit_dalvik_heap.h>
#include <libinit_oppo_version.h>
#include <libinit_utils.h>
#include <libinit_variant.h>

#include "vendor_init.h"

#include <android-base/file.h>
#include <android-base/logging.h>

using android::base::ReadFileToString;

static const variant_info_t r9s_info = {
    .brand = "OPPO",
    .device = "R9s",
    .marketname = "OPPO R9s",
    .model = "OPPO R9s",
    .build_fingerprint = "OPPO/R9s/R9s:7.1.1/NMF26F/1554707829:user/release-keys",
    .build_description = "msm8953_64-user 7.1.1 NMF26F eng.root.20190413.183814 release-keys",
    .build_ota = "R9s_11.A.53_0530_201904131805",
};

static const variant_info_t r9sk_info = {
    .brand = "OPPO",
    .device = "R9s",
    .marketname = "OPPO R9sk",
    .model = "OPPO R9sk",
    .build_fingerprint = "OPPO/R9sk/R9sk:7.1.1/NMF26F/1554707882:user/release-keys",
    .build_description = "msm8953_64-user 7.1.1 NMF26F eng.root.20190413.183814 release-keys",
    .build_ota = "R9s_11.A.53_0530_201904131805",
};

static const variant_info_t cph1607_info = {
    .brand = "OPPO",
    .device = "CPH1607",
    .marketname = "OPPO R9s",
    .model = "CPH1607",
    .build_fingerprint = "Android/msm8953_64/msm8953_64:6.0.1/MMB29M/414:user/release-keys",
    .build_description = "msm8953_64-user 6.0.1 MMB29M 414 release-keys",
    .build_ota = "CPH1607EX_11.A.25_INT_025_201904251742",
};

static void determine_device() {
    if (ReadProjectVersion() == 16017) {
        bool isGlobal = false;

        switch (ReadOperatorName()) {
            /* China */
            case 8:
                set_variant_props(r9s_info);
                break;

            /* Global */
            case 102:
            case 103:
            case 106:
            case 107:
            case 108:
            case 109:
                isGlobal = true;
                set_variant_props(cph1607_info);
                break;

            default:
                LOG(WARNING) << "Unknown operator variant, setting R9s";
                set_variant_props(r9s_info);
                break;
        }

        if (isGlobal) {
            switch (ReadOperatorName()) {
                case 103:
                case 107:
                case 109:
                    property_override("ro.vendor.wlan_fw_variant", "16317_second");
                    break;
                default: /* 102, 106, 108 */
                    property_override("ro.vendor.wlan_fw_variant", "16317");
                    break;
            }
        } else {
            switch (ReadPcbVersion()) {
                case 4:
                case 5:
                    property_override("ro.vendor.wlan_fw_variant", "16017_second");
                    break;
                default:
                    property_override("ro.vendor.wlan_fw_variant", "16017");
                    break;
            }
        }
    } else if (ReadProjectVersion() == 16027) {
        // Not released globally?
        set_variant_props(r9sk_info);

        switch (ReadPcbVersion()) {
            case 4:
                property_override("ro.vendor.wlan_fw_variant", "16027_second");
                break;
            default:
                property_override("ro.vendor.wlan_fw_variant", "16027");
                break;
        }
    } else {
        LOG(ERROR) << "Unknown device variant";
    }
}

void vendor_load_properties() {
    determine_device();
    set_dalvik_heap();
}
