extends Menu

func _on_continue_pressed():
	Global.menu_manager.exit_menu()


func _on_insta_pressed():
	OS.shell_open("https://www.instagram.com/enstavengers")


func _on_retry_pressed():
	Global.restart()
