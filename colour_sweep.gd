extends Control

var clip_to_max_lum: bool = false


func _process(_delta: float) -> void:
	var window: Window = get_window()
	var sm: ShaderMaterial = %ColourSweepMesh.material as ShaderMaterial
	sm.set_shader_parameter("clip_to_max", clip_to_max_lum)
	var max_value: float = 1.0
	if window.hdr_output_enabled:
		max_value = window.hdr_output_max_luminance / window.hdr_output_reference_luminance
	sm.set_shader_parameter("max_value", max_value);
	sm.set_shader_parameter("clip_in_bt2020", window.hdr_output_enabled)
	%SweepMinLabel.text = "%+0.2f (linear %0.5f, %0.0f nits)" % [%MinHSlider.value, pow(2, %MinHSlider.value), pow(2, %MinHSlider.value) * get_window().hdr_output_reference_luminance]
	%SweepMaxLabel.text = "%+0.2f (linear %0.5f, %0.0f nits)" % [%MaxHSlider.value, pow(2, %MaxHSlider.value), pow(2, %MaxHSlider.value) * get_window().hdr_output_reference_luminance]


func _on_min_h_slider_value_changed(value: float) -> void:
	%MaxHSlider.min_value = value;
	var sm: ShaderMaterial = %ColourSweepMesh.material as ShaderMaterial
	sm.set_shader_parameter("log2_min", value)


func _on_max_h_slider_value_changed(value: float) -> void:
	%MinHSlider.max_value = value;
	var sm: ShaderMaterial = %ColourSweepMesh.material as ShaderMaterial
	sm.set_shader_parameter("log2_max", value)


func _on_clip_to_max_toggled(toggled_on: bool) -> void:
	clip_to_max_lum = toggled_on
