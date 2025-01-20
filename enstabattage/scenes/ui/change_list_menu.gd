extends Menu

@onready var team_option_button = %TeamOptionButton

func _on_continue_pressed():
	var option = team_option_button.selected
	if option <= 0:
		%ErrorInfo.text = "Choisissez une liste."
		return

	var team_name = team_option_button.get_item_text(option)

	Leaderboard.change_player_team(team_name)
	Global.menu_manager.back()


func _on_back_pressed():
	Global.menu_manager.back()
