extends Microgame

@export var ad_scenes : Array[PackedScene]

var ads : Array = []

@onready var creach := $Creachure
@onready var final := $FinalPos
@onready var thanks := $AudioStreamPlayer

func _ready() -> void:
	super()
	
	ads = []
	for i in range(4):
		var idx := randi_range(0, len(ad_scenes) - 1)
		var ad_scene := ad_scenes[idx]
		ad_scenes.remove_at(idx)
		
		var dupe := $Ad.duplicate() as Control
		add_child(dupe)
		
		var ad := ad_scene.instantiate() as Control
		dupe.get_child(0).add_child(ad)

		dupe.position = Vector2(
			randf_range(10, 640 - ad.size.x - 24),
			randf_range(10, 360 - ad.size.y - 24)
		)
		dupe.pivot_offset = (ad.size + Vector2(24, 24)) / 2
		
		var btn := dupe.get_child(1) as Button
		btn.pressed.connect(on_x_pressed.bind(btn))
		ads.append(dupe)

func win():
	win_game.emit()
	
	thanks.play()
	create_tween().tween_property(creach, ^"position", final.position, 2) \
					.set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_OUT)

func on_x_pressed(btn: Button) -> void:
	btn.disabled = true
	
	var ad := btn.get_parent()
	var t := create_tween()
	t.tween_property(ad, "modulate", Color.TRANSPARENT, 0.08)
	t.set_parallel()
	t.tween_property(ad, "scale", Vector2(0.95, 0.95), 0.08)
	t.set_parallel(false)
	t.tween_callback(ad.queue_free)
	ads.remove_at(ads.find(ad))

	if ads.is_empty():
		win()
