# Copyright (C) 2015 The CyanogenMod Project
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

#
# Rules for running apicheck to confirm that you haven't broken
# api compatibility or added apis illegally.
#

# skip api check for PDK buid
ifeq (,$(filter true, $(WITHOUT_CHECK_API) $(TARGET_BUILD_PDK) $(TARGET_DISABLE_EVERVOLV_SDK)))

.PHONY: checkapi-evervolv

# Run the checkapi rules by default.
droidcore: checkapi-evervolv

# Validate against previous release platform sdk version api text within prebuilts
evervolv_last_released_sdk_version := $(EV_PLATFORM_SDK_VERSION)

.PHONY: check-evervolv-public-api
checkapi-evervolv : check-evervolv-public-api

.PHONY: update-evervolv-api

# INTERNAL_EVERVOLV_PLATFORM_API_FILE is the one build by droiddoc.
# Note that since INTERNAL_EVERVOLV_PLATFORM_API_FILE  is the byproduct of api-stubs module,
# (See evervolv-sdk/Android.mk)
# we need to add api-stubs as additional dependency of the api check.

$(INTERNAL_EVERVOLV_PLATFORM_API_FILE): evervolv-api-stubs-docs

# Check that the API we're building hasn't broken the last-released
# SDK version.
$(eval $(call check-api, \
    checkpublicapi-evervolv-last, \
    $(EVERVOLV_SRC_API_DIR)/$(evervolv_last_released_sdk_version).txt, \
    $(INTERNAL_EVERVOLV_PLATFORM_API_FILE), \
    $(FRAMEWORK_EVERVOLV_PLATFORM_REMOVED_API_FILE), \
    $(INTERNAL_EVERVOLV_PLATFORM_REMOVED_API_FILE), \
    -hide 2 -hide 3 -hide 4 -hide 5 -hide 6 -hide 24 -hide 25 -hide 26 -hide 27 \
    -error 7 -error 8 -error 9 -error 10 -error 11 -error 12 -error 13 -error 14 -error 15 \
    -error 16 -error 17 -error 18 , \
    cat $(FRAMEWORK_EVERVOLV_API_NEEDS_UPDATE_TEXT), \
    check-evervolv-public-api, \
    $(call doc-timestamp-for,evervolv-api-stubs) \
    ))

# Check that the API we're building hasn't changed from the not-yet-released
# SDK version.
$(eval $(call check-api, \
    checkpublicapi-evervolv-current, \
    $(FRAMEWORK_EVERVOLV_PLATFORM_API_FILE), \
    $(INTERNAL_EVERVOLV_PLATFORM_API_FILE), \
    $(FRAMEWORK_EVERVOLV_PLATFORM_REMOVED_API_FILE), \
    $(INTERNAL_EVERVOLV_PLATFORM_REMOVED_API_FILE), \
    -error 2 -error 3 -error 4 -error 5 -error 6 \
    -error 7 -error 8 -error 9 -error 10 -error 11 -error 12 -error 13 -error 14 -error 15 \
    -error 16 -error 17 -error 18 -error 19 -error 20 -error 21 -error 23 -error 24 \
    -error 25 -error 26 -error 27, \
    cat $(FRAMEWORK_EVERVOLV_API_NEEDS_UPDATE_TEXT), \
    check-evervolv-public-api, \
    $(call doc-timestamp-for,evervolv-api-stubs) \
    ))

.PHONY: update-evervolv-public-api
update-evervolv-public-api: $(INTERNAL_EVERVOLV_PLATFORM_API_FILE) | $(ACP)
	@echo "Copying evervolv_current.txt"
	$(hide) $(ACP) $(INTERNAL_EVERVOLV_PLATFORM_API_FILE) $(FRAMEWORK_EVERVOLV_PLATFORM_API_FILE)
	@echo "Copying evervolv_removed.txt"
	$(hide) $(ACP) $(INTERNAL_EVERVOLV_PLATFORM_REMOVED_API_FILE) $(FRAMEWORK_EVERVOLV_PLATFORM_REMOVED_API_FILE)

update-evervolv-api : update-evervolv-public-api

.PHONY: update-evervolv-prebuilts-latest-public-api
current_sdk_release_text_file := $(EVERVOLV_SRC_API_DIR)/$(evervolv_last_released_sdk_version).txt

update-evervolv-prebuilts-latest-public-api: $(FRAMEWORK_EVERVOLV_PLATFORM_API_FILE) | $(ACP)
	@echo "Publishing evervolv_current.txt as latest API release"
	$(hide) $(ACP) $(FRAMEWORK_EVERVOLV_PLATFORM_API_FILE) $(current_sdk_release_text_file)

endif
