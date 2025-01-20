extends Menu

func _on_continue_pressed():
	var text: String = %LineEdit.text
	var is_valid = Leaderboard.is_name_valid(text)
	if not is_valid:
		if text.length() == 0:
			%ErrorInfo.text = "Nom vide"
		else:
			%ErrorInfo.text = "Nom invalide. Utilisez des lettres, chiffres et tirets."
		return

	Leaderboard.change_player_name(text)
	Global.restart()