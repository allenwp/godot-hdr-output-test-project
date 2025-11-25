@tool
extends ColorRect

@export var sdr_colour: Color


func _process(_delta: float) -> void:
	var bright_colour = sdr_colour
	# Color must be linear-encoded to use math operations correctly.
	bright_colour = bright_colour.srgb_to_linear()
	# Record the original alpha value.
	var original_alpha = bright_colour.a
	# Adjust brightness to be the brightest possible, regardless of SDR or HDR output.
	bright_colour = bright_colour * get_window().get_output_max_linear_value()
	# Restore the original alpha channel value.
	bright_colour.a = original_alpha
	# Convert back to nonlinear sRGB encoding.
	bright_colour = bright_colour.linear_to_srgb()
	color = bright_colour
