extends Menu

func _on_continue_pressed():
	%ErrorInfo.text = ""

	var text: String = %LineEdit.text
	if text.length() == 0:
		%ErrorInfo.text = "Nom vide."
		return

	var re = RegEx.new()
	re.compile("^[A-Za-zÀ-ÖØ-öø-ÿ0-9_-]+$")
	var result = re.search(text)
	if not result:
		%ErrorInfo.text = "Nom invalide. Lettres, chiffres et tirets uniquement."
		return

	Leaderboard.change_player_name(text)
	Global.restart()