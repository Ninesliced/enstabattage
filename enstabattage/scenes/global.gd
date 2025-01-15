extends Node
var money = 0

var menu_manager_file = preload("res://scenes/ui/menu_manager.tscn")
var menu_manager: MenuManager

var is_authticated = false

func _ready() -> void:
	process_mode = PROCESS_MODE_ALWAYS

	menu_manager = menu_manager_file.instantiate()
	add_child(menu_manager)

	menu_manager.set_menu("AutheticatingMenu")

	print("Autheticating...")
	Leaderboard.authenticated.connect(_on_autheticated)
	Leaderboard.authenticate()

func _on_autheticated(data):
	print("Autheticated.")
	if not data.has("player_name") or data.player_name == "":
		menu_manager.set_menu("SetNameMenu")
	else:
		menu_manager.exit_menu()

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
