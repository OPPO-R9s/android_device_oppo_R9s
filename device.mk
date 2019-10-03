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
    $(DEVICE_PATH)/overlay \
    $(DEVICE_PATH)/overlay-lineage

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(DEVICE_PATH)

# Screen density
TARGET_SCREEN_HEIGHT := 1920
TARGET_SCREEN_WIDTH := 1080

# Device uses high-density artwork where available
PRODUCT_AAPT_PREF_CONFIG := xxhdpi

# Audio
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/audio/audio_platform_info_intcodec.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_platform_info_intcodec.xml \
    $(DEVICE_PATH)/audio/mixer_paths_mtp.xml:$(TARGET_COPY_OUT_VENDOR)/etc/mixer_paths_mtp.xml

# Input
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/keylayout/synaptics_s1302.kl:$(TARGET_COPY_OUT_VENDOR)/usr/keylayout/synaptics_s1302.kl \
    $(DEVICE_PATH)/keylayout/synaptics-s3320.kl:$(TARGET_COPY_OUT_VENDOR)/usr/keylayout/synaptics-s3320.kl

# Rootdir
PRODUCT_PACKAGES += \
    init.device.rc

# Wifi
PRODUCT_PACKAGES += \
    TargetWifiOverlay

PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/wifi/WCNSS_qcom_cfg.ini:$(TARGET_COPY_OUT_VENDOR)/firmware/wlan/prima/WCNSS_qcom_cfg.ini \
    $(DEVICE_PATH)/wifi/WCNSS_qcom_wlan_nv_16017.bin:$(TARGET_COPY_OUT_VENDOR)/firmware/wlan/16017/WCNSS_qcom_wlan_nv.bin \
    $(DEVICE_PATH)/wifi/WCNSS_qcom_wlan_nv_16017_second.bin:$(TARGET_COPY_OUT_VENDOR)/firmware/wlan/16017_second/WCNSS_qcom_wlan_nv.bin \
    $(DEVICE_PATH)/wifi/WCNSS_qcom_wlan_nv_16027.bin:$(TARGET_COPY_OUT_VENDOR)/firmware/wlan/16027/WCNSS_qcom_wlan_nv.bin \
    $(DEVICE_PATH)/wifi/WCNSS_qcom_wlan_nv_16027_second.bin:$(TARGET_COPY_OUT_VENDOR)/firmware/wlan/16027_second/WCNSS_qcom_wlan_nv.bin \
    $(DEVICE_PATH)/wifi/WCNSS_qcom_wlan_nv_16317.bin:$(TARGET_COPY_OUT_VENDOR)/firmware/wlan/16317/WCNSS_qcom_wlan_nv.bin \
    $(DEVICE_PATH)/wifi/WCNSS_qcom_wlan_nv_16317_second.bin:$(TARGET_COPY_OUT_VENDOR)/firmware/wlan/16317_second/WCNSS_qcom_wlan_nv.bin

# Inherit the proprietary files
$(call inherit-product, vendor/oppo/R9s/R9s-vendor.mk)
