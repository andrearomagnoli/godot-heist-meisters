extends "res://Characters/TemplateCharacter.gd"

var motion = Vector2()
var disguised = false
var velocity_multiplier = 1
#var torch_on = true

export var disguise_slowdown = 0.25
export var disguise_duration = 5
export var number_of_disguises = 3

onready var sprite = $Sprite
onready var light = $Light2D
onready var collider = $CollisionShape2D
onready var occluder = $LightOccluder2D
onready var timer = $Timer
onready var disguise_label = $DisguiseLabel

onready var player_texture = load("res://GFX/PNG/Hitman 1/hitman1_stand.png")
onready var player_light = load("res://GFX/PNG/Hitman 1/hitman1_stand.png")
onready var box_texture = load("res://GFX/PNG/Tiles/tile_130.png")
onready var box_light = load("res://GFX/PNG/Tiles/tile_130.png")
onready var human_occluder = load("res://Characters/HumanOccluder.tres")
onready var human_collider = load("res://Characters/HumanCollider.tres")
onready var box_occluder = load("res://Characters/BoxOccluder.tres")
onready var box_collider = load("res://Characters/BoxCollider.tres")


func _ready():
	timer.wait_time = disguise_duration
	get_tree().call_group('DisguiseDisplay', 'update_disguises', number_of_disguises)


func _physics_process(delta):
	
	update_movement()
	move_and_slide(motion * velocity_multiplier)
		
	if disguised:
		disguise_label.text = str(timer.time_left).pad_decimals(2)
		disguise_label.set_rotation(-rotation)


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
		elif number_of_disguises > 0:
			disguise()


func reveal():
	sprite.texture = player_texture
	light.texture = player_light
	collider.shape = human_collider
	occluder.occluder = human_occluder
	disguise_label.hide()
	
	velocity_multiplier = 1
	
	disguised = false
	collision_layer = 1


func disguise():
	sprite.texture = box_texture
	light.texture = box_light
	collider.shape = box_collider
	occluder.occluder = box_occluder
	disguise_label.show()
	
	velocity_multiplier = disguise_slowdown
	
	disguised = true
	number_of_disguises -= 1
	get_tree().call_group('DisguiseDisplay', 'update_disguises', number_of_disguises)
	
	collision_layer = 16
	timer.start()


func collect_briefcase():
	var loot = Node.new()
	loot.set_name('Briefcase')
	add_child(loot)


func toggle_torch():
	if Input.is_action_just_pressed("toggle_torch"):
		$Torch.enabled = !$Torch.enabled
