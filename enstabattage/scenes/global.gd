extends Node
var money = 0

var menu_manager_file = preload("res://scenes/ui/menu_manager.tscn")
var menu_manager: MenuManager

func _ready() -> void:
	menu_manager = menu_manager_file.instantiate()
	add_child(menu_manager)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func add_money(amount):
	money += amount

func game_over():
	menu_manager.set_menu("GameOverMenu")
	Leaderboard.upload_score(money)

func restart():
	money = 0
	menu_manager.exit_menu()
	get_tree().reload_current_scene()
