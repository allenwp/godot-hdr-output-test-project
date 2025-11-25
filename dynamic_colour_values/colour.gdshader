shader_type canvas_item;
render_mode unshaded;

uniform vec3 colour;

void fragment() {
	COLOR = vec4(colour.rgb, 1.0);
}
