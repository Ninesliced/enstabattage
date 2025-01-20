extends Control

func set_player_name(player_name: String):
	%Name.text = player_name

func set_rank(rank: int):
	%Rank.text = str(rank) + "."

func set_score(score: int):
	%Score.text = str(score)
