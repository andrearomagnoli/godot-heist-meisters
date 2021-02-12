extends Popup

onready var display_label = $NinePatchRect/CenterContainer/NinePatchRect/Label

func set_text(combination):
	display_label.text = (
		"Will you stop forgetting your access code?! I've set it to " +
		PoolStringArray(combination).join("") +
		", but this is the very last time!")
