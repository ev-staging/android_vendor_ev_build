add_json_str_omitempty = $(if $(strip $(2)),$(call add_json_str, $(1), $(2)))

_contents := $(_contents)    "Evervolv":{$(newline)

# See build/core/soong_config.mk for the add_json_* functions you can use here.
$(call add_json_str_omitempty, Additional_gralloc_10_usage_bits, $(TARGET_ADDITIONAL_GRALLOC_10_USAGE_BITS))
$(call add_json_bool, Device_support_hwfde, $(filter true,$(TARGET_HW_DISK_ENCRYPTION)))
$(call add_json_bool, Device_support_hwfde_perf, $(filter true,$(TARGET_HW_DISK_ENCRYPTION_PERF)))
$(call add_json_bool, Device_support_legacy_hwfde, $(filter true,$(TARGET_LEGACY_HW_DISK_ENCRYPTION)))
$(call add_json_bool, Has_legacy_camera_hal1, $(filter true,$(TARGET_HAS_LEGACY_CAMERA_HAL1)))
$(call add_json_bool, Has_legacy_mmap, $(filter true,$(BOARD_USES_LEGACY_MMAP)))
$(call add_json_bool, Needs_egl_khr_workaround, $(filter true,$(BOARD_EGL_WORKAROUND_BUG_10194508)))
$(call add_json_bool, Needs_non_pie_support, $(filter true,$(TARGET_NEEDS_NON_PIE_SUPPORT)))
$(call add_json_bool, Needs_prelink_support, $(filter true,$(TARGET_NEEDS_PRELINK_SUPPORT)))
$(call add_json_str_omitempty, Target_process_sdk_version_override, $(TARGET_PROCESS_SDK_VERSION_OVERRIDE))
$(call add_json_str_omitempty, Target_shim_libs, $(TARGET_LD_SHIM_LIBS))
$(call add_json_bool, Uses_media_extensions, $(filter true,$(TARGET_USES_MEDIA_EXTENSIONS)))
$(call add_json_bool, Uses_qcom_bsp_legacy, $(filter true,$(TARGET_USES_QCOM_BSP_LEGACY)))

# This causes the build system to strip out the last comma in our nested struct, to keep the JSON valid.
_contents := $(_contents)__SV_END

_contents := $(_contents)    },$(newline)
