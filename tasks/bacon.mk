# Copyright (C) 2017 Unlegacy-Android
# Copyright (C) 2017 The LineageOS Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# -----------------------------------------------------------------
# Bacon update package
ifneq ($(TARGET_OTA_PACKAGE_NAME),)
OTA_PACKAGE_NAME := $(TARGET_OTA_PACKAGE_NAME)
else
OTA_PACKAGE_NAME := $(TARGET_PRODUCT)-ota-$(FILE_NAME_TAG)
endif

INTERNAL_BACON_PACKAGE := $(PRODUCT_OUT)/$(OTA_PACKAGE_NAME).zip

MD5 := prebuilts/build-tools/path/$(HOST_OS)-x86/md5sum

.PHONY: bacon
bacon: $(INTERNAL_OTA_PACKAGE_TARGET)
	$(hide) ln -f $(INTERNAL_OTA_PACKAGE_TARGET) $(INTERNAL_BACON_PACKAGE)
	$(hide) $(MD5) $(INTERNAL_BACON_PACKAGE) | sed "s|$(PRODUCT_OUT)/||" > $(INTERNAL_BACON_PACKAGE).md5sum
	@echo "Package Complete: $(INTERNAL_BACON_PACKAGE)" >&2
