extends Node
var money = 0

var menu_manager_file = preload("res://scenes/ui/menu_manager.tscn")
var menu_manager: MenuManager

func _ready() -> void:
	menu_manager = menu_manager_file.instantiate()
	add_child(menu_manager)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func add_money(amount):
	money += amount
