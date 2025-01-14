extends ScrollContainer

@onready var tab_list = get_children()[0].get_children()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func unequiping(tab_name):
	for tal in tab_list:
		tal.unequip(tab_name)
