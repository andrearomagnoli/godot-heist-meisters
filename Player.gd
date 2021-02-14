extends "res://Characters/TemplateCharacter.gd"

var motion = Vector2()
var disguised = false
#var torch_on = true

onready var sprite = $Sprite
onready var collider = $CollisionShape2D
onready var occluder = $LightOccluder2D

onready var player_texture = load("res://GFX/PNG/Hitman 1/hitman1_stand.png")
onready var box_texture = load("res://GFX/PNG/Tiles/tile_130.png")
onready var human_occluder = load("res://Characters/HumanOccluder.tres")
onready var human_collider = load("res://Characters/HumanCollider.tres")
onready var box_occluder = load("res://Characters/BoxOccluder.tres")
onready var box_collider = load("res://Characters/BoxCollider.tres")


func _physics_process(delta):
	update_movement()
	motion = move_and_slide(motion)


func _input(event):
	vision_mode_toggle()
	toggle_disguise()
#	toggle_torch()


func update_movement():
	
	look_at(get_global_mouse_position())
	
	if Input.is_action_pressed("move_down") and not Input.is_action_pressed("move_up"):
		motion.y = clamp(motion.y + SPEED, 0.0, MAX_SPEED)
	elif Input.is_action_pressed("move_up") and not Input.is_action_pressed("move_down"):
		motion.y = clamp(motion.y - SPEED, -MAX_SPEED, 0.0)
	else:
		motion.y = lerp(motion.y, 0.0, FRICTION)

	if Input.is_action_pressed("move_right") and not Input.is_action_pressed("move_left"):
		motion.x = clamp(motion.x + SPEED, 0.0, MAX_SPEED)
	elif Input.is_action_pressed("move_left") and not Input.is_action_pressed("move_right"):
		motion.x = clamp(motion.x - SPEED, -MAX_SPEED, 0.0)
	else:
		motion.x = lerp(motion.x, 0.0, FRICTION)


func vision_mode_toggle():
	if Input.is_action_just_pressed("toggle_vision_mode"):
		get_tree().call_group("Interface", "cycle_vision_mode")


func toggle_disguise():
	if Input.is_action_just_pressed("toggle_disguise"):
		if disguised:
			reveal()
		else:
			disguise()


func reveal():
	sprite.texture = player_texture
	collider.shape = human_collider
	occluder.occluder = human_occluder
	disguised = false
	collision_layer = 1


func disguise():
	sprite.texture = box_texture
	collider.shape = box_collider
	occluder.occluder = box_occluder
	disguised = true
	collision_layer = 16


func toggle_torch():
	if Input.is_action_just_pressed("toggle_torch"):
		$Torch.enabled = !$Torch.enabled
