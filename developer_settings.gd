extends VBoxContainer

func _process(_delta: float) -> void:
	var high_precision: bool = get_window().hdr_output_prefer_high_precision
	if %PreferHighPrecision.button_pressed != high_precision:
		%PreferHighPrecision.button_pressed = high_precision
	
	var window: Window = get_window()
	var adjustment_step_1 = 0.2
	var adjustment_step_2 = 0.4
	
	var max_lum: float = window.hdr_output_max_luminance / window.hdr_output_reference_luminance
	var sm: ShaderMaterial = %MaxLumAdjustBacking.material as ShaderMaterial
	sm.set_shader_parameter("colour", Vector3(max_lum, max_lum, max_lum))
	
	var max_adjust_material_value = pow(2.0, (log(max_lum) / log(2.0)) - adjustment_step_2)
	sm = %MaxLumAdjustBelow2.material as ShaderMaterial
	sm.set_shader_parameter("colour", Vector3(max_adjust_material_value, max_adjust_material_value, max_adjust_material_value))

	max_adjust_material_value = pow(2.0, (log(max_lum) / log(2.0)) - adjustment_step_1)
	sm = %MaxLumAdjustBelow3.material as ShaderMaterial
	sm.set_shader_parameter("colour", Vector3(max_adjust_material_value, max_adjust_material_value, max_adjust_material_value))
	
	max_adjust_material_value = pow(2.0, (log(max_lum) / log(2.0)) + adjustment_step_2)
	sm = %MaxLumAdjustAbove2.material as ShaderMaterial
	sm.set_shader_parameter("colour", Vector3(max_adjust_material_value, max_adjust_material_value, max_adjust_material_value))
	
	max_adjust_material_value = pow(2.0, (log(max_lum) / log(2.0)) + adjustment_step_1)
	sm = %MaxLumAdjustAbove3.material as ShaderMaterial
	sm.set_shader_parameter("colour", Vector3(max_adjust_material_value, max_adjust_material_value, max_adjust_material_value))
	
	#Examples:
	
	sm = %ExampleMaxLumAdjustBacking.material as ShaderMaterial
	sm.set_shader_parameter("colour", Vector3.ONE)
	
	max_adjust_material_value = pow(2.0, (log(1.0) / log(2.0)) - adjustment_step_2)
	sm = %ExampleMaxLumAdjustBelow.material as ShaderMaterial
	sm.set_shader_parameter("colour", Vector3(max_adjust_material_value, max_adjust_material_value, max_adjust_material_value))

	max_adjust_material_value = pow(2.0, (log(1.0) / log(2.0)) - adjustment_step_1)
	sm = %ExampleMaxLumAdjustBelow2.material as ShaderMaterial
	sm.set_shader_parameter("colour", Vector3(max_adjust_material_value, max_adjust_material_value, max_adjust_material_value))


func _on_prefer_high_precision_toggled(toggled_on: bool) -> void:
	get_window().hdr_output_prefer_high_precision = toggled_on
