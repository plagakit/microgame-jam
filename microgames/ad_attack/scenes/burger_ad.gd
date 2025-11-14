extends TextureRect


func _ready() -> void:
	pass # Replace with function body.


var phi = 0
func _process(delta: float) -> void:
	phi += delta * 10
	$"10Mil".rotation_degrees = remap(-1, 1, -15, 5, rad_to_deg(sin(phi)))
