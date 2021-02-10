extends "res://Doors/Door.gd"

onready var numpad = $CanvasLayer/Numpad
onready var timer = $Timer


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
