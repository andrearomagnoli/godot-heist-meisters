extends Popup

var combination = []
var guess = []
var status_light_red = preload("res://GFX/Interface/PNG/dotRed.png")
var status_light_green = preload("res://GFX/Interface/PNG/dotGreen.png")

onready var display = $VBoxContainer/DisplayContainer/Display
onready var light = $VBoxContainer/ButtonContainer/GridContainer/StatusLight
onready var grid_container = $VBoxContainer/ButtonContainer/GridContainer
onready var audio = $AudioStreamPlayer
onready var status_light = $VBoxContainer/ButtonContainer/GridContainer/StatusLight
onready var timer = $Timer

signal combination_correct


func _ready():
	connect_buttons()
	reset_lock()


func connect_buttons():
	for child in grid_container.get_children():
		if child is Button:
			child.connect('pressed', self, 'Button_pressed', [child.text])


func Button_pressed(button):
	if button == 'ok':
		check_guess()
	else:
		enter(int(button))
		audio.stream = load('res://SFX/twoTone1.ogg')
		audio.play()


func check_guess():
	if guess == combination:
		audio.stream = load('res://SFX/threeTone1.ogg')
		audio.play()
		status_light.texture = status_light_green
		timer.start()		
	else:
		audio.stream = load('res://SFX/twoTone1.ogg')
		audio.play()
		reset_lock()


func enter(button):
	guess.append(button)
	update_display()


func update_display():
	display.text = PoolStringArray(guess).join('')


func reset_lock():
	status_light.texture = status_light_red
	display.text == ''
	guess.clear()
	update_display()


func _on_Timer_timeout():
	emit_signal('combination_correct')
	reset_lock()
