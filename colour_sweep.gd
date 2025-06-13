extends Control

var clip_to_max_lum: bool = false


func _process(_delta: float) -> void:
	var window: Window = get_window()
	var sm: ShaderMaterial = %ColourSweepMesh.material as ShaderMaterial
	sm.set_shader_parameter("clip", clip_to_max_lum)
	sm.set_shader_parameter("clip_value", window.hdr_output_max_luminance / window.hdr_output_reference_luminance)


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
	clip_to_max_lum = toggled_on
