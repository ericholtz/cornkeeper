shader_type canvas_item;
uniform sampler2D existing_screen_texture: hint_screen_texture;

void fragment(){
	vec4 color = texture(existing_screen_texture, UV);
	COLOR = vec4(color.r, color.g / 2.0, color.b / 2.0, color.a);
}