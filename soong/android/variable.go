package android
type Product_variables struct {
	Additional_gralloc_10_usage_bits struct {
		Cppflags []string
	}

	Device_support_hwfde struct {
		Cflags []string
		Header_libs []string
		Shared_libs []string
	}

	Device_support_hwfde_perf struct {
		Cflags []string
	}

	Device_support_wait_for_qsee struct {
		Cflags []string
	}

	Force_virtual_partitions struct {
		Cflags []string
	}

	Has_legacy_camera_hal1 struct {
		Cflags []string
		Overrides []string
		Shared_libs []string
	}

	Has_legacy_mmap struct {
		Cppflags []string
	}

	Needs_egl_khr_workaround struct {
		Cflags []string
	}

	Needs_non_pie_support struct {
		Cppflags []string
	}

	Needs_prelink_support struct {
		Cppflags []string
	}

	Qcom_um_soong_namespace struct {
		Cflags []string
		Header_libs []string
	}

	Target_init_vendor_lib struct {
		Whole_static_libs []string
	}

	Target_process_sdk_version_override struct {
		Cppflags []string
	}

	Target_shim_libs struct {
		Cppflags []string
	}

	Target_surfaceflinger_fod_lib struct {
		Cflags []string
		Whole_static_libs []string
	}

	Uses_media_extensions struct {
		Cflags []string
	}

	Uses_qcom_bsp_legacy struct {
		Cppflags []string
	}

	Uses_qti_camera_device struct {
		Cppflags []string
		Shared_libs []string
	}
}

type ProductVariables struct {
	Additional_gralloc_10_usage_bits  *string `json:",omitempty"`
	Device_support_hwfde  *bool `json:",omitempty"`
	Device_support_hwfde_perf  *bool `json:",omitempty"`
	Device_support_wait_for_qsee  *bool `json:",omitempty"`
	Force_virtual_partitions  *bool `json:",omitempty"`
	Has_legacy_camera_hal1  *bool `json:",omitempty"`
	Has_legacy_mmap  *bool `json:",omitempty"`
	Needs_egl_khr_workaround  *bool `json:",omitempty"`
	Needs_non_pie_support  *bool `json:",omitempty"`
	Needs_prelink_support  *bool `json:",omitempty"`
	Qcom_um_soong_namespace  *string `json:",omitempty"`
	Target_init_vendor_lib  *string `json:",omitempty"`
	Target_process_sdk_version_override *string `json:",omitempty"`
	Target_shim_libs  *string `json:",omitempty"`
	Uses_media_extensions   *bool `json:",omitempty"`
	Uses_qcom_bsp_legacy  *bool `json:",omitempty"`
	Uses_qti_camera_device  *bool `json:",omitempty"`
}
