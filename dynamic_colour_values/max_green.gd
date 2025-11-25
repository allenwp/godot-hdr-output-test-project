@tool
extends ColorRect

func _process(_delta: float) -> void:
	var window: Window = get_window()
	color = Color(0, window.get_output_max_linear_value(), 0).linear_to_srgb()
