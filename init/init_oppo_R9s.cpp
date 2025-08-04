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
};

static const variant_info_t r9sk_info = {
    .brand = "OPPO",
    .device = "R9s",
    .marketname = "OPPO R9sk",
    .model = "OPPO R9sk",
    .build_fingerprint = "OPPO/R9sk/R9sk:7.1.1/NMF26F/1554707882:user/release-keys",
    .build_description = "msm8953_64-user 7.1.1 NMF26F eng.root.20190413.183814 release-keys",
};

static const variant_info_t cph1607_info = {
    .brand = "OPPO",
    .device = "CPH1607",
    .marketname = "OPPO R9s",
    .model = "CPH1607",
    .build_fingerprint = "Android/msm8953_64/msm8953_64:6.0.1/MMB29M/414:user/release-keys",
    .build_description = "msm8953_64-user 6.0.1 MMB29M 414 release-keys",
};

static void determine_device() {
    if (ReadProjectVersion() == 16017) {
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
                set_variant_props(cph1607_info);
                break;

            default:
                LOG(WARNING) << "Unknown operator variant, setting R9s";
                set_variant_props(r9s_info);
                break;
        }
    } else if (ReadProjectVersion() == 16027) {
        // Not released globally?
        set_variant_props(r9sk_info);
    } else {
        LOG(ERROR) << "Unknown device variant";
    }
}

void vendor_load_properties() {
    determine_device();
    set_dalvik_heap();
}
