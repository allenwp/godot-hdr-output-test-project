@tool
extends Label


func _process(_delta: float) -> void:
	var window: Window = get_window()
	var window_id = get_window().get_window_id()
	var max_val: float = window.get_output_max_value()
	text = "Max luminance\n%+0.2f stops\nlinear %0.2f\n%0.0f nits" % [log(max_val) / log(2), max_val, max_val * DisplayServer.window_get_hdr_output_reference_luminance(window_id)]
