extends Node2D

var can_click = false
var combination

export var combination_length = 4
export var lock_group = 'Default'

onready var popup = $CanvasLayer/ComputerPopup
onready var light = $Light2D
onready var label = $Label

signal combination

func _ready():
	generate_combination()
	emit_signal('combination', combination, lock_group)
	label.text = lock_group
	label.rect_rotation = -self.rotation_degrees


func generate_combination():
	combination = CombinationGenerator.generate_combination(combination_length)
	set_popup_text()


func set_popup_text():
	popup.set_text(combination)


func _on_Area2D_body_entered(body):
	can_click = true


func _on_Area2D_body_exited(body):
	can_click = false
	popup.hide()
	light.enabled = false


func _on_Area2D_input_event(viewport, event, shape_idx):
	if Input.is_mouse_button_pressed(BUTTON_LEFT) and can_click:
		popup.popup_centered()
		light.enabled = true
