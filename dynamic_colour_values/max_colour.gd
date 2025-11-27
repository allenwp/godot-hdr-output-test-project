@tool
extends ColorRect

@export var sdr_colour: Color


func _process(_delta: float) -> void:
	# Adjust the brightness of color to be the brightest possible, regardless
	# of SDR or HDR output.
	color = normalize_color(sdr_colour, get_window().get_output_max_linear_value())


func normalize_color(srgb_color: Color, max_linear_value: float = 1.0) -> Color:
	# Color must be linear-encoded to use math operations correctly.
	var linear_color: Color = srgb_color.srgb_to_linear()
	var max_color_channel: float = maxf(linear_color.r, maxf(linear_color.g, linear_color.b))
	var brightness_scale: float = max_linear_value / max_color_channel
	var normalized_color: Color = linear_color  * brightness_scale
	# The alpha channel value should not be affected by normalization.
	normalized_color.a = linear_color.a
	# Convert back to nonlinear sRGB encoding, which is required for Color in
	# Godot unless stated otherwise.
	return normalized_color.linear_to_srgb()
