extends Control

var d = 0
func _process(delta: float) -> void:
	d += delta * 1.25
	$Guy/Sprite2D.position.x = sin(d + PI) * 50
	$Please.scale = Vector2.ONE * remap(abs(sin(d * 3)), 0, 1, 1, 1.1)


func _on_timer_timeout() -> void:
	$Guy/Sprite2D.flip_h = not $Guy/Sprite2D.flip_h
