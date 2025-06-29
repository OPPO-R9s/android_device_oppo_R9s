#
# Copyright (C) 2021 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/oppo/R9s

# Inherit from the common device configuration.
TARGET_OPPO_PLATFORM := msm8953
$(call inherit-product, device/oppo/thortanium-common/thortanium.mk)

# Overlays
DEVICE_PACKAGE_OVERLAYS += \
    $(DEVICE_PATH)/overlay

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(DEVICE_PATH)

# Screen density
TARGET_SCREEN_HEIGHT := 1920
TARGET_SCREEN_WIDTH := 1080

# Device uses high-density artwork where available
PRODUCT_AAPT_PREF_CONFIG := xxhdpi

# Input
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/keylayout/oppo_touchscreen.kl:$(TARGET_COPY_OUT_VENDOR)/usr/keylayout/oppo_touchscreen.kl

# Rootdir
PRODUCT_PACKAGES += \
    init.device.rc

# Wifi
PRODUCT_PACKAGES += \
    TargetWifiOverlay

PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/wifi/WCNSS_qcom_cfg.ini:$(TARGET_COPY_OUT_VENDOR)/firmware/wlan/prima/WCNSS_qcom_cfg.ini \
    $(DEVICE_PATH)/wifi/WCNSS_qcom_wlan_nv_16061.bin:$(TARGET_COPY_OUT_VENDOR)/firmware/wlan/16061/WCNSS_qcom_wlan_nv.bin \
    $(DEVICE_PATH)/wifi/WCNSS_qcom_wlan_nv_16061_second.bin:$(TARGET_COPY_OUT_VENDOR)/firmware/wlan/16061_second/WCNSS_qcom_wlan_nv.bin

# Inherit the proprietary files
$(call inherit-product, vendor/oppo/R9s/R9s-vendor.mk)
