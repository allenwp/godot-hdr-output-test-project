@tool
extends MeshInstance2D


func _process(_delta: float) -> void:
	var window: Window = get_window()
	var sm = material as ShaderMaterial
	if window.hdr_output_enabled:
		var max_val: float = window.hdr_output_max_luminance /  window.hdr_output_reference_luminance
		sm.set_shader_parameter("colour", Vector3(max_val, max_val, max_val))
	else:
		sm.set_shader_parameter("colour", Vector3(1,1,1))
