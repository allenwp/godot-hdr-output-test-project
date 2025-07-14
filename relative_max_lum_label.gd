@tool
extends Label

@export var mesh: RelativeMaxLumMaterial


func _process(_delta: float) -> void:
	var relative_stops: float = mesh.relative_stops
	var window: Window = get_window()
	var max_val: float = window.get_hdr_output_max_value()
	var adjusted_max_val: float = pow(2.0, (log(max_val) / log(2.0)) + relative_stops)
	text = "%+0.2f (linear %0.2f, %0.0f nits)" % [relative_stops, adjusted_max_val, adjusted_max_val * window.hdr_output_reference_luminance]
