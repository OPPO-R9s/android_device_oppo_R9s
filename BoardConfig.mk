#
# Copyright (C) 2021 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/oppo/A57

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := msm8937

# Platform
TARGET_BOARD_PLATFORM := msm8937

# Inherit from common device tree
include device/oppo/thortanium-common/BoardConfigCommon.mk

# Init
TARGET_INIT_VENDOR_LIB := //$(DEVICE_PATH):init_oppo_A57
TARGET_RECOVERY_DEVICE_MODULES := init_oppo_A57

# Kernel
TARGET_KERNEL_CONFIG := lineageos_A57_defconfig
TARGET_KERNEL_RECOVERY_CONFIG := lineageos_A57_recovery_defconfig

# Properties
TARGET_VENDOR_PROP += $(DEVICE_PATH)/vendor.prop

# Security patch level
VENDOR_SECURITY_PATCH := 2018-08-05
