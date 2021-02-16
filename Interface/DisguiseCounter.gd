extends ItemList

onready var box_texture = load("res://GFX/PNG/Tiles/tile_129.png")


func update_disguises(number):
	clear()
	for disguise in range(number):
		add_icon_item(box_texture, false)
