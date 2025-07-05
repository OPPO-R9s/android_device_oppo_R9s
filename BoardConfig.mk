#
# Copyright (C) 2021 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/oppo/R9s

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := msm8953

# Platform
TARGET_BOARD_PLATFORM := msm8953

# Inherit from common device tree
include device/oppo/thortanium-common/BoardConfigCommon.mk

# Display
TARGET_SCREEN_DENSITY := 400

# Init
TARGET_INIT_VENDOR_LIB := //$(DEVICE_PATH):init_oppo_R9s
TARGET_RECOVERY_DEVICE_MODULES := init_oppo_R9s

# HIDL
ODM_MANIFEST_SKUS += 16017 16027
ODM_MANIFEST_16017_FILES := $(DEVICE_PATH)/manifest_16017.xml
ODM_MANIFEST_16027_FILES := $(DEVICE_PATH)/manifest_16027.xml

# Kernel
TARGET_KERNEL_CONFIG := lineageos_R9s_defconfig
TARGET_KERNEL_RECOVERY_CONFIG := lineageos_R9s_recovery_defconfig

# Properties
TARGET_VENDOR_PROP += $(DEVICE_PATH)/vendor.prop

# Security patch level
VENDOR_SECURITY_PATCH := 2018-08-05
