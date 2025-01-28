extends Menu    


#func _process(delta):
#	var volume_val = %VolumeSlider.value
#	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear_to_db(volume_val))


func _on_back_pressed():
	Global.menu_manager.back()

func _on_change_name_pressed():
	Global.menu_manager.set_menu("ChangeNameMenu")


func _on_change_list_pressed():
	Global.menu_manager.set_menu("ChangeListMenu")


func _on_reset_name_pressed():
	Leaderboard.reset_name()
