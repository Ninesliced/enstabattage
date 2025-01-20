extends Menu    


func _on_back_pressed():
	Global.menu_manager.back()



func _on_change_name_pressed():
	Global.menu_manager.set_menu("ChangeNameMenu")
