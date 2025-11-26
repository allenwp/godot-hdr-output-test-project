@tool
class_name RelativeMaxLumMaterial extends MeshInstance2D

@export var relative_stops: float = 0


func _process(_delta: float) -> void:
	var window: Window = get_window()
	var sm = material as ShaderMaterial
	var max_val: float = window.get_output_max_value()
	
	var material_value: float = pow(2.0, (log(max_val) / log(2.0)) + relative_stops)
	sm.set_shader_parameter("colour", Vector3(material_value, material_value, material_value))
	
