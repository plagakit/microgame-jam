shader_type canvas_item;

varying vec4 modulate;
uniform vec2 scroll_speed = vec2(0.8, 0.1);

void vertex() {
	modulate = COLOR;
}

void fragment() {
    vec2 uv = UV + scroll_speed * TIME;
    COLOR = texture(TEXTURE, uv);
	COLOR = modulate * COLOR;
}