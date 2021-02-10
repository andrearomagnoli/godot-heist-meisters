extends Area2D

const PLAYER = 1
const NPC = 4

onready var animation = $AnimationPlayer

var can_click = false


func _on_Door_body_entered(body):
	if body.collision_layer == PLAYER:
		can_click = true
	elif body.collision_layer == NPC:
		open()


func _on_Door_body_exited(body):
	if body.collision_layer == PLAYER:
		can_click = false


func _on_Door_input_event(viewport, event, shape_idx):
	if Input.is_mouse_button_pressed(BUTTON_LEFT) and can_click:
		open()


func open():
	animation.play("Open")
