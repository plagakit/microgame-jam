shader_type canvas_item;

uniform float shear_amount : hint_range(-2.0, 2.0) = 0;

void vertex() {
    VERTEX.x += VERTEX.y * shear_amount;
}