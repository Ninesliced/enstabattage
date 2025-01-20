extends Menu


func _ready():
	Leaderboard.player_get_name_completed.connect(_on_player_get_name_completed)

func _on_menu_set():
	Leaderboard.get_player_name()

func _on_player_get_name_completed(name):
	var full_name_list = Leaderboard._get_full_name(name, "", "")
	%Username.text = "{0}\n{1}".format(full_name_list)


func _on_continue_pressed():
	Global.menu_manager.exit_menu()

func _on_insta_pressed():
	OS.shell_open("https://www.instagram.com/enstavengers")

func _on_retry_pressed():
	Global.restart()

func _on_leaderboards_pressed():
	Global.menu_manager.set_menu("LeaderboardMenu")

func _on_options_pressed():
	Global.menu_manager.set_menu("OptionsMenu")
