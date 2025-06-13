extends Control

const HDR_SETTINGS_FILE = "user://hdr_settings.cfg"
const HDR_SETTINGS_SECTION = "HDR"

func _is_hdr_supported(window: Window) -> bool:
	return DisplayServer.has_feature(DisplayServer.FEATURE_HDR) \
		&& RenderingServer.get_rendering_device().has_feature(RenderingDevice.SUPPORTS_HDR_OUTPUT) \
		&& DisplayServer.window_is_hdr_output_supported(window.get_window_id())


func _on_visibility_changed() -> void:
	if visible:
		process_mode = Node.PROCESS_MODE_INHERIT
	else:
		process_mode = Node.PROCESS_MODE_DISABLED


func _ready() -> void:
	var window: Window = get_window()
	var hdr_settings: ConfigFile = ConfigFile.new()
	if hdr_settings.load(HDR_SETTINGS_FILE) == OK:
		window.hdr_output_enabled = hdr_settings.get_value(HDR_SETTINGS_SECTION, "hdr_output_enabled", window.hdr_output_enabled)
		window.hdr_output_auto_adjust_reference_luminance = hdr_settings.get_value(HDR_SETTINGS_SECTION, "hdr_output_auto_adjust_reference_luminance", window.hdr_output_auto_adjust_reference_luminance)
		if !window.hdr_output_auto_adjust_reference_luminance:
			window.hdr_output_reference_luminance = hdr_settings.get_value(HDR_SETTINGS_SECTION, "hdr_output_reference_luminance", window.hdr_output_reference_luminance)
		window.hdr_output_auto_adjust_max_luminance = hdr_settings.get_value(HDR_SETTINGS_SECTION, "hdr_output_auto_adjust_max_luminance", window.hdr_output_auto_adjust_max_luminance)
		if !window.hdr_output_auto_adjust_max_luminance:
			window.hdr_output_max_luminance = hdr_settings.get_value(HDR_SETTINGS_SECTION, "hdr_output_max_luminance", window.hdr_output_max_luminance)


func save_settings() -> void:
	var window: Window = get_window()
	var hdr_settings: ConfigFile = ConfigFile.new()
	hdr_settings.set_value(HDR_SETTINGS_SECTION, "hdr_output_enabled", window.hdr_output_enabled)
	if window.hdr_output_enabled:
		hdr_settings.set_value(HDR_SETTINGS_SECTION, "hdr_output_auto_adjust_reference_luminance", window.hdr_output_auto_adjust_reference_luminance)
		if !window.hdr_output_auto_adjust_reference_luminance:
			hdr_settings.set_value(HDR_SETTINGS_SECTION, "hdr_output_reference_luminance", window.hdr_output_reference_luminance)
		hdr_settings.set_value(HDR_SETTINGS_SECTION, "hdr_output_auto_adjust_max_luminance", window.hdr_output_auto_adjust_max_luminance)
		if !window.hdr_output_auto_adjust_max_luminance:
			hdr_settings.set_value(HDR_SETTINGS_SECTION, "hdr_output_max_luminance", window.hdr_output_max_luminance)
	hdr_settings.save(HDR_SETTINGS_FILE)


func erase_settings() -> void:
	var hdr_settings: ConfigFile = ConfigFile.new()
	if hdr_settings.load(HDR_SETTINGS_FILE) == OK:
		hdr_settings.erase_section(HDR_SETTINGS_SECTION)
		hdr_settings.save(HDR_SETTINGS_FILE)

func _process(_delta: float) -> void:
	var window: Window = get_window()
	var hdr_supported := _is_hdr_supported(window)
	%HDRCheckButton.disabled = !hdr_supported

	var hdr_output_enabled: bool = window.hdr_output_enabled
	if %HDRCheckButton.button_pressed != hdr_output_enabled:
		%HDRCheckButton.button_pressed = hdr_output_enabled
	%HDROptions.visible = hdr_output_enabled && hdr_supported
	
	%BrightnessSlider.value = window.hdr_output_reference_luminance
	%BrightnessSlider.max_value = window.hdr_output_max_luminance
	%BrightnessLabel.text = "%d" % window.hdr_output_reference_luminance
	
	%MaxLumSlider.value = window.hdr_output_max_luminance
	$%MaxLumSlider.min_value = window.hdr_output_reference_luminance
	%MaxLumLabel.text = "%d" % window.hdr_output_max_luminance
	
	%ResetBrightness.disabled = window.hdr_output_auto_adjust_reference_luminance
	%ResetMaxLum.disabled = window.hdr_output_auto_adjust_max_luminance


func _on_hdr_check_button_toggled(toggled_on: bool) -> void:
	# Request HDR output to the display.
	get_window().hdr_output_enabled = toggled_on


func _on_brightness_slider_value_changed(value: float) -> void:
	get_window().hdr_output_reference_luminance = value


func _on_max_lum_slider_value_changed(value: float) -> void:
	get_window().hdr_output_max_luminance = value


func _on_reset_brightness_pressed() -> void:
	get_window().hdr_output_auto_adjust_reference_luminance = true


func _on_reset_max_lum_pressed() -> void:
	get_window().hdr_output_auto_adjust_max_luminance = true


func _on_brightness_slider_drag_started() -> void:
	get_window().hdr_output_auto_adjust_reference_luminance = false


func _on_max_lum_slider_drag_started() -> void:
	get_window().hdr_output_auto_adjust_max_luminance = false
