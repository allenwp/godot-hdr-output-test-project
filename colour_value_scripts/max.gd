@tool
extends MeshInstance2D


func _process(_delta: float) -> void:
	var window: Window = get_window()
	var sm = material as ShaderMaterial
	var max_val: float = window.get_output_max_value()
	sm.set_shader_parameter("colour", Vector3(max_val, max_val, max_val))
