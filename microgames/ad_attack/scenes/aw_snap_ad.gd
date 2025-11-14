extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Circle.rotation += 6 * delta


func _on_timer_timeout() -> void:
	$Circle.visible = false
	$AwSnap.visible = true
