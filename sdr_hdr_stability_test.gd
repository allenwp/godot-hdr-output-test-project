extends Node2D


func _process(_delta: float) -> void:
	var window_id = get_window().get_window_id()
	var hdr_output_enabled: bool = DisplayServer.window_is_hdr_output_enabled(window_id)
	var ref_luminance = DisplayServer.window_get_hdr_output_reference_luminance()
	var max_luminance = DisplayServer.window_get_hdr_output_max_luminance()
	if hdr_output_enabled:
		%StabilityTestText.text = "HDR\nReference white luminance: %s\nMaximum luminance: %s" % [ref_luminance, max_luminance]
	else:
		%StabilityTestText.text = "SDR"


func _on_toggle_hdr_timer_timeout() -> void:
	var window = get_window()
	window.hdr_output_enabled = !window.hdr_output_enabled
