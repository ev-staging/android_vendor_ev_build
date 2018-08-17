package android

// Global config used by Evervolv soong additions
var EvervolvConfig = struct {
	// List of packages that are permitted
	// for java source overlays.
	JavaSourceOverlayModuleWhitelist []string
}{
	// JavaSourceOverlayModuleWhitelist
	[]string{
		"com.evervolv.hardware",
	},
}
