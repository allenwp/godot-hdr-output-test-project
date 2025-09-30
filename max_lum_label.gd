@tool
extends Label


func _process(_delta: float) -> void:
	var window: Window = get_window()
	var max_val: float = window.get_output_max_value()
	text = "Max luminance\n%+0.2f stops\nlinear %0.2f\n%0.0f nits" % [log(max_val) / log(2), max_val, max_val * window.hdr_output_reference_luminance]
