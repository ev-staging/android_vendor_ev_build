package android
type Product_variables struct {
	Additional_gralloc_10_usage_bits struct {
		Cppflags []string
	}

	Has_legacy_camera_hal1 struct {
		Cflags []string
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

	Needs_text_relocations struct {
		Cppflags []string
	}

	Target_shim_libs struct {
		Cppflags []string
	}

	Uses_media_extensions struct {
		Cflags []string
	}
}

type ProductVariables struct {
	Additional_gralloc_10_usage_bits  *string `json:",omitempty"`
	Has_legacy_camera_hal1  *bool `json:",omitempty"`
	Has_legacy_mmap  *bool `json:",omitempty"`
	Needs_egl_khr_workaround  *bool `json:",omitempty"`
	Needs_non_pie_support  *bool `json:",omitempty"`
	Needs_prelink_support  *bool `json:",omitempty"`
	Needs_text_relocations  *bool `json:",omitempty"`
	Target_shim_libs  *string `json:",omitempty"`
	Uses_media_extensions   *bool `json:",omitempty"`
}
