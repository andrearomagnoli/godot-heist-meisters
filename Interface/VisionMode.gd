extends CanvasModulate

const DARK = Color("111111")
const NIGHTVISION = Color("37bf62")

var is_button_active = true

onready var audio = $AudioStreamPlayer2D
onready var timer = $Cooldown


func _ready():
	visible = true
	color = DARK
	

func cycle_vision_mode():
	if is_button_active:
		if color == DARK:
			NIGHTVISION_mode()
		elif color == NIGHTVISION:
			DARK_mode()


func DARK_mode():
	color = DARK
	audio.stream = load("res://SFX/nightvision_off.wav")
	audio.play()
	timer.start()
	is_button_active = false
	


func NIGHTVISION_mode():
	color = NIGHTVISION
	audio.stream = load("res://SFX/nightvision.wav")
	audio.play()
	timer.start()
	is_button_active = false


func _on_Timer_timeout():
	is_button_active = true
