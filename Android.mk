#
# Copyright (C) 2021 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

LOCAL_PATH := $(call my-dir)

ifeq ($(TARGET_DEVICE),R9s)

include $(call all-makefiles-under,$(LOCAL_PATH))

include $(CLEAR_VARS)

# Create a mount point for MTP ACDB calibration files
ACDB_MTP_MOUNT_POINT := $(TARGET_OUT_VENDOR)/etc/acdbdata/MTP
$(ACDB_MTP_MOUNT_POINT): $(LOCAL_INSTALLED_MODULE)
	@echo "Creating $(ACDB_MTP_MOUNT_POINT)"
	@mkdir -p $(TARGET_OUT_VENDOR)/etc/acdbdata/MTP

ALL_DEFAULT_INSTALLED_MODULES += $(ACDB_MTP_MOUNT_POINT)

endif
