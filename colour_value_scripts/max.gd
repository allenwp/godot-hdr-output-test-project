@tool
extends MeshInstance2D


func _process(_delta: float) -> void:
	var sm = material as ShaderMaterial
	if get_window().hdr_output_enabled:
		var max_val: float = get_window().hdr_output_max_luminance /  get_window().hdr_output_reference_luminance
		sm.set_shader_parameter("colour", Vector3(max_val, max_val, max_val))
	else:
		sm.set_shader_parameter("colour", Vector3(1,1,1))
