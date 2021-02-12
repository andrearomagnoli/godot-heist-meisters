extends "res://Doors/Door.gd"

export var combination_length = 4

onready var numpad = $CanvasLayer/Numpad
onready var timer = $Timer
onready var label = $Label


func _ready():
	label.rect_rotation = -self.rotation_degrees


func _on_Door_body_exited(body):
	._on_Door_body_exited(body)
	if body.collision_layer == PLAYER:
		numpad.hide()


func _on_Door_input_event(viewport, event, shape_idx):
	if Input.is_mouse_button_pressed(BUTTON_LEFT) and can_click:
		numpad.popup_centered()


func _on_Numpad_combination_correct():
	open()
	numpad.hide()


func generate_combination():
	var combination = CombinationGenerator.generate_combination(combination_length)
	numpad.combination = combination
	print(str(combination))


func _on_Computer_combination(combination, lock_group):
	numpad.combination = combination
	label.text = lock_group
