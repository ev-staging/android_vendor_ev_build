# Target-specific configuration

# Set device-specific HALs into project pathmap
define set-device-specific-path
$(if $(USE_DEVICE_SPECIFIC_$(1)), \
    $(if $(DEVICE_SPECIFIC_$(1)_PATH), \
        $(eval path := $(DEVICE_SPECIFIC_$(1)_PATH)), \
        $(eval path := $(TARGET_DEVICE_DIR)/$(2))), \
    $(eval path := $(3))) \
$(call project-set-path,qcom-$(2),$(strip $(path)))
endef

ifeq ($(BOARD_USES_QCOM_HARDWARE),true)
    BOARD_USES_QTI_HARDWARE := true
endif

ifeq ($(BOARD_USES_QTI_HARDWARE),true)

    A_FAMILY := msm7x27a msm7x30 msm8660 msm8960
    B_FAMILY := msm8226 msm8610 msm8974
    B64_FAMILY := msm8992 msm8994
    BR_FAMILY := msm8909 msm8916
    UM_3_18_FAMILY := msm8937 msm8953 msm8996
    UM_4_4_FAMILY := msm8998 sdm660
    UM_4_9_FAMILY := sdm845 sdm710
    UM_4_14_FAMILY := msmnile sm6150
    UM_PLATFORMS := $(UM_3_18_FAMILY) $(UM_4_4_FAMILY) $(UM_4_9_FAMILY) $(UM_4_14_FAMILY)

    BOARD_USES_ADRENO := true

    # UM platforms no longer need this set on O+
    ifneq ($(TARGET_USES_AOSP),true)
        ifneq ($(filter $(B_FAMILY) $(B64_FAMILY) $(BR_FAMILY),$(TARGET_BOARD_PLATFORM)),)
            TARGET_USES_QCOM_BSP := true
        endif
    endif

    # Tell HALs that we're compiling an AOSP build with an in-line kernel
    TARGET_COMPILE_WITH_MSM_KERNEL := true

    ifeq ($(call is-board-platform-in-list, $(A_FAMILY)),true)
        # Enable legacy audio functions
        ifeq ($(BOARD_USES_LEGACY_ALSA_AUDIO),true)
            ifneq ($(filter msm8960,$(TARGET_BOARD_PLATFORM)),)
                USE_CUSTOM_AUDIO_POLICY := 1
            endif
        endif
    endif

    # Enable media extensions
    TARGET_USES_MEDIA_EXTENSIONS := true

    # Allow building audio encoders
    TARGET_USES_QCOM_MM_AUDIO := true

    # Enable color metadata for every UM targets
    ifneq ($(filter $(UM_PLATFORMS),$(TARGET_BOARD_PLATFORM)),)
        TARGET_USES_COLOR_METADATA := true
    endif

    # Enable DRM PP driver on UM platforms that support it
    ifneq ($(filter $(UM_4_9_FAMILY) $(UM_4_14_FAMILY),$(TARGET_BOARD_PLATFORM)),)
        TARGET_USES_DRM_PP := true
    endif

    # Mark GRALLOC_USAGE_PRIVATE_WFD as valid gralloc bits
    TARGET_ADDITIONAL_GRALLOC_10_USAGE_BITS ?= 0
    TARGET_ADDITIONAL_GRALLOC_10_USAGE_BITS += | (1 << 10)
    TARGET_ADDITIONAL_GRALLOC_10_USAGE_BITS += | (1 << 13)
    TARGET_ADDITIONAL_GRALLOC_10_USAGE_BITS += | (1 << 21)

    # Mark GRALLOC_USAGE_PRIVATE_10BIT_TP as valid gralloc bits on UM platforms that support it
    ifneq ($(filter $(UM_4_9_FAMILY) $(UM_4_14_FAMILY),$(TARGET_BOARD_PLATFORM)),)
        TARGET_ADDITIONAL_GRALLOC_10_USAGE_BITS += | (1 << 27)
    endif

    # List of targets that use master side content protection
    MASTER_SIDE_CP_TARGET_LIST := msm8996 msm8998 sdm660 sdm845 sm6150 msmnile

    # Every qcom platform is considered a vidc target
    MSM_VIDC_TARGET_LIST := $(TARGET_BOARD_PLATFORM)

    ifneq ($(filter $(A_FAMILY),$(TARGET_BOARD_PLATFORM)),)
        QCOM_HARDWARE_VARIANT := msm8960
    else ifneq ($(filter $(B_FAMILY),$(TARGET_BOARD_PLATFORM)),)
        QCOM_HARDWARE_VARIANT := msm8974
    else ifneq ($(filter $(B64_FAMILY),$(TARGET_BOARD_PLATFORM)),)
        QCOM_HARDWARE_VARIANT := msm8994
    else ifneq ($(filter $(BR_FAMILY),$(TARGET_BOARD_PLATFORM)),)
        QCOM_HARDWARE_VARIANT := msm8916
    else ifneq ($(filter $(UM_3_18_FAMILY),$(TARGET_BOARD_PLATFORM)),)
        QCOM_HARDWARE_VARIANT := msm8996
        TARGET_USES_QCOM_UM_FAMILY := true
        TARGET_USES_QCOM_UM_3_18_FAMILY := true
    else ifneq ($(filter $(UM_4_4_FAMILY),$(TARGET_BOARD_PLATFORM)),)
        QCOM_HARDWARE_VARIANT := msm8998
        TARGET_USES_QCOM_UM_FAMILY := true
        TARGET_USES_QCOM_UM_4_4_FAMILY := true
    else ifneq ($(filter $(UM_4_9_FAMILY),$(TARGET_BOARD_PLATFORM)),)
        QCOM_HARDWARE_VARIANT := sdm845
        TARGET_USES_QCOM_UM_FAMILY := true
        TARGET_USES_QCOM_UM_4_9_FAMILY := true
    else ifneq ($(filter $(UM_4_14_FAMILY),$(TARGET_BOARD_PLATFORM)),)
        QCOM_HARDWARE_VARIANT := sm8150
        TARGET_USES_QCOM_UM_FAMILY := true
        TARGET_USES_QCOM_UM_4_14_FAMILY := true
    else
        QCOM_HARDWARE_VARIANT := $(TARGET_BOARD_PLATFORM)
    endif

$(call set-device-specific-path,AUDIO,audio,hardware/qcom-caf/$(QCOM_HARDWARE_VARIANT)/audio)
$(call set-device-specific-path,DISPLAY,display,hardware/qcom-caf/$(QCOM_HARDWARE_VARIANT)/display)
$(call set-device-specific-path,MEDIA,media,hardware/qcom-caf/$(QCOM_HARDWARE_VARIANT)/media)

$(call set-device-specific-path,BT_VENDOR,bt-vendor,hardware/qcom-caf/bt)
$(call set-device-specific-path,DATA_IPA_CFG_MGR,data-ipa-cfg-mgr,vendor/qcom/opensource/data-ipa-cfg-mgr)
$(call set-device-specific-path,DATASERVICES,dataservices,vendor/qcom/opensource/commonsys/dataservices)
$(call set-device-specific-path,THERMAL,thermal,hardware/qcom-caf/thermal)
$(call set-device-specific-path,VR,vr,hardware/qcom-caf/vr)
$(call set-device-specific-path,WLAN,wlan,hardware/qcom-caf/wlan)

PRODUCT_SOONG_NAMESPACES += \
    hardware/qcom-caf/$(QCOM_HARDWARE_VARIANT)

PRODUCT_CFI_INCLUDE_PATHS += \
    hardware/qcom-caf/wlan/qcwcn/wpa_supplicant_8_lib

endif
