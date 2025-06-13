extends Control


func _on_min_h_slider_value_changed(value: float) -> void:
	%SweepMinLabel.text = "%+0.2f stops (linear %0.5f)" % [value, pow(2, value)]
	%MaxHSlider.min_value = value;
	var sm: ShaderMaterial = %ColourSweepMesh.material as ShaderMaterial
	sm.set_shader_parameter("log2_min", value)


func _on_max_h_slider_value_changed(value: float) -> void:
	%SweepMaxLabel.text = "%+0.2f stops (linear %0.5f)" % [value, pow(2, value)]
	%MinHSlider.max_value = value;
	var sm: ShaderMaterial = %ColourSweepMesh.material as ShaderMaterial
	sm.set_shader_parameter("log2_max", value)


func _on_clip_to_max_toggled(toggled_on: bool) -> void:
	var sm: ShaderMaterial = %ColourSweepMesh.material as ShaderMaterial
	sm.set_shader_parameter("clip", toggled_on)
	sm.set_shader_parameter("clip_value", get_window().hdr_output_max_luminance)
