extends CharacterBody2D
var distance = 0
var rotateVal = 0
@export var speed = 150.0
@export var move_speed = 400.0
@export var explosion : PackedScene
var move_velocity = 0
var color = Color(0.5,0.5,0.5)
var brightness = 1.0

var diamond : CharacterBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	distance = randf_range(400, 1200)
	rotateVal = randf_range(0, 360)
	rotation_degrees = rotateVal
	position.x += sin(deg_to_rad(rotateVal)) * distance
	position.y += cos(deg_to_rad(rotateVal)) * distance
	rotation_degrees = 270 - rotateVal + randf_range(-45, 45)

func get_input():
	var input_direction = Input.get_vector("keyboard_left", "keyboard_right", "keyboard_up", "keyboard_down")
	move_velocity = input_direction * move_speed

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	get_input()
	velocity = transform.x * speed - move_velocity
	move_and_slide()
	
func _process(_delta):
	brightness = max(0, (200 - sqrt((640 - position.x) * (640 - position.x) + (360 - position.y) * (360 - position.y))) / 200)
	color = Color(brightness,brightness,brightness)
	modulate = color
	if diamond.dead:
		move_speed = 0

func _on_area_2d_body_entered(body):
	create_explosion_at(body)
	#print("ded")
	body.dead = true
	body.scale = Vector2.ZERO

func create_explosion_at(_thing : Node2D):
	var inst = explosion.instantiate() as Sprite2D
	add_child(inst)
