extends VBoxContainer

func _process(_delta: float) -> void:
	var high_precision: bool = get_window().hdr_output_prefer_high_precision
	if %PreferHighPrecision.button_pressed != high_precision:
		%PreferHighPrecision.button_pressed = high_precision


func _on_prefer_high_precision_toggled(toggled_on: bool) -> void:
	get_window().hdr_output_prefer_high_precision = toggled_on
