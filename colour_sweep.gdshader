shader_type canvas_item;
render_mode unshaded;

uniform float log2_min = -5.0;
uniform float log2_max = 5.0;
uniform bool clip = false;
uniform float clip_value = 10;

void fragment() {
	vec3 color;
	float top_bar = 0.02;
	float log2_value = UV.x * (log2_max - log2_min) - abs(log2_min);
	float scale = pow(2.0, log2_value);

	if (UV.y >= top_bar)
	{
		float padding = 0.005;
		float y = (UV.y - top_bar - padding) / (1.0 - top_bar - padding * 2.0);
		y = clamp(y, 0.0, 1.0);
		float segments = 1.0 / 6.0;
		vec3 col = vec3(0);
		if (y < segments)
		{
			col.r = 1.0;
			col.g = y / segments;
			col.b = 0.0;
		}
		else if (y < segments * 2.0)
		{
			col.r = (y - segments * 2.0) / -segments;
			col.g = 1.0;
			col.b = 0.0;
		}
		else if (y < segments * 3.0)
		{
			col.r = 0.0;
			col.g = 1.0;
			col.b = (y - segments * 2.0) / segments;
		}
		else if (y < segments * 4.0)
		{
			col.r = 0.0;
			col.g = (y - segments * 4.0) / -segments;
			col.b = 1.0;
		}
		else if (y < segments * 5.0)
		{
			col.r = (y - segments * 4.0) / segments;
			col.g = 0.0;
			col.b = 1.0;
		}
		else
		{
			col.r = 1.0;
			col.g = 0.0;
			col.b = (y - segments * 6.0) / -segments;
		}

		color = col * scale;
	}
	else
	{
		color = vec3(1.0) * scale;
	}
	
	if (clip) {
		color = min(color, clip_value);
	}

	COLOR = vec4(color.rgb, 1.0);
}
