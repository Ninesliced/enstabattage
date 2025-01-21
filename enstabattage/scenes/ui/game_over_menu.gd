extends Menu

func _process(delta):
	%Score.text = "Vague: {0}".format([Global.round_number])

func _on_insta_pressed():
	OS.shell_open("https://www.instagram.com/enstavengers")


func _on_retry_pressed():
	Global.restart()


func _on_leaderboards_pressed():
	Global.menu_manager.set_menu("LeaderboardMenu")
