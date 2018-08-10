_contents := $(_contents)    "Evervolv":{$(newline)

# See build/core/soong_config.mk for the add_json_* functions you can use here.
$(call add_json_bool, Has_legacy_camera_hal1,                $(filter true,$(TARGET_HAS_LEGACY_CAMERA_HAL1)))
$(call add_json_bool, Has_legacy_mmap,                       $(filter true,$(BOARD_USES_LEGACY_MMAP)))
$(call add_json_bool, Needs_egl_khr_workaround,              $(filter true,$(BOARD_EGL_WORKAROUND_BUG_10194508)))
$(call add_json_bool, Needs_non_pie_support,                 $(filter true,$(TARGET_NEEDS_NON_PIE_SUPPORT)))
$(call add_json_bool, Needs_prelink_support,                 $(filter true,$(TARGET_NEEDS_PRELINK_SUPPORT)))
$(call add_json_bool, Needs_text_relocations,                $(filter true,$(TARGET_NEEDS_PLATFORM_TEXT_RELOCATIONS)))
$(call add_json_str,  Target_shim_libs,                      $(subst $(space),:,$(TARGET_LD_SHIM_LIBS)))
$(call add_json_bool, Uses_media_extensions,                 $(filter true,$(TARGET_USES_MEDIA_EXTENSIONS)))

# This causes the build system to strip out the last comma in our nested struct, to keep the JSON valid.
_contents := $(_contents)__SV_END

_contents := $(_contents)    },$(newline)
