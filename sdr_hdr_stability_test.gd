extends Node2D


func _ready() -> void:
	var window_id = get_window().get_window_id()
	DisplayServer.window_set_hdr_output_reference_luminance(180, window_id)
	DisplayServer.window_set_hdr_output_max_luminance(250, window_id)


func _process(_delta: float) -> void:
	var window = get_window()
	var window_id = window.get_window_id()
	var hdr_output_enabled: bool = DisplayServer.window_is_hdr_output_enabled(window_id)
	var ref_luminance = DisplayServer.window_get_hdr_output_current_reference_luminance()
	var max_luminance = DisplayServer.window_get_hdr_output_current_max_luminance()
	if hdr_output_enabled:
		%StabilityTestText.text = "HDR\nReference white luminance: %s" % [ref_luminance]
	else:
		%StabilityTestText.text = "SDR"
		if window.hdr_output_requested:
			%StabilityTestText.text += " (HDR requested)"


func _on_toggle_hdr_timer_timeout() -> void:
	var window = get_window()
	window.hdr_output_requested = !window.hdr_output_requested
