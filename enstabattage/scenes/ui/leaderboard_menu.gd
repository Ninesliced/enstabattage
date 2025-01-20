extends Menu

var leaderboard_item_scene: PackedScene = preload("res://scenes/ui/leaderboard_item.tscn")

@onready var scores = %Scores

func _ready():
	Leaderboard.leaderboard_recieved.connect(_on_leaderboard_recieved)


func _on_menu_set():
	_clear_scores()
	Leaderboard.get_leaderboards()


func _on_leaderboard_recieved(data):
	_clear_scores()
	_load_leaderboards_from_data(data)


func _clear_scores():
	for child in scores.get_children():
		scores.remove_child(child)
		child.queue_free()

	
func _load_leaderboards_from_data(data):
	if not data.has("items"):
		return false
	
	for item in data.items:
		var leaderboard_item = leaderboard_item_scene.instantiate()
		leaderboard_item.parse_data(item)
		%Scores.add_child(leaderboard_item)


func _on_back_pressed():
	Global.menu_manager.back()
