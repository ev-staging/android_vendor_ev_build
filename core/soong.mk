PATH_OVERRIDE_SOONG := $(shell echo $(TOOLS_PATH_OVERRIDE))

# Add variables that we wish to make available to soong here.
EXPORT_TO_SOONG := \
    KERNEL_ARCH \
    KERNEL_CROSS_COMPILE \
    KERNEL_MAKE_CMD \
    KERNEL_MAKE_FLAGS \
    PATH_OVERRIDE_SOONG \
    TARGET_KERNEL_CONFIG \
    TARGET_KERNEL_SOURCE

# Setup SOONG_CONFIG_* vars to export the vars listed above.
# Documentation here:
# https://github.com/Evervolv/android_build_soong/commit/8328367c44085b948c003116c0ed74a047237a69

SOONG_CONFIG_NAMESPACES += evervolvVarsPlugin

SOONG_CONFIG_evervolvVarsPlugin :=

define addVar
  SOONG_CONFIG_evervolvVarsPlugin += $(1)
  SOONG_CONFIG_evervolvVarsPlugin_$(1) := $$(subst ",\",$$($1))
endef

$(foreach v,$(EXPORT_TO_SOONG),$(eval $(call addVar,$(v))))

SOONG_CONFIG_NAMESPACES += evervolvGlobalVars
SOONG_CONFIG_evervolvGlobalVars += \
    additional_gralloc_10_usage_bits \
    has_legacy_camera_hal1 \
    target_init_vendor_lib \
    target_ld_shim_libs \
    target_process_sdk_version_override \
    target_surfaceflinger_fod_lib

SOONG_CONFIG_NAMESPACES += evervolvQcomVars
SOONG_CONFIG_evervolvQcomVars += \
    device_support_wait_for_qsee \
    device_support_hw_fde \
    device_support_hw_fde_perf \
    uses_qcom_bsp_legacy \
    uses_qti_camera_device

# Only create soong_namespace var if dealing with UM platforms to avoid breaking build for all other platforms
ifneq ($(filter $(UM_PLATFORMS),$(TARGET_BOARD_PLATFORM)),)
SOONG_CONFIG_evervolvQcomVars += \
    qcom_soong_namespace
endif

# Set default values
TARGET_HAS_LEGACY_CAMERA_HAL1 ?= false
TARGET_KEYMASTER_WAIT_FOR_QSEE ?= false
TARGET_HW_DISK_ENCRYPTION ?= false
TARGET_HW_DISK_ENCRYPTION_PERF ?= false
TARGET_USES_QCOM_BSP_LEGACY ?= false
TARGET_USES_QTI_CAMERA_DEVICE ?= false

# Soong bool variables
SOONG_CONFIG_evervolvGlobalVars_has_legacy_camera_hal1 := $(TARGET_HAS_LEGACY_CAMERA_HAL1)
SOONG_CONFIG_evervolvQcomVars_device_support_wait_for_qsee := $(TARGET_KEYMASTER_WAIT_FOR_QSEE)
SOONG_CONFIG_evervolvQcomVars_device_support_hw_fde := $(TARGET_HW_DISK_ENCRYPTION)
SOONG_CONFIG_evervolvQcomVars_device_support_hw_fde_perf := $(TARGET_HW_DISK_ENCRYPTION_PERF)
SOONG_CONFIG_evervolvQcomVars_uses_qcom_bsp_legacy := $(TARGET_USES_QCOM_BSP_LEGACY)
SOONG_CONFIG_evervolvQcomVars_uses_qti_camera_device := $(TARGET_USES_QTI_CAMERA_DEVICE)

# Set default values
TARGET_ADDITIONAL_GRALLOC_10_USAGE_BITS ?= 0
TARGET_INIT_VENDOR_LIB ?= vendor_init
TARGET_SURFACEFLINGER_FOD_LIB ?= surfaceflinger_fod_lib

# Soong value variables
SOONG_CONFIG_evervolvGlobalVars_additional_gralloc_10_usage_bits := $(TARGET_ADDITIONAL_GRALLOC_10_USAGE_BITS)
SOONG_CONFIG_evervolvGlobalVars_target_init_vendor_lib := $(TARGET_INIT_VENDOR_LIB)
SOONG_CONFIG_evervolvGlobalVars_target_ld_shim_libs := $(subst $(space),:,$(TARGET_LD_SHIM_LIBS))
SOONG_CONFIG_evervolvGlobalVars_target_process_sdk_version_override := $(TARGET_PROCESS_SDK_VERSION_OVERRIDE)
SOONG_CONFIG_evervolvGlobalVars_target_surfaceflinger_fod_lib := $(TARGET_SURFACEFLINGER_FOD_LIB)
SOONG_CONFIG_evervolvQcomVars_qcom_soong_namespace := $(if $(filter $(UM_PLATFORMS),$(TARGET_BOARD_PLATFORM)),$(QCOM_SOONG_NAMESPACE),)
